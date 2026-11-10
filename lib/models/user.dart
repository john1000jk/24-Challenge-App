// Named AppUser so it doesn't clash with firebase_auth's User class.
class AppUser {
  final String uid;

  AppUser({required this.uid});
}

class UserData {
  final String uid;
  final String username;
  final String nickname;
  final int highScore;

  UserData({
    required this.uid,
    required this.username,
    required this.nickname,
    required this.highScore,
  });
}
