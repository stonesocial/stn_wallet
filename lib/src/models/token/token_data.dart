import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

part 'token_data.g.dart';

@BorshSerializable()
class TokenData with _$TokenData {
  factory TokenData({
    @BU32() required int mintAuthorityOption,
    @BPublicKey() required Ed25519HDPublicKey mintAuthority,
    @BU64() required BigInt supply,
    @BU8() required int decimals,
    @BBool() required bool isInitialized,
    @BU32() required int freezeAuthorityOption,
    @BPublicKey() required Ed25519HDPublicKey freezeAuthority,
  }) = _TokenData;

  const TokenData._();

  factory TokenData.fromBorsh(Uint8List data) => _$TokenDataFromBorsh(data);
}