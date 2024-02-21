import 'package:codeamor/application/services/match_service.dart';
import 'package:codeamor/models/match_profile.dart';
import 'package:flutter/material.dart';
import 'package:codeamor/infrastructure/repositories/match_repository.dart';
import 'package:provider/provider.dart';
import '../models/match.dart';

import '../state/profile_state.dart';

class Matches extends StatefulWidget {
  const Matches({Key? key}) : super(key: key);

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  late Future<List<Match>> _matchesFuture;
  late final MatchService matchService;

  @override
  void initState() {
    super.initState();
    matchService = MatchService();
  }

  Future<List<MatchProfile>> _fetchMatches() async {
    var uid = Provider.of<ProfileState>(context, listen: false).getProfile().uid;
    return await matchService.getMatches(uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Matches"),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.orange[100],
      body: FutureBuilder(
        future: _fetchMatches(),
        builder: (context, AsyncSnapshot<List<MatchProfile>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<MatchProfile> matches = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: matches.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(matches[index].profile.image),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}



