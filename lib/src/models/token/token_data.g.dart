// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_data.dart';

// **************************************************************************
// BorshSerializableGenerator
// **************************************************************************

mixin _$TokenData {
  int get mintAuthorityOption => throw UnimplementedError();
  Ed25519HDPublicKey get mintAuthority => throw UnimplementedError();
  BigInt get supply => throw UnimplementedError();
  int get decimals => throw UnimplementedError();
  bool get isInitialized => throw UnimplementedError();
  int get freezeAuthorityOption => throw UnimplementedError();
  Ed25519HDPublicKey get freezeAuthority => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BU32().write(writer, mintAuthorityOption);
    const BPublicKey().write(writer, mintAuthority);
    const BU64().write(writer, supply);
    const BU8().write(writer, decimals);
    const BBool().write(writer, isInitialized);
    const BU32().write(writer, freezeAuthorityOption);
    const BPublicKey().write(writer, freezeAuthority);

    return writer.toArray();
  }
}

class _TokenData extends TokenData {
  _TokenData({
    required this.mintAuthorityOption,
    required this.mintAuthority,
    required this.supply,
    required this.decimals,
    required this.isInitialized,
    required this.freezeAuthorityOption,
    required this.freezeAuthority,
  }) : super._();

  @override
  final int mintAuthorityOption;
  @override
  final Ed25519HDPublicKey mintAuthority;
  @override
  final BigInt supply;
  @override
  final int decimals;
  @override
  final bool isInitialized;
  @override
  final int freezeAuthorityOption;
  @override
  final Ed25519HDPublicKey freezeAuthority;
}

class BTokenData implements BType<TokenData> {
  const BTokenData();

  @override
  void write(BinaryWriter writer, TokenData value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  TokenData read(BinaryReader reader) {
    return TokenData(
      mintAuthorityOption: const BU32().read(reader),
      mintAuthority: const BPublicKey().read(reader),
      supply: const BU64().read(reader),
      decimals: const BU8().read(reader),
      isInitialized: const BBool().read(reader),
      freezeAuthorityOption: const BU32().read(reader),
      freezeAuthority: const BPublicKey().read(reader),
    );
  }
}

TokenData _$TokenDataFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BTokenData().read(reader);
}
