import 'package:flutter/material.dart';
import 'package:maos/theme.dart';
import 'package:maos/widgets/notifications.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.5,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Notification',
          style: semi.copyWith(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          CustomNotification(
            title:
                'Media Israel Puji FIFA Usai Piala Dunia U-20 Batal di Indonesia',
            imgUrl: 'assets/images/news1.jpeg',
            time: '3 mins ago',
            action: () {},
            isUnread: true,
          ),
          CustomNotification(
            title:
                'Media Israel Puji FIFA Usai Piala Dunia U-20 Batal di Indonesia',
            imgUrl: 'assets/images/news2.jpg',
            time: '3 mins ago',
            action: () {},
            isUnread: true,
          ),
          CustomNotification(
            title:
                'Media Israel Puji FIFA Usai Piala Dunia U-20 Batal di Indonesia',
            imgUrl: 'assets/images/news1.jpeg',
            time: '3 mins ago',
            action: () {},
            isUnread: false,
          ),
          CustomNotification(
            title:
                'Media Israel Puji FIFA Usai Piala Dunia U-20 Batal di Indonesia',
            imgUrl: 'assets/images/news1.jpeg',
            time: '3 mins ago',
            action: () {},
            isUnread: false,
          ),
        ],
      ),
    );
  }
}
