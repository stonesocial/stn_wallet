// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_mining.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SocialMining _$SocialMiningFromJson(Map<String, dynamic> json) {
  return _SocialMining.fromJson(json);
}

/// @nodoc
mixin _$SocialMining {
  String get pubKey => throw _privateConstructorUsedError;
  num get stn => throw _privateConstructorUsedError;
  num get xp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SocialMiningCopyWith<SocialMining> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SocialMiningCopyWith<$Res> {
  factory $SocialMiningCopyWith(
          SocialMining value, $Res Function(SocialMining) then) =
      _$SocialMiningCopyWithImpl<$Res, SocialMining>;
  @useResult
  $Res call({String pubKey, num stn, num xp});
}

/// @nodoc
class _$SocialMiningCopyWithImpl<$Res, $Val extends SocialMining>
    implements $SocialMiningCopyWith<$Res> {
  _$SocialMiningCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pubKey = null,
    Object? stn = null,
    Object? xp = null,
  }) {
    return _then(_value.copyWith(
      pubKey: null == pubKey
          ? _value.pubKey
          : pubKey // ignore: cast_nullable_to_non_nullable
              as String,
      stn: null == stn
          ? _value.stn
          : stn // ignore: cast_nullable_to_non_nullable
              as num,
      xp: null == xp
          ? _value.xp
          : xp // ignore: cast_nullable_to_non_nullable
              as num,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SocialMiningImplCopyWith<$Res>
    implements $SocialMiningCopyWith<$Res> {
  factory _$$SocialMiningImplCopyWith(
          _$SocialMiningImpl value, $Res Function(_$SocialMiningImpl) then) =
      __$$SocialMiningImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String pubKey, num stn, num xp});
}

/// @nodoc
class __$$SocialMiningImplCopyWithImpl<$Res>
    extends _$SocialMiningCopyWithImpl<$Res, _$SocialMiningImpl>
    implements _$$SocialMiningImplCopyWith<$Res> {
  __$$SocialMiningImplCopyWithImpl(
      _$SocialMiningImpl _value, $Res Function(_$SocialMiningImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pubKey = null,
    Object? stn = null,
    Object? xp = null,
  }) {
    return _then(_$SocialMiningImpl(
      pubKey: null == pubKey
          ? _value.pubKey
          : pubKey // ignore: cast_nullable_to_non_nullable
              as String,
      stn: null == stn
          ? _value.stn
          : stn // ignore: cast_nullable_to_non_nullable
              as num,
      xp: null == xp
          ? _value.xp
          : xp // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SocialMiningImpl implements _SocialMining {
  const _$SocialMiningImpl(
      {required this.pubKey, required this.stn, required this.xp});

  factory _$SocialMiningImpl.fromJson(Map<String, dynamic> json) =>
      _$$SocialMiningImplFromJson(json);

  @override
  final String pubKey;
  @override
  final num stn;
  @override
  final num xp;

  @override
  String toString() {
    return 'SocialMining(pubKey: $pubKey, stn: $stn, xp: $xp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SocialMiningImpl &&
            (identical(other.pubKey, pubKey) || other.pubKey == pubKey) &&
            (identical(other.stn, stn) || other.stn == stn) &&
            (identical(other.xp, xp) || other.xp == xp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, pubKey, stn, xp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SocialMiningImplCopyWith<_$SocialMiningImpl> get copyWith =>
      __$$SocialMiningImplCopyWithImpl<_$SocialMiningImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SocialMiningImplToJson(
      this,
    );
  }
}

abstract class _SocialMining implements SocialMining {
  const factory _SocialMining(
      {required final String pubKey,
      required final num stn,
      required final num xp}) = _$SocialMiningImpl;

  factory _SocialMining.fromJson(Map<String, dynamic> json) =
      _$SocialMiningImpl.fromJson;

  @override
  String get pubKey;
  @override
  num get stn;
  @override
  num get xp;
  @override
  @JsonKey(ignore: true)
  _$$SocialMiningImplCopyWith<_$SocialMiningImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
