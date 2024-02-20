import 'dart:math';

import 'package:codeamor/application/services/profile_service.dart';
import 'package:codeamor/application/services/user_service.dart';

import '../../models/profile.dart';

class GenerateDummyDataService {
  ProfileService profileService;
  UserService userService;

  GenerateDummyDataService(this.profileService, this.userService);

  var descs = [
    "Jeg kan godt lide C#",
    "Swipe til højre her",
    "Skal vi kode en app?",
    "Hvad er to plus to?"
  ];

  var boyImages = [
    "https://firebasestorage.googleapis.com/v0/b/codea-6d3fa.appspot.com/o/profile_images%2Fkaalund.jpg?alt=media&token=4a71e22a-b194-4a8a-b62b-e211ba46fb80",
    "https://firebasestorage.googleapis.com/v0/b/codea-6d3fa.appspot.com/o/profile_images%2Fposty.jpg?alt=media&token=e3a0dfb5-f268-4672-9d14-c76f70015172",
    "https://firebasestorage.googleapis.com/v0/b/codea-6d3fa.appspot.com/o/profile_images%2Fdrake.jpg?alt=media&token=7fed8064-3900-4638-b5a2-c4101245762a"
  ];

  var girlImages = [
    "https://firebasestorage.googleapis.com/v0/b/codea-6d3fa.appspot.com/o/profile_images%2Fkrid.jpg?alt=media&token=93ce9e91-dd64-49de-a173-fcd25c6b14aa",
    "https://firebasestorage.googleapis.com/v0/b/codea-6d3fa.appspot.com/o/profile_images%2Fmedina.jpg?alt=media&token=ecf2643a-4abd-4c7d-995b-a1c9bf385774",
    "https://firebasestorage.googleapis.com/v0/b/codea-6d3fa.appspot.com/o/profile_images%2FBeyonce.jpg?alt=media&token=417956b4-f73a-49ff-a761-ad894975f6f7"
  ];

  var girlNames = [
    "Nanna",
    "Louise",
    "Julie",
    "Benedikte",
    "Trine",
    "Camilla"
  ];

  var boyNames = [
    "Peter",
    "Jesper",
    "Hans",
    "Frederik",
    "Thomas",
    "Michael"
  ];

  void generateData(int numberOfProfiles, int startIndex) async {
    for (var i = startIndex; i < numberOfProfiles + startIndex; i++) {
      var user = await userService.createUser("code$i@amor.dk", "Password123!");

      var gender = Gender.values[1];
      var uid = user.result.user!.uid;
      var desc = descs[Random().nextInt(descs.length)];
      var birthday = DateTime(2000, 1, 1).subtract(Duration(days: Random().nextInt(1000)));
      var name = "";
      var image = "";
      if (gender == Gender.male) {
        name = boyNames[Random().nextInt(boyNames.length)];
        image = boyImages[Random().nextInt(boyImages.length)];
      } else {
        name = girlNames[Random().nextInt(girlNames.length)];
        image = girlImages[Random().nextInt(girlImages.length)];
      }

      var profile = await profileService.createProfile(uid);
      var p = profile.result;
      p.gender = gender;
      p.name = name;
      p.birthday = birthday;
      p.image = image;
      p.description = desc;

      profileService.updateProfile(p);
    }
  }
}