// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TokenImpl _$$TokenImplFromJson(Map<String, dynamic> json) => _$TokenImpl(
      decimals: (json['decimals'] as num?)?.toInt(),
      balance: (json['balance'] as num?)?.toDouble(),
      name: json['name'] as String?,
      uri: json['uri'] as String?,
      symbol: json['symbol'] as String?,
      tokenAddress: json['tokenAddress'] as String?,
    );

Map<String, dynamic> _$$TokenImplToJson(_$TokenImpl instance) =>
    <String, dynamic>{
      'decimals': instance.decimals,
      'balance': instance.balance,
      'name': instance.name,
      'uri': instance.uri,
      'symbol': instance.symbol,
      'tokenAddress': instance.tokenAddress,
    };
