
class Cart{
  String _postID;
  String _userID;
  String _title;
  String _price;
  String _description;
  String _pic1;
  String _sellerID;
  bool _selected = false;

  get postID => _postID;
  set postID(value) => _postID = value;

  get userID => _userID;
  set userID(value) => _userID = value;

  get title => _title;
  set title(value) => _title = value;

  get price => _price;
  set price(value) => _price = value;

  get description => _description;
  set description(value) => _description = value;

  get pic1 => _pic1;
  set pic1(value) => _pic1 = value;

  get sellerID => _sellerID;
  set sellerID(value) => _sellerID = value;

  get selected => _selected;
  set selected(value) => _selected = value;

  Cart(
      {
        dynamic postID,
        String userID = '',
        String title = '',
        String price = '',
        String description = '',
        String pic1 = '',
        String sellerID = '',
      }
  ) : _postID = postID,
      _userID = userID,
      _title = title,
      _price = price,
      _description = description,
      _pic1 = pic1,
      _sellerID = sellerID;

  Cart.copy(Cart from)
      : this(
            postID: from.postID,
            userID: from.userID,
            title: from.title,
            price: from.price,
            description: from.description,
            pic1: from.pic1,
            sellerID: from.sellerID,
      );

  Cart.fromJson(Map<String, dynamic> json)
      : this(
          postID: json['postID'],
          userID: json['userID'],
          title: json['title'],
          price: json['price'],
          description: json['description'],
          pic1: json['pic1'],
          sellerID: json['sellerID'],
      );

  Map<String, dynamic> toJson() => {
        'postID': postID,
        'userID': userID,
        'title': title,
        'price': price,
        'description': description,
        'pic1': pic1,
        'sellerID': sellerID,
  };
}
