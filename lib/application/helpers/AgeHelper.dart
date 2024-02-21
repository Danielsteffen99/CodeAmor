mixin AgeHelper {
  static int getAge(DateTime dt) {
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