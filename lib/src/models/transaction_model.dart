import 'package:core/core.dart';

class TransactionModel {
  final String source, destination, signature;
  final int block;
  final String? blockTime;
  final double amount, amountUsd;

  bool get isSystemTransaction => amount == systemTransactionAmount;

  TransactionModel({
    required this.block,
    required this.source,
    required this.destination,
    required this.signature,
    required this.blockTime,
    required this.amount,
    required this.amountUsd,
  });
}

class TransactionsResponse {
  final List<TransactionModel> transactions;
  final String? lastSignature;
  final bool hasNext;

  TransactionsResponse({
    required this.transactions,
    this.lastSignature,
    required this.hasNext,
  });

  factory TransactionsResponse.fromTxDetails({
    required Iterable<TransactionDetails> details,
    required double? solUsdRate,
    required int? limit,
  }) {
    final transactions = List<TransactionDetails>.from(details).map((e) {
      final transaction = (e.transaction as ParsedTransaction);
      final message = transaction.message;
      return TransactionModel(
        source: message.accountKeys[0].pubkey,
        destination: message.accountKeys[1].pubkey,
        signature: transaction.signatures[0],
        block: e.slot,
        amount: lamportsToSol(getTxAmount(e.meta)),
        amountUsd: lamportsToSol(getTxAmount(e.meta)) * (solUsdRate ?? 0),
        blockTime: DateTime.fromMillisecondsSinceEpoch((e.blockTime ?? 0) * 1000).toIso8601String(),
      );
    }).toList();

    return TransactionsResponse(
      transactions: transactions,
      hasNext: details.length >= (limit ?? 40),
      lastSignature: transactions.last.signature,
    );
  }
}