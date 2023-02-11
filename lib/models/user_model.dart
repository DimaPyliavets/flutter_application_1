class UserModel {
  String uid;
  final String name;
  final String email;
  final String profileImageUrl;
  final String status;
  final List<String> favourites;

  UserModel({
    this.uid = '',
    required this.name,
    required this.email,
    required this.profileImageUrl,
    required this.status,
    required this.favourites,
  });

  Map<String, dynamic> toMyList() => {
        'uid': uid,
        'mame': name,
        'email': email,
        'image_profile': profileImageUrl,
        'status': status,
        'favourites': favourites,
      };

  static UserModel fromMyList(Map<String, dynamic> docs) => UserModel(
        uid: docs['uid'],
        name: docs['name'],
        email: docs['email'],
        profileImageUrl: docs['image_profile'],
        status: docs['status'],
        favourites: [],
      );
}
