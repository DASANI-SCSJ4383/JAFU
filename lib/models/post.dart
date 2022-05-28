
class Post{
  String _postID;
  String _groupID;
  String _userID;
  String _postTitle;
  String _price;
  String _description;
  String _pic1;
  String _pic2;
  String _pic3;
  String _date;
  String _username;
  String _phoneNum;
  final List _picture = [];

  get postID => _postID;
  set postID(value) => _postID = value;

  get groupID => _groupID;
  set groupID(value) => _groupID = value;

  get userID => _userID;
  set userID(value) => _userID = value;

  get postTitle => _postTitle;
  set postTitle(value) => _postTitle = value;

  get price => _price;
  set price(value) => _price = value;

  get description => _description;
  set description(value) => _description = value;

  get pic1 => _pic1;
  set pic1(value) => _pic1 = value;

  get pic2 => _pic2;
  set pic2(value) => _pic2 = value;

  get pic3 => _pic3;
  set pic3(value) => _pic3 = value;

  get date => _date;
  set date(value) => _date = value;

  get username => _username;
  set username(value) => _username = value;

  get phoneNum => _phoneNum;
  set phoneNum(value) => _phoneNum = value;

  get picture => _picture;
  set picture(value) {
    _picture.add(value);
  }

  Post(
      {
        dynamic postID,
        String groupID = '',
        String userID = '',
        String postTitle = '',
        String price = '',
        String description = '',
        String pic1 = '',
        String pic2 = '',
        String pic3 = '',
        String date = '',
        String username = '',
        String phoneNum = '',
      }
  ) : _postID = postID,
      _groupID = groupID,
      _userID = userID,
      _postTitle = postTitle,
      _price = price,
      _description = description,
      _pic1 = pic1,
      _pic2 = pic2,
      _pic3= pic3,
      _date= date,
      _username= username,
      _phoneNum= phoneNum;

  Post.copy(Post from)
      : this(
            postID: from.postID,
            groupID: from.groupID,
            userID: from.userID,
            postTitle: from.postTitle,
            price: from.price,
            description: from.description,
            pic1: from.pic1,
            pic2: from.pic2,
            pic3: from.pic3,
            date: from.date,
            username: from.username,
            phoneNum: from.phoneNum,
      );

  Post.fromJson(Map<String, dynamic> json)
      : this(
          postID: json['postID'],
          groupID: json['groupID'],
          userID: json['userID'],
          postTitle: json['postTitle'],
          price: json['price'],
          description: json['description'],
          pic1: json['pic1'],
          pic2: json['pic2'],
          pic3: json['pic3'],
          date: json['date'],
          username: json['username'],
          phoneNum: json['phoneNum'],
      );

  Map<String, dynamic> toJson() => {
        'postID': postID,
        'groupID': groupID,
        'userID': userID,
        'postTitle': postTitle,
        'price': price,
        'description': description,
        'pic1': pic1,
        'pic2': pic2,
        'pic3': pic3,
        'date': date,
        'username': username,
        'phoneNum': phoneNum,
  };
}
