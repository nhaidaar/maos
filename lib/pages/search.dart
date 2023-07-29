import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maos/blocs/news/news_bloc.dart';
import 'package:maos/pages/news.dart';
import 'package:maos/theme.dart';
import 'package:maos/widgets/top_picks.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController(text: '');
  late NewsBloc newsBloc;

  @override
  void initState() {
    super.initState();
    newsBloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 72,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 48,
            width: 48,
            margin: const EdgeInsets.only(left: 16),
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
        title: TextFormField(
          autofocus: true,
          onFieldSubmitted: (value) {
            if (value.isNotEmpty) {
              newsBloc.add(NewsSearch(value));
            }
            setState(() {});
          },
          controller: searchController,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Image.asset(
                'assets/icons/search.png',
                scale: 2,
              ),
            ),
            hintText: 'Indonesian politics today',
            hintStyle: mediumTS.copyWith(color: greyBlur40, fontSize: 14),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              gapPadding: 10,
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(color: greyBlur20),
            ),
            enabledBorder: OutlineInputBorder(
              gapPadding: 10,
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(color: greyBlur20),
            ),
            focusedBorder: OutlineInputBorder(
              gapPadding: 10,
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(color: greyBlur20),
            ),
          ),
        ),
      ),
      body: searchController.text.isNotEmpty
          ? searchResult2(searchController.text)
          : Container(),
      backgroundColor: Colors.white,
    );
  }
}

Widget searchResult2(String search) {
  return ListView(
    children: [
      Container(
        margin: const EdgeInsets.only(left: 16, bottom: 8),
        child: Row(
          children: [
            Text(
              'Search result for',
              style: mediumTS.copyWith(color: greyBlur40, fontSize: 14),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              search,
              style: semiboldTS.copyWith(color: Colors.black, fontSize: 14),
            ),
          ],
        ),
      ),
      BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsSuccess) {
            return Column(
              children: state.data.map((news) {
                return TopPicksCard(
                  model: news,
                  action: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsPage(model: news),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          }
          return const TopPicksLoading();
        },
      )
    ],
  );
}
