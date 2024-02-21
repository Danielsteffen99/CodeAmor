import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/message.dart';

class MessageRepository {
  final db = FirebaseFirestore.instance;

  Future<void> sendMessage(Message message) async {
    final payload = <String, dynamic>{
      "matchId": message.matchId,
      "senderUid": message.senderUid,
      "timestamp": message.timestamp,
      "message": message.message
    };
    await db.collection("messages").add(payload);
  }

  Future<List<Message>> getMessages(String matchId) async {
    var result = await db.collection("messages")
        .where("matchId", isEqualTo: matchId)
        .orderBy("timestamp")
        .get();

    List<Message> messages = [];

    for (var message in result.docs) {
      messages.add(Message(message["matchId"], message["senderUid"], DateTime.fromMillisecondsSinceEpoch((message['timestamp'] as Timestamp).millisecondsSinceEpoch), message["message"]));
    }

    return messages;
  }
}