import 'package:flutter/material.dart';
import 'package:jafu/screens/chatPage/channelPage.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChannelListPage extends StatelessWidget {

  static Route route() => MaterialPageRoute(
      builder: (context) => ChannelListPage());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.blue),
              backgroundColor: Colors.grey[300],
              leading: IconButton(
                alignment: Alignment.centerRight,
                icon: Icon(Icons.chevron_left),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              title: Text(
                        'Messages',
                        style: TextStyle(color: Colors.blue),
                      ),
          ),
        body: ChannelListView(
          filter: Filter.in_('members', [StreamChatCore.of(context).currentUser.id]),
          sort: [SortOption('last_message_at')],
          // pagination: PaginationParams(
          //   limit: 20,
          // ),
          limit: 20,
          channelWidget: ChannelPage(),
        ),
      ),
    );
  }
}

