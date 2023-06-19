import 'package:flutter/material.dart';
import 'package:maos/theme.dart';
import 'package:maos/widgets/recommend.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final ScrollController _scrollController = ScrollController();
  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 72,
        backgroundColor: Colors.transparent,
        elevation: 0,
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
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const NotificationAction(),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 18),
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: greyBlur20),
                image: const DecorationImage(
                  image: AssetImage('assets/icons/news_action.png'),
                  scale: 2,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Politics',
                        style: semi.copyWith(fontSize: 12),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        height: 5,
                        width: 5,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: greyWhiteColor),
                      ),
                      Text(
                        'Top 5 Hot Topic 🔥',
                        style: semi.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Hey, it\'s Sample News Page! Happy to see you here',
                    style: semi.copyWith(fontSize: 24),
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 22,
                        width: 22,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/logo_cnn.png'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'CNN Indonesia',
                        style: semi.copyWith(fontSize: 13),
                      ),
                      const Spacer(),
                      Text(
                        '7 mins read',
                        style: medium.copyWith(fontSize: 12),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        height: 5,
                        width: 5,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: greyWhiteColor),
                      ),
                      Text(
                        '17 Juni 2023',
                        style: medium.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              padding: const EdgeInsets.only(left: 10),
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(
                      color: Colors.black, width: 4, style: BorderStyle.solid),
                ),
              ),
              child: Text(
                'Praesent velit dolor, vulputate sit amet facilisis ac, venenatis quis metus. Mauris lacinia nec sem eu pellentesque. Phasellus suscipit ante non pellentesque egestas. Cras quis erat mi. Nulla lobortis, tellus commodo porttitor scelerisque, neque diam efficitur lacus, a accumsan diam turpis non elit.',
                style: medium.copyWith(fontSize: 13, height: 1.358),
                textAlign: TextAlign.justify,
                maxLines: 10,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 210,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage('assets/images/sample4.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                children: [
                  Text(
                    'Praesent velit dolor, vulputate sit amet facilisis ac, venenatis quis metus. Mauris lacinia nec sem eu pellentesque. Phasellus suscipit ante non pellentesque egestas. Cras quis erat mi. Nulla lobortis, tellus commodo porttitor scelerisque, neque diam efficitur lacus, a accumsan diam turpis non elit.',
                    style: medium.copyWith(fontSize: 14, height: 1.338),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '“Praesent velit dolor, vulputate sit amet facilisis ac, venenatis quis metus. Mauris lacinia nec sem eu pellentesque. Phasellus suscipit.” - Ahmad Subari',
                    style: medium.copyWith(fontSize: 14, height: 1.338),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Bonjourt velit dolor, vulputate sit amet facilisis ac, venenatis quis metus. Mauris lacinia nec sem eu pellentesque. Phasellus suscipit ante non pellentesque egestas. Cras quis erat mi. Nulla lobortis, tellus commodo porttitor scelerisque, neque diam efficitur lacus, a accumsan',
                    style: medium.copyWith(fontSize: 14, height: 1.338),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Bonjourt velit dolor, vulputate sit amet facilisis ac, venenatis quis metus. Mauris lacinia nec sem eu pellentesque. Phasellus suscipit ante non pellentesque egestas. Cras quis erat mi. Nulla lobortis, tellus commodo porttitor scelerisque, neque diam efficitur lacus, a accumsan.',
                    style: medium.copyWith(fontSize: 14, height: 1.338),
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _scrollToTop();
              },
              child: Container(
                margin: const EdgeInsets.only(left: 16, bottom: 16),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(1000),
                ),
                child: FittedBox(
                  child: Text(
                    'Back to Top',
                    style: medium.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, bottom: 8),
              child: Text(
                'Recommend to Read',
                style: semi.copyWith(fontSize: 18),
              ),
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  Recommend(
                    title:
                        'Just Wolf?, No This Is An Animal Who Can Bite Yourself',
                    imgUrl: 'assets/images/sample1.png',
                    minRead: '7',
                    date: '05 April 2023',
                  ),
                  Recommend(
                    title: 'Top 7 Beautiful Architecture You Have to See!',
                    imgUrl: 'assets/images/sample2.png',
                    minRead: '2',
                    date: '05 April 2023',
                  ),
                  Recommend(
                    title: 'How to Be an Astronaut?, Here\'s The Tips',
                    imgUrl: 'assets/images/sample3.png',
                    minRead: '5',
                    date: '05 April 2023',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationAction extends StatelessWidget {
  const NotificationAction({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.topRight,
      insetPadding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width / 2.5,
        top: 72,
        right: 16,
      ),
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 50,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: greyBlur20),
                ),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/news_follow.png',
                    scale: 2.5,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Follow Publication',
                    style: montserrat,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 50,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: greyBlur20),
                ),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/news_share.png',
                    scale: 2.5,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Share',
                    style: montserrat,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 50,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: greyBlur20),
                ),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/news_save.png',
                    scale: 2.5,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Save article',
                    style: montserrat,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 50,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: greyBlur20),
                ),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/news_report.png',
                    scale: 2.5,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Report',
                    style: montserrat.copyWith(color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
