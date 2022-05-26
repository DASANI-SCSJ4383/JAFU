
class Post{
  String _postID;
  String _postTitle;
  String _price;
  String _description;
  String _pic1;
  String _pic2;
  String _pic3;
  final List _picture = [];

  get postID => _postID;
  set postID(value) => _postID = value;

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

  get picture => _picture;
  set picture(value) {
    _picture.add(value);
  }

  Post(
      {
        dynamic postID,
        String postTitle = '',
        String price = '',
        String description = '',
        String pic1 = '',
        String pic2 = '',
        String pic3 = '',
      }
  ) : _postID = postID,
      _postTitle = postTitle,
      _price = price,
      _description = description,
      _pic1 = pic1,
      _pic2 = pic2,
      _pic3= pic3;

  Post.copy(Post from)
      : this(
            postID: from.postID,
            postTitle: from.postTitle,
            price: from.price,
            description: from.description,
            pic1: from.pic1,
            pic2: from.pic2,
            pic3: from.pic3,
      );

  Post.fromJson(Map<String, dynamic> json)
      : this(
          postID: json['postID'],
          postTitle: json['postTitle'],
          price: json['price'],
          description: json['description'],
          pic1: json['pic1'],
          pic2: json['pic2'],
          pic3: json['pic3'],
      );

  Map<String, dynamic> toJson() => {
        'postID': postID,
        'postTitle': postTitle,
        'price': price,
        'description': description,
        'pic1': pic1,
        'pic2': pic2,
        'pic3': pic3,
  };
}
