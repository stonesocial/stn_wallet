import 'dart:convert';

import 'package:bip39/bip39.dart' as bip39;

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import '../models/export.dart';

const _maxRequestError = "type 'Null' is not a subtype of type 'Map<String, dynamic>' in type cast";
const failedToFetchExchangeRate = 'Failed to fetch exchange rate';
const maxRequestPerSecondReached = 'Max request/sec reached';
const userNotFoundOnBlockchain = 'User not found on blockchain';

const cachedCountKey = 'cached_count_key';

@singleton
class WalletService extends ClientEitherResponseHandler with RpcExceptionHandler {

  final ISecureStorage storage;
  final SolanaService solanaClient;
  final BasisHttpClient httpClient;

  BasisHttpClient get _httpClient => httpClient..urlBase = Defines.apiUrl;

  WalletService(this.storage, this.solanaClient, this.httpClient);

  Ed25519HDKeyPair? keyPair;
  double? solUsdRate;

  bool validateMnemonic(mnemonic) => bip39.validateMnemonic(mnemonic);

  String generateMnemonic() => bip39.generateMnemonic();

  Future<(Failure?, Ed25519HDKeyPair?)> getKeyPair({String? mnemonic}) async {
    try {
      if (mnemonic != null) {
        return (null, await Ed25519HDKeyPair.fromMnemonic(mnemonic));
      }

      final priKey = await storage.read<String?>(privateKey);

      if (priKey.$2 != null) {
        keyPair = await Ed25519HDKeyPair.fromMnemonic(priKey.$2!);

        return (null, keyPair);
      }

      return (priKey.$1, null);

    } catch (e) {
      return (CommonFailure(message: e.toString()), null);
    }
  }

  Future<Ed25519HDPublicKey?> getPubKey() async {
    if (keyPair != null) return keyPair!.publicKey;

    return null;
  }

  Future<(Failure?, double?)> getBalance(String pubKey) async {
    final result = await handle(
      solanaClient.solana.rpcClient.getBalance(pubKey, commitment: Commitment.confirmed),
    );
    if (result.$1 != null) return (result.$1!, null);

    return (null, result.$2!.value / lamportsPerSol);
  }

  Future<(Failure?, double?)> getSolToUsdRate() async {
    final client = httpClient;
    final response = await handle(
       (client..urlBase = Defines.coingeckoApiUrl).GET('simple/price?ids=solana&vs_currencies=usd'),
    );
    if (response.$2 != null) {
      if (response.$2!.statusCode == 200) {
        final data = json.decode(response.$2!.body);
        solUsdRate = data['solana']['usd'] as double?;

        return (null, solUsdRate);
      }

      return (null, .0);
    }

    return (const ServerFailure(message: failedToFetchExchangeRate), null);
  }

  Future<(Failure?, String?)> sendSol({
    required String destination,
    required double sol,
  }) async {
    final keyPair = await getKeyPair();

    if (keyPair.$2 != null) {
      final result = await solanaClient.sendSol(
        source: keyPair.$2!,
        destination: Ed25519HDPublicKey.fromBase58(destination),
        lamports: solToLamports(sol),
        memo: destination,
      );

      if (result.$1 != null) return (result.$1, null);

      return (null, result.$2);
    }

    return (keyPair.$1, null);
  }

  Future<(Failure?, TransactionsResponse?)> getTransactionsHistory({
    required String pubKey,
    String? before,
    int? limit,
  }) async {
    final (sigsErr, sigsResult) = await solanaClient.getSignaturesForAddress(pubKey: pubKey, limit: limit, before: before);
    if (sigsErr != null) return (sigsErr, null);
    final (trErr, txsResult) = await solanaClient.getMultipleTransactions(signatures: sigsResult!);
    if (trErr != null) {
      if (trErr.message == _maxRequestError) {
        return (const ServerFailure(message: maxRequestPerSecondReached), null);
      }

      if (trErr.message.contains('-32600')) {
        return (const ServerFailure(message: userNotFoundOnBlockchain), null);
      }

      return (trErr, null);
    }

    return (null, TransactionsResponse.fromTxDetails(details: txsResult!, solUsdRate: solUsdRate, limit: limit));
  }

  Future<(Failure?, ({int total, int received, int sent})?)> getTransactionsHistoryCount({
    required String pubKey,
  }) async {
    final (sigsErr, sigsResult) = await solanaClient.getSignaturesForAddress(pubKey: pubKey);
    if (sigsErr != null) return (sigsErr, null);
    final txCountResult = await solanaClient.getTransactionCount(signatures: sigsResult!, pubKey: pubKey);
    if (txCountResult.$1 != null) {
      if (txCountResult.$1!.message == _maxRequestError) {
        return (const ServerFailure(message: maxRequestPerSecondReached), null);
      }

      return (txCountResult.$1, null);
    }

    cacheCounts(txCountResult.$2!.total, txCountResult.$2!.received, txCountResult.$2!.sent);

    return (null, txCountResult.$2!);
  }

  Future<(Failure?, SocialMining?)> getSocialMining(
    String pubKey,
  ) async {
    final result = await handleClientEitherResponse(
      _httpClient.GET('wallet/$pubKey'),
    );

    if (result.$1 != null) return (result.$1, null);

    return (null, SocialMining.fromJson(result.$2!.data['data']));
  }

  //cache
  Future<void> cacheCounts(int total, int received, int sent) async {
    await storage.write(cachedCountKey, '$received***$sent***$total');
  }

  Future<(Failure?, ({int total, int received, int sent})?)> getCacheCounts() async {
    final result = await storage.read(cachedCountKey);
    final splitResult = result.$2.toString().split('***');
    if (result.$1 != null)  return (result.$1, null);

    if (result.$2 != null) {
      final received = int.parse(splitResult[0]);
      final sent = int.parse(splitResult[1]);
      final total = int.parse(splitResult[2]);

      return (null, (received: received, sent: sent, total: total));
    }

    return (null, null);
  }
}