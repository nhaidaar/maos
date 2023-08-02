import 'package:flutter/material.dart';
import 'package:maos/theme.dart';
import 'package:maos/widgets/notifications.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        backgroundColor: Colors.white,
        elevation: 0.8,
        leadingWidth: 68,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 48,
            width: 48,
            margin: const EdgeInsets.only(left: 18),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: greyBlur20),
            ),
            child: Center(
              child: Image.asset(
                'assets/icons/news_back.png',
                width: 24,
              ),
            ),
          ),
        ),
        title: Text(
          'Notification',
          style: semiboldTS.copyWith(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          CustomNotification(
            title: 'Kebakaran di Jakarta Timur Hanguskan 16 Kambing',
            imgUrl: 'assets/images/news1.jpg',
            time: '6 mins ago',
            action: () {
              // showCustomSnackbar(context, null);
            },
            isUnread: true,
          ),
          CustomNotification(
            title:
                'Manfaat Habatusauda bagi Kesehatan dan Cara Terbaik Mengonsumsinya',
            imgUrl: 'assets/images/news1.jpg',
            time: '17 mins ago',
            action: () {
              // showCustomSnackbar(context, null);
            },
            isUnread: true,
          ),
          CustomNotification(
            title: 'Media Argentina Puji Sambutan Spesial Indonesia',
            imgUrl: 'assets/images/news1.jpg',
            time: '22 mins ago',
            action: () {
              // showCustomSnackbar(context, null);
            },
            isUnread: false,
          ),
          CustomNotification(
            title:
                'Pertamina Ajak Generasi Muda Jadi Agen Perubahan Lingkungan',
            imgUrl: 'assets/images/news1.jpg',
            time: '54 mins ago',
            action: () {
              // showCustomSnackbar(context, null);
            },
            isUnread: false,
          ),
        ],
      ),
    );
  }
}
