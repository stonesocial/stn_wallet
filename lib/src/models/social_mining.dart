import 'package:dependencies/dependencies.dart';

part 'social_mining.freezed.dart';
part 'social_mining.g.dart';

@freezed
class SocialMining with _$SocialMining {
  const factory SocialMining({
    required String pubKey,
    required num stn,
    required num xp,
  }) = _SocialMining;

  factory SocialMining.fromJson(Map<String, dynamic> json) => _$SocialMiningFromJson(json);
}