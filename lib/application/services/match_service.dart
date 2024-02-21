import 'package:codeamor/infrastructure/repositories/match_repository.dart';
import 'package:codeamor/infrastructure/repositories/profile_repository.dart';
import 'package:codeamor/models/match_profile.dart';
import '../../models/match.dart';


class MatchService {
  var profileRepository = ProfileRepository();
  var matchRepository = MatchRepository();

  Future<List<MatchProfile>> getMatches(String uid) async {
    List<MatchProfile> result = [];
    var matches = await matchRepository.getMatches(uid);
    for (var match in matches) {
      var profile = await profileRepository.getProfile(match.uid);
      if (profile == null) continue;
      result.add(MatchProfile(match, profile));
    }
    return result;
  }
}