import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:stn_wallet/src/services/wallet_service.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart' hide test;
import 'package:bip39/bip39.dart' as bip39;

class MockSecureStorage extends Mock implements ISecureStorage {}
class MockSolanaService extends Mock implements SolanaService {}
class MockHttpClient extends Mock implements BasisHttpClient {}

void main() {
  late WalletService walletService;
  late MockSecureStorage mockStorage;
  late MockSolanaService mockSolanaService;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockStorage = MockSecureStorage();
    mockSolanaService = MockSolanaService();
    mockHttpClient = MockHttpClient();
    walletService = WalletService(mockStorage, mockSolanaService, mockHttpClient);
  });

  group('WalletService', () {
    test('validateMnemonic should return true for valid mnemonic', () {
      final mnemonic = bip39.generateMnemonic();
      final result = walletService.validateMnemonic(mnemonic);
      expect(result, true);
    });

    test('validateMnemonic should return false for invalid mnemonic', () {
      const mnemonic = 'invalid mnemonic phrase';
      final result = walletService.validateMnemonic(mnemonic);
      expect(result, false);
    });

    test('generateMnemonic should return a valid mnemonic', () {
      final result = walletService.generateMnemonic();
      expect(bip39.validateMnemonic(result), true);
    });

    test('getKeyPair should return Ed25519HDKeyPair from mnemonic', () async {
      final mnemonic = bip39.generateMnemonic();
      when(mockStorage.read<String?>('password_key')).thenAnswer((_) async => (null, 'mnemonic'));

      final (failure, keyPair) = await walletService.getKeyPair(mnemonic: mnemonic);

      expect(failure, isNull);
      expect(keyPair, isNotNull);
    });

    test('getBalance should return balance for given public key', () async {
      const pubKey = 'publicKey';
      const balance = 15000000000;
      when(mockSolanaService.solana.rpcClient.getBalance(pubKey, commitment: Commitment.confirmed))
        .thenAnswer((_) async => BalanceResult(context: Context(slot: BigInt.from(100000)), value: balance));

      final (failure, balanceResult) = await walletService.getBalance(pubKey);

      expect(failure, isNull);
      expect(balanceResult, balance);
    });

    test('sendSol should send SOL to destination and return transaction signature', () async {
      const destination = 'destinationPubKey';
      const sol = 1.5;
      final testKeyPair = await Ed25519HDKeyPair.random();

      when(walletService.getKeyPair()).thenAnswer((_) async => (null, testKeyPair));

      when(mockSolanaService.sendSol(
        source: testKeyPair,
        destination: Ed25519HDPublicKey.fromBase58(destination),
        lamports: solToLamports(sol),
        memo: destination,
      )).thenAnswer((_) async => (null, 'transactionSignature'));

      final (failure, txSig) = await walletService.sendSol(destination: destination, sol: sol);

      expect(failure, isNull);
      expect(txSig, 'transactionSignature');
    });
  });
}