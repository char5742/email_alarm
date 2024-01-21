import 'package:freezed_annotation/freezed_annotation.dart';

part 'config_model.freezed.dart';

@freezed
class Config with _$Config {
  @Assert('intervalInMinutes > 0', 'Interval must be greater than 0')
  const factory Config({
    @Default('') String specificSenders,
    @Default(1) int intervalInMinutes,
    @Default(3) int pastPeriodMultiplier,
  }) = _Config;
}
