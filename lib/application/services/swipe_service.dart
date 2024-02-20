import 'dart:math';

import '../../infrastructure/repositories/profile_repository.dart';
import '../../models/swipe_card.dart';
class SwipeService {
  var profileRepository = ProfileRepository();

  Future<List<SwipeCard>> getProfilesToSwipe(String uid) async {
    var profiles = await profileRepository.getCompatibleProfiles(uid);
    List<SwipeCard> swipeCards = [];
    for (var p in profiles) {
      var t = SwipeCard(name: p.name, age: calculateAge(p.birthday), imageUrl: p.image, description: p.description, uid: p.uid);
      swipeCards.add(t);
    }
    return swipeCards;
  }

  void likeProfile(String liker, String like) {

  }

  int calculateAge(DateTime dt) {
    var today = DateTime.now();
    final year = today.year - dt.year;
    final mth = today.month - dt.month;
    final days = today.day - dt.day;
    if(mth < 0){
      return year - 1;
    }
    else if (mth == 0) {
      if (days < 0) {
        return year - 1;
      } else {
        return year;
      }
    }
    else {
      return year;
    }
  }

}
