// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:maos/blocs/news/news_bloc.dart';
import 'package:maos/models/news_model.dart';
import 'package:maos/services/news_services.dart';
import 'package:maos/shared/methods.dart';
import 'package:maos/theme.dart';
import 'package:maos/widgets/recommend.dart';

class NewsPage extends StatefulWidget {
  final NewsModel model;
  final String? predicate;
  const NewsPage({
    super.key,
    required this.model,
    this.predicate,
  });

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  bool followed = false;
  bool saved = false;

  final ScrollController _scrollController = ScrollController();
  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  bool _assetExists = false;

  Future<void> checkAsset() async {
    bool assetExists = await doesAssetExist(
        'assets/images/logo_${widget.model.sourceId}.png'); // Replace with the actual asset path.

    setState(() {
      _assetExists = assetExists;
    });
  }

  @override
  void initState() {
    super.initState();
    checkAsset();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

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
            onTap: () async {
              if (user != null) {
                bool isFollowed = await NewsService()
                    .checkFollowedPublisher(widget.model.sourceId.toString());
                bool isSaved = await NewsService().checkSavedNews(widget.model);
                setState(() {
                  followed = isFollowed;
                  saved = isSaved;
                });
              }
              showDialog(
                context: context,
                builder: (context) => NotificationAction(
                  model: widget.model,
                  followed: followed,
                  saved: saved,
                ),
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
                        capitalizeFirstLetter(widget.model.category.toString()),
                        style: semiboldTS,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        height: 5,
                        width: 5,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: greyWhiteColor),
                      ),
                      Text(
                        widget.predicate ??
                            '${capitalizeFirstLetter(widget.model.category.toString())} news for you 🔥',
                        style: semiboldTS,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.model.title.toString(),
                    style: semiboldTS.copyWith(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                          border: Border.all(color: greyBlur40),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: _assetExists
                                ? AssetImage(
                                    'assets/images/logo_${widget.model.sourceId}.png')
                                : const AssetImage('assets/images/navicon.png'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        capitalizeFirstLetter(widget.model.sourceId.toString()),
                        style: semiboldTS.copyWith(fontSize: 13),
                      ),
                      const Spacer(),
                      Text(
                        DateFormat('d MMMM y').format(
                          DateTime.parse(widget.model.pubDate.toString()),
                        ),
                        style: mediumTS,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.only(left: 10),
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Colors.black,
                    width: 3,
                  ),
                ),
              ),
              child: widget.model.description == null
                  ? Text(
                      replaceSpecialCharacters(widget.model.title.toString()),
                      style: mediumTS.copyWith(fontSize: 13, height: 1.358),
                      textAlign: TextAlign.justify,
                    )
                  : Text(
                      replaceSpecialCharacters(
                          widget.model.description.toString()),
                      style: mediumTS.copyWith(fontSize: 13, height: 1.358),
                      textAlign: TextAlign.justify,
                    ),
            ),
            const SizedBox(
              height: 18,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 210,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: greyBlur40),
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: widget.model.imageUrl == null
                      ? const AssetImage('assets/images/news.jpg')
                      : NetworkImage(widget.model.imageUrl.toString())
                          as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: replaceSpecialCharacters(
                        widget.model.content.toString())
                    .replaceAll('${widget.model.title.toString()} ', '')
                    .replaceAll('${widget.model.description.toString()} ', '')
                    .replaceAll('ADVERTISEMENT SCROLL TO RESUME CONTENT ', '')
                    .split('. ')
                    .map((paragraph) => Padding(
                          // Optional spacing between paragraphs
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            '$paragraph. ',
                            style:
                                mediumTS.copyWith(fontSize: 14, height: 1.338),
                            textAlign: TextAlign.justify,
                          ),
                        ))
                    .toList(),
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
                    style: mediumTS.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, bottom: 8),
              child: Text(
                'Recommend to Read',
                style: semiboldTS.copyWith(fontSize: 18),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  BlocProvider(
                    create: (context) => NewsBloc()..add(NewsRecommend()),
                    child: BlocBuilder<NewsBloc, NewsState>(
                      builder: (context, state) {
                        if (state is NewsSuccess) {
                          return Row(
                            children: state.data.map((recommend) {
                              return Recommend(
                                model: recommend,
                                action: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewsPage(
                                        model: recommend,
                                        predicate: 'Recommended news ✨',
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          );
                        }
                        return const RecommendLoading();
                      },
                    ),
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
  final NewsModel model;
  final bool followed, saved;
  const NotificationAction(
      {super.key,
      required this.model,
      required this.followed,
      required this.saved});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

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
            GestureDetector(
              onTap: () async {
                if (user != null) {
                  if (!followed) {
                    await NewsService()
                        .followPublisher(model.sourceId.toString());
                    showSnackbar(
                        context,
                        'You are now following \'${capitalizeFirstLetter(model.sourceId!)}\' !',
                        false);
                    Navigator.pop(context);
                  } else {
                    await NewsService()
                        .unfollowPublisher(model.sourceId.toString());
                    showSnackbar(
                        context,
                        'You are no longer following \'${capitalizeFirstLetter(model.sourceId!)}\' !',
                        false);
                    Navigator.pop(context);
                  }
                } else {
                  showSnackbar(context,
                      'You need to be logged in to use this feature!', true);
                  Navigator.pop(context);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 50,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: greyBlur20),
                  ),
                ),
                child: !followed
                    ? Row(
                        children: [
                          Image.asset(
                            'assets/icons/news_follow.png',
                            scale: 2.5,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Follow \'${capitalizeFirstLetter(model.sourceId.toString())}\'',
                            style: actionButton,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Image.asset(
                            'assets/icons/news_unfollow.png',
                            scale: 2.5,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Unfollow \'${capitalizeFirstLetter(model.sourceId.toString())}\'',
                            style: actionButton,
                          ),
                        ],
                      ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // showCustomSnackbar(context, null);
              },
              child: Container(
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
                      style: actionButton,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (user != null) {
                  if (!saved) {
                    await NewsService().saveNews(model);
                    showSnackbar(context, 'Article saved successfully!', false);
                    Navigator.pop(context);
                  } else {
                    await NewsService().deleteSavedNews(model);
                    showSnackbar(context, 'Article unsaved!', false);
                    Navigator.pop(context);
                  }
                } else {
                  showSnackbar(context,
                      'You need to be logged in to use this feature!', true);
                  Navigator.pop(context);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 50,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: greyBlur20),
                  ),
                ),
                child: !saved
                    ? Row(
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
                            style: actionButton,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Image.asset(
                            'assets/icons/news_unsave.png',
                            scale: 2.5,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Unsave article',
                            style: actionButton,
                          ),
                        ],
                      ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // showCustomSnackbar(context, null);
              },
              child: Container(
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
                      style: actionButton.copyWith(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
