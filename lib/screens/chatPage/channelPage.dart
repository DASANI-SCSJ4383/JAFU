import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChannelPage extends StatelessWidget {

  static Route routeWithChannel(Channel channel) => MaterialPageRoute(
        builder: (context) => StreamChannel(
          channel: channel,
          child: ChannelPage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ChannelHeader(),
        body: Column(
          children: <Widget>[
            Expanded(
              child: MessageListView(),
            ),
            MessageInput(),
          ],
        ),
      ),
    );
  }
}
