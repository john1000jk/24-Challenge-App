import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twenty_four_game/models/user.dart';
import 'package:twenty_four_game/screens/authenticate/authenticate.dart';
import 'package:twenty_four_game/services/database.dart';

class Multiplayer extends StatelessWidget {
  const Multiplayer({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser?>(context);

    // Multiplayer is the only feature that needs an account.
    if (user == null) {
      return const Authenticate();
    }

    return StreamProvider<UserData?>.value(
      value: DatabaseService(uid: user.uid).userData,
      initialData: null,
      child: const LobbyPortal(),
    );
  }
}

class LobbyPortal extends StatelessWidget {
  const LobbyPortal({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(child: Text(Provider.of<UserData?>(context)?.nickname ?? '')),
    );
  }
}