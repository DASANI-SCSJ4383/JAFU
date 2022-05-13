
class Group{
  String _groupID;
  String _groupName;
  String _groupDescription;
  String _totalUser;

  get groupID => _groupID;
  set groupID(value) => _groupID = value;

  get groupName => _groupName;
  set groupName(value) => _groupName = value;

  get groupDescription => _groupDescription;
  set groupDescription(value) => _groupDescription = value;

  get totalUser => _totalUser;
  set totalUser(value) => _totalUser = value;

  Group(
      {
        dynamic groupID,
        String groupName = '',
        String groupDescription = '',
        String totalUser = '',
      }
  ) : _groupID = groupID,
      _groupName = groupName,
      _groupDescription = groupDescription,
      _totalUser = totalUser;

  Group.copy(Group from)
      : this(
            groupID: from.groupID,
            groupName: from.groupName,
            groupDescription: from.groupDescription,
            totalUser: from.totalUser
      );

  Group.fromJson(Map<String, dynamic> json)
      : this(
          groupID: json['groupID'],
          groupName: json['groupName'],
          groupDescription: json['groupDescription'],
          totalUser: json['totalUser'],
      );

  Map<String, dynamic> toJson() => {
        'groupID': groupID,
        'groupName': groupName,
        'groupDescription': groupDescription,
        'totalUser': totalUser,
  };
}
