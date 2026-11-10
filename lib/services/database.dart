import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(
      String username, String nickname, int highScore) async {
    await userCollection.doc(uid).set({
      'username': username,
      'nickname': nickname,
      'highScore': highScore,
    });
  }

  Future<void> updateScore(int highScore) async {
    await userCollection.doc(uid).update({
      'highScore': highScore,
    });
  }

  UserData _userDataFromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data() ?? {};
    return UserData(
      uid: uid,
      username: data['username'] as String? ?? '',
      nickname: data['nickname'] as String? ?? '',
      highScore: data['highScore'] as int? ?? 0,
    );
  }

  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
