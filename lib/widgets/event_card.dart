import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String location;
  final String imageUrl;
  const EventCard({super.key, required this.title, required this.date, required this.location, required this.imageUrl});

  factory EventCard.sample({required int index}) {
    const urls = [
      'https://pixabay.com/get/gfd4a04cc326e7a08c5c1695a612978b07acf4a442818495ba511e4d7f0fcb3d7e6fae2b8a8e505385888fafb55e47aded19d55a81faebc17e9158230db805bde_1280.jpg',
      'https://pixabay.com/get/g64e41215db4e1cf905b614e5a27e23ae32d71d8874f47f627cc3608caa7ec05b8156dda7809274f857b26bb9d44a97248a4b71e9ffa66acf02ca1c7d6f4b4656_1280.jpg',
      'https://pixabay.com/get/gdcd2fe103e41229a20cec0665b9e684db7fa69bef30cbcadea2d430313bc95d1cb45154dd6a544e20c08135e5c0a2f8fd155b4558432084577fe112d3c43c955_1280.jpg',
    ];
    return EventCard(
      title: 'Group Exhibition',
      date: 'Oct 21, 7:00 PM',
      location: 'Art Hub, Chelsea',
      imageUrl: urls[index % urls.length],
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
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: AspectRatio(aspectRatio: 16/9, child: Image.network(imageUrl, fit: BoxFit.cover)),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Row(children: const [
              Icon(Icons.calendar_today, size: 18, color: Colors.blue), SizedBox(width: 6), Text('Oct 21, 7:00 PM'),
              SizedBox(width: 12), Icon(Icons.location_on, size: 18, color: Colors.red), SizedBox(width: 6), Expanded(child: Text('Art Hub, Chelsea', overflow: TextOverflow.ellipsis)),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.bookmark_add_outlined, color: Colors.pink), label: const Text('Save')),
              const SizedBox(width: 8),
              FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.share, color: Colors.white), label: const Text('Share')),
            ]),
          ]),
        ),
      ]),
    );
  }
}