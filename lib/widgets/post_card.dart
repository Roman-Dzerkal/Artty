import 'package:flutter/material.dart';
import 'package:artty/screens/artwork_detail_page.dart';
import 'package:artty/widgets/like_save_row.dart';

class PostCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String category;
  const PostCard({super.key, required this.imageUrl, required this.title, required this.author, required this.category});

  factory PostCard.sample({required int index}) {
    const urls = [
      'https://pixabay.com/get/gdcd2fe103e41229a20cec0665b9e684db7fa69bef30cbcadea2d430313bc95d1cb45154dd6a544e20c08135e5c0a2f8fd155b4558432084577fe112d3c43c955_1280.jpg',
      'https://pixabay.com/get/gbc582b2ed8d19a4df13187b41a77407b90c4dfcd78e6a47c8d2679cafc9927d909806a0ef4622622832e0534d2d545a96cc6f978df98d0b570b139a9e0ad8482_1280.jpg',
      'https://pixabay.com/get/g11509e07e8540f0ce3a8f23a0c72e5c2c0b889304e30e3dc23bb27ac79bdfa89b4f4dd82f3f16dd8f4ff71dc0ff0ca92b7cc22cbe6cb0ea5d0d6bdf7e8dc8261_1280.jpg',
      'https://pixabay.com/get/g681ac6a839d43231bf1aa21fe6a2d8a40f87cf46bfd0606ec35954ef49d9430ef88d3a022831eebe41ddf7967f811bdca096ec18d1796f9aebfedafa6466afc4_1280.jpg',
      'https://pixabay.com/get/gfd4a04cc326e7a08c5c1695a612978b07acf4a442818495ba511e4d7f0fcb3d7e6fae2b8a8e505385888fafb55e47aded19d55a81faebc17e9158230db805bde_1280.jpg',
      'https://pixabay.com/get/g64e41215db4e1cf905b614e5a27e23ae32d71d8874f47f627cc3608caa7ec05b8156dda7809274f857b26bb9d44a97248a4b71e9ffa66acf02ca1c7d6f4b4656_1280.jpg',
    ];
    final categories = ['Painting', 'Digital', 'Jewelry', 'Clothing', 'Photography', 'Sculpture'];
    return PostCard(
      imageUrl: urls[index % urls.length],
      title: 'Color Study #${index + 1}',
      author: 'Alex Rivera',
      category: categories[index % categories.length],
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: scheme.onSurface.withValues(alpha: 0.08)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _Header(author: author, category: category),
        GestureDetector(
          onTap: () => Navigator.of(context).push(PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 260),
            pageBuilder: (_, a, b) => FadeTransition(
              opacity: a,
              child: ArtworkDetailPage(imageUrl: imageUrl, title: title, author: author),
            ),
          )),
          child: Hero(
            tag: imageUrl,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: AspectRatio(
                aspectRatio: 4/3, 
                child: Container(
                  color: scheme.surfaceContainerHighest,
                  child: CustomPaint(
                    painter: _PlaceholderPainter(color: scheme.onSurfaceVariant.withValues(alpha: 0.3)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_outlined,
                            size: 48,
                            color: scheme.onSurfaceVariant.withValues(alpha: 0.6),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Image Placeholder',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: scheme.onSurfaceVariant.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            LikeSaveRow(onCommentTap: () {}),
          ]),
        ),
      ]),
    );
  }
}

class _PlaceholderPainter extends CustomPainter {
  final Color color;
  const _PlaceholderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Draw diagonal lines
    canvas.drawLine(const Offset(0, 0), Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Header extends StatelessWidget {
  final String author; final String category;
  const _Header({required this.author, required this.category});
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      child: Row(children: [
        const CircleAvatar(radius: 18, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=15')),
        const SizedBox(width: 8),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(author, style: Theme.of(context).textTheme.titleSmall),
          Text(category, style: Theme.of(context).textTheme.labelSmall),
        ])),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: scheme.primaryContainer,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(children: const [Icon(Icons.category, color: Colors.purple, size: 16), SizedBox(width: 4), Text('Category')]),
        )
      ]),
    );
  }
}