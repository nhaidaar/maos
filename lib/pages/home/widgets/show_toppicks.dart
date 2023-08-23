import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../blocs/news/news_bloc.dart';
import '../../../widgets/toppicks_card.dart';
import '../../news/news.dart';

class ShowTopPicks extends StatelessWidget {
  final String category;
  const ShowTopPicks({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc()..add(NewsGet(category)),
      child: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsSuccess) {
            return Column(
              children: state.data.map((news) {
                return TopPicksCard(
                  model: news,
                  action: () {
                    Navigator.of(context).push(
                      PageTransition(
                        child: NewsPage(model: news),
                        type: PageTransitionType.rightToLeft,
                        childCurrent: this,
                      ),
                    );
                  },
                );
              }).toList(),
            );
          }
          return const TopPicksLoading();
        },
      ),
    );
  }
}
