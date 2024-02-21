import 'package:codeamor/application/helpers/AgeHelper.dart';
import 'package:codeamor/application/services/swipe_service.dart';
import 'package:flutter/material.dart';
import '../../models/profile.dart';

class ProfileComponent extends StatelessWidget {
  final Profile profile;

  const ProfileComponent({Key? key, required this.profile}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => {Navigator.of(context).pop()},
        child: Container(
          margin: const EdgeInsets.fromLTRB(15, 30, 15, 30),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(profile.image),
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
                      "Navn: ${profile.name}",
                      style: const TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    Text(
                      "Alder: ${AgeHelper.getAge(profile.birthday)}",
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      "Beskrivelse: ${profile.description}",
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
