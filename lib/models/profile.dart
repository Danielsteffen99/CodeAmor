class Profile {
  String uid;
  var name = "";
  var birthday = DateTime.now();
  var gender = "";
  var description = "";
  var image = "";

  Profile(this.uid);

  Profile.full(
      this.uid,
      this.name,
      this.birthday,
      this.gender,
      this.description,
      this.image);
}