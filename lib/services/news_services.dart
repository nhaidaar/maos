import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:maos/models/news_model.dart';
import 'package:maos/theme.dart';

class NewsService {
  Future<List<NewsModel>> getNews(String category) async {
    try {
      final randomKey = apikey[Random().nextInt(apikey.length)];
      final res = await http.get(
        Uri.parse(
          'https://newsdata.io/api/1/news?country=id&category=$category&apikey=$randomKey',
        ),
      );
      if (res.statusCode == 200) {
        return List<NewsModel>.from(jsonDecode(res.body)['results']
            .map((news) => NewsModel.fromJson(news))).toList();
      } else {
        throw jsonDecode(res.body)['results']['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NewsModel>> hotNews() async {
    try {
      final randomKey = apikey[Random().nextInt(apikey.length)];
      final res = await http.get(
        Uri.parse(
          'https://newsdata.io/api/1/news?country=id&apikey=$randomKey',
        ),
      );
      if (res.statusCode == 200) {
        return List<NewsModel>.from(jsonDecode(res.body)['results']
            .map((news) => NewsModel.fromJson(news))).toList();
      } else {
        throw jsonDecode(res.body)['results']['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NewsModel>> publisherNews(String publisher) async {
    try {
      final randomKey = apikey[Random().nextInt(apikey.length)];
      final res = await http.get(
        Uri.parse(
          'https://newsdata.io/api/1/news?country=id&apikey=$randomKey&domain=$publisher',
        ),
      );
      if (res.statusCode == 200) {
        return List<NewsModel>.from(jsonDecode(res.body)['results']
            .map((news) => NewsModel.fromJson(news))).toList();
      } else {
        throw jsonDecode(res.body)['results']['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NewsModel>> searchNews(String search) async {
    try {
      final randomKey = apikey[Random().nextInt(apikey.length)];
      final res = await http.get(
        Uri.parse(
          'https://newsdata.io/api/1/news?country=id&apikey=$randomKey&qInTitle=$search',
        ),
      );
      if (res.statusCode == 200) {
        return List<NewsModel>.from(jsonDecode(res.body)['results']
            .map((news) => NewsModel.fromJson(news))).toList();
      } else {
        throw jsonDecode(res.body)['results']['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NewsModel>> recommendNews() async {
    try {
      final randomKey = apikey[Random().nextInt(apikey.length)];
      final randomCategory =
          newsCategory[Random().nextInt(newsCategory.length)];
      final res = await http.get(
        Uri.parse(
          'https://newsdata.io/api/1/news?country=id&category=$randomCategory&apikey=$randomKey',
        ),
      );
      if (res.statusCode == 200) {
        return List<NewsModel>.from(jsonDecode(res.body)['results']
            .map((news) => NewsModel.fromJson(news))).toList();
      } else {
        throw jsonDecode(res.body)['results']['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveNews(NewsModel news) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Convert NewsModel to map
    Map<String, dynamic> newsData = news.toMap();

    // Reference to the user's news collection
    CollectionReference userNewsCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('news');

    // Save the news data to Firestore
    await userNewsCollection.add(newsData);
  }

  Future<bool> checkSavedNews(NewsModel news) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Reference to the user's saved news subcollection
    CollectionReference userSavedNewsCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('news');

    // Check if the document with the specified title exists in the "news" collection
    QuerySnapshot querySnapshot = await userSavedNewsCollection.get();

    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      if (data['title'] == news.title) {
        // Document with the same title exists
        return true;
      }
    }
    return false;
  }

  Future<void> deleteSavedNews(NewsModel news) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Reference to the user's saved news subcollection
    CollectionReference userSavedNewsCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('news');

    // Check if the document with the specified title exists in the "news" collection
    QuerySnapshot querySnapshot = await userSavedNewsCollection.get();

    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      if (data['title'] == news.title) {
        // Document with the same title exists
        await documentSnapshot.reference.delete();
        return;
      }
    }
  }

  Future<void> followPublisher(String publisher) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Reference to the user's publisher collection
    CollectionReference userPublisherCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('publishers');

    // Save the publisher to Firestore
    await userPublisherCollection.doc(publisher).set({
      'name': publisher,
    });
  }

  Future<bool> checkFollowedPublisher(String publisher) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Reference to the user's publishers collection
    CollectionReference userFavoritesCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('publishers');

    // Check if the document with the specified title exists in the "publishers" collection
    DocumentSnapshot newsSnapshot =
        await userFavoritesCollection.doc(publisher).get();

    if (newsSnapshot.exists) {
      // Document with the same title already exists in the "publishers" collection
      return true;
    }
    return false;
  }

  Future<void> unfollowPublisher(String publisher) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Reference to the user's publishers collection
    CollectionReference userFavoritesCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('publishers');

    // Check if the document with the specified title exists in the "publishers" collection
    DocumentSnapshot newsSnapshot =
        await userFavoritesCollection.doc(publisher).get();

    if (newsSnapshot.exists) {
      // Document with the same title already exists in the "publishers" collection
      newsSnapshot.reference.delete();
    }
  }
}
