import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF00FF88), width: 1.5),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Send & Get 2000 Coins',
                    style: TextStyle(
                      color: Color(0xFF00FF88),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.card_giftcard, color: Color(0xFF00FF88)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Recent Chats',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ..._buildChatList(),
        ],
      ),
    );
  }

  List<Widget> _buildChatList() {
    final chats = [
      {'name': 'ProGamer_', 'message': 'Let\'s play together!', 'time': '1h'},
      {'name': 'GamerGirl', 'message': 'Thanks for the gift!', 'time': '4h'},
      {'name': 'SocialBee', 'message': 'Join my room now', 'time': '5h'},
      {'name': 'TourneyKing', 'message': 'See you in tournament', 'time': '1 day'},
    ];

    return chats.map((chat) {
      return ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF7B2CBF),
          child: Text(
            (chat['name'] as String)[0].toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(chat['name'] as String),
        subtitle: Text(chat['message'] as String),
        trailing: Text(chat['time'] as String),
      );
    }).toList();
  }
}
