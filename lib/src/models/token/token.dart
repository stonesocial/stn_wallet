import 'package:dependencies/dependencies.dart';

part 'token.g.dart';

part 'token.freezed.dart';

@freezed
class Token with _$Token {
  const factory Token({
    required int? decimals,
    required double? balance,
    required String? name,
    required String? uri,
    required String? symbol,
    required String? tokenAddress,
  }) = _Token;

  const Token._();

  factory Token.init() => const Token(
    decimals: null,
    balance: null,
    name: null,
    uri: null,
    symbol: null,
    tokenAddress: null,
  );

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
}

