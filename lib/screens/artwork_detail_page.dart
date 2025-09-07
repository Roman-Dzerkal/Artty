import 'package:flutter/material.dart';
import 'package:artty/widgets/like_save_row.dart';
import 'package:artty/widgets/comment_sheet.dart';

class ArtworkDetailPage extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  const ArtworkDetailPage({super.key, required this.imageUrl, required this.title, required this.author});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Hero(
            tag: imageUrl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(aspectRatio: 4/3, child: Image.network(imageUrl, fit: BoxFit.cover)),
            ),
          ),
          const SizedBox(height: 12),
          Row(children: [
            CircleAvatar(backgroundImage: const NetworkImage('https://i.pravatar.cc/150?img=32')), const SizedBox(width: 8),
            Expanded(child: Text(author, style: Theme.of(context).textTheme.titleMedium)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.share, color: Colors.blue)),
          ]),
          const SizedBox(height: 8),
          Text('An exploration of color, texture and motion. Acrylic on canvas.', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 8),
          LikeSaveRow(onCommentTap: () => CommentSheet.show(context: context)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: scheme.onSurface.withValues(alpha: 0.08)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Available as print', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Row(children: [
                Text('\$120', style: Theme.of(context).textTheme.headlineSmall),
                const Spacer(),
                FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.shopping_bag, color: Colors.white), label: const Text('Add to cart')),
              ]),
            ]),
          ),
        ],
      ),
    );
  }
}