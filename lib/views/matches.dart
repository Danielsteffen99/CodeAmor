import 'package:flutter/material.dart';
import 'package:codeamor/infrastructure/repositories/match_repository.dart';

class Matches extends StatefulWidget {
  const Matches({Key? key}) : super(key: key);

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  late Future<List<String>> _matchesFuture;
  final MatchRepository matchRepository = MatchRepository();

  String? get likerUid => null;

  @override
  void initState() {
    super.initState();
    _matchesFuture = _fetchMatches();
  }

  Future<List<String>> _fetchMatches() async {
    var matches = await matchRepository.getMatches(likerUid);
    return matches;
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
        future: _matchesFuture,
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<String> matches = snapshot.data!;
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
                    backgroundImage: NetworkImage(matches[index]),
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



