class Message {
  late final String matchId;
  late final String senderUid;
  late final String message;
  late final timestamp = DateTime.now();

  Message(this.matchId, this.senderUid, this.message);
}
