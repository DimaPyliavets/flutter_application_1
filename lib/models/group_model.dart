class GroupModel {
  final String groupName;
  final String groupIcon;
  final String admin;
  List<String> members;
  String groupId = '';
  final String recentMessege;
  final String recentMessegeSender;

  GroupModel(
      {required this.groupName,
      required this.groupIcon,
      required this.admin,
      this.groupId = '',
      required this.recentMessege,
      required this.recentMessegeSender,
      required this.members});

  static GroupModel fromMap(Map<String, dynamic> docs) => GroupModel(
        groupName: docs['groupName'],
        groupIcon: docs['groupIcon'],
        admin: docs['admin'],
        groupId: docs['groupId'],
        recentMessege: docs['recentMessege'],
        recentMessegeSender: docs['recentMessegeSender'],
        members: [],
      );

  Map<String, dynamic> toMap() => {
        'groupName': groupName,
        'groupIcon': groupIcon,
        'admin': admin,
        'groupId': groupId,
        'recentMessege': recentMessege,
        'recentMessegeSender': recentMessegeSender,
        'members': [],
      };
}
