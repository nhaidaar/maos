// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/news_model.dart';
import '../../../services/news_services.dart';
import '../../../shared/methods.dart';
import '../../../shared/theme.dart';

class NewsAction extends StatelessWidget {
  final NewsModel model;
  final bool followed, saved;
  const NewsAction(
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
      backgroundColor: Colors.transparent,
      elevation: 0,
      contentPadding: EdgeInsets.zero,
      content: Container(
        height: 200,
        decoration: BoxDecoration(
          color: whiteBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                if (user != null) {
                  if (!followed) {
                    await NewsService()
                        .followPublisher(model.sourceId.toString());
                    showBottomSnackbar(
                        context,
                        'You are now following \'${capitalizeFirstLetter(model.sourceId!)}\' !',
                        false);
                    Navigator.pop(context);
                  } else {
                    await NewsService()
                        .unfollowPublisher(model.sourceId.toString());
                    showBottomSnackbar(
                        context,
                        'You are no longer following \'${capitalizeFirstLetter(model.sourceId!)}\' !',
                        false);
                    Navigator.pop(context);
                  }
                } else {
                  showBottomSnackbar(context,
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
                    showBottomSnackbar(
                        context, 'Article saved successfully!', false);
                    Navigator.pop(context);
                  } else {
                    await NewsService().deleteSavedNews(model);
                    showBottomSnackbar(context, 'Article unsaved!', false);
                    Navigator.pop(context);
                  }
                } else {
                  showBottomSnackbar(context,
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
