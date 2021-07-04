import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future updateUserData(String username, String nickname, int highScore) async {
    return await userCollection.document(uid).setData({
      'username': username,
      'nickname': nickname,
      'highScore': highScore,
    });
  }

  Future updateScore(int highScore) async {
    return await userCollection.document(uid).updateData({
      'highScore': highScore,
    });
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      username: snapshot.data['username'],
      nickname: snapshot.data['nickname'],
      highScore: snapshot.data['highScore'],
    );
  }

  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

}