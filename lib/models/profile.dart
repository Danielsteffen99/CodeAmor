enum Gender { male, female, }

class Profile {
  String uid;
  var name = "";
  var birthday = DateTime.parse("20000101");
  Gender gender = Gender.male;
  var description = "";
  var image = "";

  Profile(this.uid);

  Profile.full(
      this.uid,
      this.name,
      this.birthday,
      this.gender,
      this.description,
      this.image
      );
  }