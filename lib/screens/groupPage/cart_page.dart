import 'package:flutter/material.dart';
import 'package:jafu/viewmodel/group_viewmodel.dart';
import 'package:jafu/viewmodel/user_viewmodel.dart';

class CartPage extends StatefulWidget {

  static Route route({userViewmodel, groupViewmodel, index}) => MaterialPageRoute(
      builder: (context) =>
          CartPage(userViewmodel: userViewmodel, groupViewmodel: groupViewmodel, index: index));

  final UserViewmodel _userViewmodel;
  final GroupViewmodel _groupViewmodel;
  final int _index;

  const CartPage({userViewmodel, groupViewmodel, index})
      : _userViewmodel = userViewmodel,
        _groupViewmodel = groupViewmodel,
        _index = index;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text("Shopping Cart"),
          SizedBox(height: 12,),
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                    fit: BoxFit.scaleDown,
                    image: NetworkImage("")
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Container(
                    
                  ),
                ),
              ),
              SizedBox(width: 12,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      child: Text("asdsd"),
                    ),
                    SizedBox(height: 4,),
                    Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:8.0),
                          child: Text("1"),
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 15,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Spacer(),

            ],
          )
        ],
      ),
    );
  }
}