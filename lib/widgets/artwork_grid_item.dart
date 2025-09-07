import 'package:flutter/material.dart';
import 'package:artty/screens/artwork_detail_page.dart';

class ArtworkGridItem extends StatelessWidget {
  final String imageUrl; final String title; final String price;
  const ArtworkGridItem({super.key, required this.imageUrl, required this.title, required this.price});

  factory ArtworkGridItem.sample({required int index}) {
    const urls = [
      'https://pixabay.com/get/gbc582b2ed8d19a4df13187b41a77407b90c4dfcd78e6a47c8d2679cafc9927d909806a0ef4622622832e0534d2d545a96cc6f978df98d0b570b139a9e0ad8482_1280.jpg',
      'https://pixabay.com/get/g11509e07e8540f0ce3a8f23a0c72e5c2c0b889304e30e3dc23bb27ac79bdfa89b4f4dd82f3f16dd8f4ff71dc0ff0ca92b7cc22cbe6cb0ea5d0d6bdf7e8dc8261_1280.jpg',
      'https://pixabay.com/get/gdcd2fe103e41229a20cec0665b9e684db7fa69bef30cbcadea2d430313bc95d1cb45154dd6a544e20c08135e5c0a2f8fd155b4558432084577fe112d3c43c955_1280.jpg',
      'https://pixabay.com/get/g681ac6a839d43231bf1aa21fe6a2d8a40f87cf46bfd0606ec35954ef49d9430ef88d3a022831eebe41ddf7967f811bdca096ec18d1796f9aebfedafa6466afc4_1280.jpg',
    ];
    return ArtworkGridItem(
      imageUrl: urls[index % urls.length],
      title: 'Edition #${index + 1}',
      price: '\$${(60 + index * 10)}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 260),
          pageBuilder: (_, a, __) => FadeTransition(
            opacity: a,
            child: ArtworkDetailPage(imageUrl: imageUrl, title: title, author: 'Alex Rivera'),
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: scheme.onSurface.withValues(alpha: 0.08)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(imageUrl, fit: BoxFit.cover, width: double.infinity),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: Theme.of(context).textTheme.titleSmall, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 4),
              Row(children: [
                Text(price, style: Theme.of(context).textTheme.labelLarge),
                const Spacer(),
                Icon(Icons.shopping_bag_outlined, size: 18, color: Colors.green),
              ]),
            ]),
          ),
        ]),
      ),
    );
  }
}