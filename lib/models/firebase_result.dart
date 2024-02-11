class FirebaseResult<T> {
  late final bool success;
  late final T result;
  late final String error;

  FirebaseResult.error(this.error) {
    success = false;
  }

  FirebaseResult.success(this.result) {
    success = true;
    error = "";
  }
}