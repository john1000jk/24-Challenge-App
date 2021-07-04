import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twenty_four_game/models/user.dart';
import 'package:twenty_four_game/services/database.dart';

class Multiplayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamProvider<UserData>.value(
      value: DatabaseService(uid: user.uid).userData,
      child:  LobbyPortal(),
    );
  }
}

class LobbyPortal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return Scaffold(
          body: Container(
            child: Center(child: Text(Provider.of<UserData>(context).nickname)),
          ),
        );
  }
}