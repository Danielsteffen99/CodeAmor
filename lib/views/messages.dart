import 'package:codeamor/views/edit_profile.dart';
import 'package:codeamor/views/matches.dart';

import 'package:codeamor/views/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../application/services/profile_service.dart';
import '../application/services/user_service.dart';
import '../infrastructure/repositories/message_repository.dart';
import '../models/match_profile.dart';
import '../models/message.dart';
import '../state/profile_state.dart';

class Messages extends StatefulWidget {
  final MatchProfile matchProfile;

  const Messages({Key? key, required this.matchProfile}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  late final UserService userService;
  late final ProfileService profileService;
  late final MessageRepository messageRepository;
  late final TextEditingController messageController;
  List<Message> messages = [];

  @override
  void initState() {
    messageController = TextEditingController();
    userService = UserService(context);
    profileService = ProfileService(context);
    messageRepository = MessageRepository();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<Message>> _fetchMessages() async {
    return await messageRepository.getMessages(widget.matchProfile.match.id);
  }

  Future<void> sendMessage() async {
    var profile =
        Provider.of<ProfileState>(context, listen: false).getProfile();
    var message = Message(widget.matchProfile.match.id, profile.uid,
        DateTime.now(), messageController.text);
    await messageRepository.sendMessage(message);
    messageController.clear();
    setState(() {
      messages.add(message);
    });
  }

  bool isMessageFromMatch(String uid) {
    return widget.matchProfile.match.uid == uid;
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Message>> _future = _fetchMessages();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.matchProfile.profile.name),
          backgroundColor: Colors.orange,
        ),
        backgroundColor: Colors.orange[100],
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: _future.then((value) => messages = value),
                  builder: (context, AsyncSnapshot<List<Message>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      //messages = snapshot.data!;

                      return ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: messages.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: Column(
                              crossAxisAlignment:
                                  isMessageFromMatch(messages[index].senderUid)
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  color: isMessageFromMatch(messages[index].senderUid)
                                      ? Colors.white
                                      : Colors.orange,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "${messages[index]
                                          .message} \n ${messages[index]
                                          .timestamp.toString()}",
                                      style: TextStyle(
                                          fontSize: 14, color: isMessageFromMatch(messages[index].senderUid)
                                          ? Colors.black
                                          : Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: messageController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Skriv en besked ...',
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () => {sendMessage()},
                        child: const Text('Send')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
