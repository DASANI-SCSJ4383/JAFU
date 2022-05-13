
class Group{
  String _groupID;
  String _groupName;
  String _totalUser;

  get groupID => _groupID;
  set groupID(value) => _groupID = value;

  get groupName => _groupName;
  set groupName(value) => _groupName = value;

  get totalUser => _totalUser;
  set totalUser(value) => _totalUser = value;

  Group(
      {
        dynamic groupID,
        String groupName = '',
        String totalUser = '',
      }
  ) : _groupID = groupID,
      _groupName = groupName,
      _totalUser = totalUser;

  Group.copy(Group from)
      : this(
            groupID: from.groupID,
            groupName: from.groupName,
            totalUser: from.totalUser
      );

  Group.fromJson(Map<String, dynamic> json)
      : this(
          groupID: json['groupID'],
          groupName: json['groupName'],
          totalUser: json['totalUser'],
      );

  Map<String, dynamic> toJson() => {
        'groupID': groupID,
        'groupName': groupName,
        'totalUser': totalUser,
  };
}
