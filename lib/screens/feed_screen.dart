import 'package:flutter/material.dart';
import 'package:artty/widgets/post_card.dart';
import 'package:artty/widgets/event_card.dart';
import 'package:artty/widgets/category_filter_strip.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const _FeedTitle(),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(48),
            child: _FeedTabs(),
          ),
        ),
        body: Column(
          children: [
            const CategoryFilterStrip(),
            Expanded(
              child: TabBarView(children: [
                _WorksList(colorScheme: scheme),
                _EventsList(colorScheme: scheme),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeedTitle extends StatelessWidget {
  const _FeedTitle();
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ShaderMask(
      shaderCallback: (rect) => LinearGradient(
        colors: [scheme.primary, scheme.inversePrimary],
      ).createShader(rect),
      child: Text('Artty', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white)),
    );
  }
}

class _FeedTabs extends StatelessWidget {
  const _FeedTabs();
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: scheme.onSurface.withValues(alpha: 0.1), width: 0.5)),
      ),
      child: const TabBar(
        isScrollable: false,
        labelPadding: EdgeInsets.symmetric(horizontal: 24),
        tabs: [
          Tab(icon: Icon(Icons.palette, color: Colors.blue), text: 'Works'),
          Tab(icon: Icon(Icons.event, color: Colors.pink), text: 'Events'),
        ],
      ),
    );
  }
}

class _WorksList extends StatelessWidget {
  final ColorScheme colorScheme;
  const _WorksList({required this.colorScheme});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) => PostCard.sample(index: index),
    );
  }
}

class _EventsList extends StatelessWidget {
  final ColorScheme colorScheme;
  const _EventsList({required this.colorScheme});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 4,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) => EventCard.sample(index: index),
    );
  }
}