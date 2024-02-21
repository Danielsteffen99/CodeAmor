import 'package:codeamor/application/helpers/AgeHelper.dart';
import 'package:codeamor/application/services/swipe_service.dart';
import 'package:codeamor/models/match_profile.dart';
import 'package:codeamor/views/messages.dart';
import 'package:flutter/material.dart';
import '../../models/profile.dart';

class ProfileComponent extends StatelessWidget {
  final MatchProfile matchProfile;

  const ProfileComponent({Key? key, required this.matchProfile}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => {Navigator.of(context).pop()},
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                height:
                    MediaQuery.of(context).size.height - kToolbarHeight * 2.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(matchProfile.profile.image),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Navn: ${matchProfile.profile.name}",
                        style:
                            const TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      Text(
                        "Alder: ${AgeHelper.getAge(matchProfile.profile.birthday)}",
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        "Beskrivelse: ${matchProfile.profile.description}",
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Messages(matchProfile: matchProfile),
                  ),
                )
              },
              child: const Text('Beskeder'),
            ),
          ]),
        ),
      ),
    );
  }
}
