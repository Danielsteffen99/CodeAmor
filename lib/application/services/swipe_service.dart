import 'package:codeamor/infrastructure/repositories/like_repository.dart';
import 'package:codeamor/infrastructure/repositories/match_repository.dart';
import '../../infrastructure/repositories/profile_repository.dart';
import '../../models/swipe_card.dart';
import '../helpers/AgeHelper.dart';

class SwipeService {
  var profileRepository = ProfileRepository();
  var likeRepository = LikeRepository();
  var matchRepository = MatchRepository();

  Future<List<SwipeCard>> getProfilesToSwipe(String uid) async {
    var profiles = await profileRepository.getCompatibleProfiles(uid);
    List<SwipeCard> swipeCards = [];
    for (var p in profiles) {
      var t = SwipeCard(name: p.name, age: AgeHelper.getAge(p.birthday), imageUrl: p.image, description: p.description, uid: p.uid);
      swipeCards.add(t);
    }
    return swipeCards;
  }

  Future<bool> likeProfile(String likerUid, String likedUid) async {
    likeRepository.createLike(likerUid, likedUid);

    var isLiked = await likeRepository.isLiked(likedUid, likerUid);
    if (!isLiked) return false;

    // We have a match!
    matchRepository.createMatches(likerUid, likedUid);
    return true;
  }

}
