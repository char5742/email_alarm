// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Config {
  String get specificSenders => throw _privateConstructorUsedError;
  int get intervalInMinutes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ConfigCopyWith<Config> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigCopyWith<$Res> {
  factory $ConfigCopyWith(Config value, $Res Function(Config) then) =
      _$ConfigCopyWithImpl<$Res, Config>;
  @useResult
  $Res call({String specificSenders, int intervalInMinutes});
}

/// @nodoc
class _$ConfigCopyWithImpl<$Res, $Val extends Config>
    implements $ConfigCopyWith<$Res> {
  _$ConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? specificSenders = null,
    Object? intervalInMinutes = null,
  }) {
    return _then(_value.copyWith(
      specificSenders: null == specificSenders
          ? _value.specificSenders
          : specificSenders // ignore: cast_nullable_to_non_nullable
              as String,
      intervalInMinutes: null == intervalInMinutes
          ? _value.intervalInMinutes
          : intervalInMinutes // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConfigImplCopyWith<$Res> implements $ConfigCopyWith<$Res> {
  factory _$$ConfigImplCopyWith(
          _$ConfigImpl value, $Res Function(_$ConfigImpl) then) =
      __$$ConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String specificSenders, int intervalInMinutes});
}

/// @nodoc
class __$$ConfigImplCopyWithImpl<$Res>
    extends _$ConfigCopyWithImpl<$Res, _$ConfigImpl>
    implements _$$ConfigImplCopyWith<$Res> {
  __$$ConfigImplCopyWithImpl(
      _$ConfigImpl _value, $Res Function(_$ConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? specificSenders = null,
    Object? intervalInMinutes = null,
  }) {
    return _then(_$ConfigImpl(
      specificSenders: null == specificSenders
          ? _value.specificSenders
          : specificSenders // ignore: cast_nullable_to_non_nullable
              as String,
      intervalInMinutes: null == intervalInMinutes
          ? _value.intervalInMinutes
          : intervalInMinutes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ConfigImpl implements _Config {
  const _$ConfigImpl({this.specificSenders = '', this.intervalInMinutes = 1})
      : assert(intervalInMinutes > 0, 'Interval must be greater than 0');

  @override
  @JsonKey()
  final String specificSenders;
  @override
  @JsonKey()
  final int intervalInMinutes;

  @override
  String toString() {
    return 'Config(specificSenders: $specificSenders, intervalInMinutes: $intervalInMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfigImpl &&
            (identical(other.specificSenders, specificSenders) ||
                other.specificSenders == specificSenders) &&
            (identical(other.intervalInMinutes, intervalInMinutes) ||
                other.intervalInMinutes == intervalInMinutes));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, specificSenders, intervalInMinutes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfigImplCopyWith<_$ConfigImpl> get copyWith =>
      __$$ConfigImplCopyWithImpl<_$ConfigImpl>(this, _$identity);
}

abstract class _Config implements Config {
  const factory _Config(
      {final String specificSenders,
      final int intervalInMinutes}) = _$ConfigImpl;

  @override
  String get specificSenders;
  @override
  int get intervalInMinutes;
  @override
  @JsonKey(ignore: true)
  _$$ConfigImplCopyWith<_$ConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
