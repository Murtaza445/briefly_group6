import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/news_bloc.dart';
import '../../bloc/news_event.dart';
import '../../bloc/news_state.dart';
import '../widgets/news_card.dart';
import '../widgets/share_daily_brief_sheet.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(LoadNews());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: 'Briefly',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
            children: const <TextSpan>[
              TextSpan(
                text: '.',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Colors.lime,
                ),
              ),
            ],
          ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none)),
          CircleAvatar(child: Icon(Icons.person_2_outlined)),
          SizedBox(width: 16),
        ],
      ),
      floatingActionButton: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          final newsCount = state is NewsLoaded ? state.news.length : 5;
          return FloatingActionButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                isDismissible: false,
                builder: (BuildContext context) {
                  return ShareDailyBriefSheet(newsCount: newsCount);
                },
              );
            },
            shape: const CircleBorder(),
            child: const Icon(Icons.share_outlined),
          );
        },
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading || state is NewsInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NewsError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          if (state is NewsLoaded) {
            final news = state.news;
            final curatedSummary = state.curatedSummary;

            final List<Map<String, dynamic>> categories = [
              {
                'label': 'Tech',
                'color': Colors.lime,
                'textColor': Colors.black,
              },
              {'label': 'Sports'},
              {'label': 'Politics'},
              {'label': 'Crypto'},
              {'label': 'Design'},
            ];

            return RefreshIndicator(
              onRefresh: () async {
                context.read<NewsBloc>().add(LoadNews());
              },
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: news.length + 3,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                      child: Card(
                        color: Colors.lime.withValues(alpha: 0.12),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Gemini Curated Brief',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Colors.lime,
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                curatedSummary,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(height: 1.45),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else if (index == 1) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(categories.length, (i) {
                            final category = categories[i];
                            return Padding(
                              padding: EdgeInsets.only(left: i == 0 ? 16.0 : 16.0),
                              child: Chip(
                                label: Text(
                                  category['label'],
                                  style: TextStyle(
                                    color: category['textColor'] ?? Colors.white,
                                  ),
                                ),
                                backgroundColor: category['color'],
                              ),
                            );
                          }),
                        ),
                      ),
                    );
                  } else if (index == 2) {
                    return const SizedBox(height: 8);
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: NewsCard(item: news[index - 3]),
                    );
                  }
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
