import 'package:flutter/material.dart';

class CommentSheet extends StatelessWidget {
  const CommentSheet({super.key});

  static Future<void> show({required BuildContext context}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => const CommentSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).viewInsets.bottom;
    return AnimatedPadding(
      duration: const Duration(milliseconds: 180),
      padding: EdgeInsets.only(bottom: padding),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(children: const [
          _Header(),
          Divider(height: 1),
          Expanded(child: _CommentsList()),
          _Composer(),
        ]),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(children: [
        const Icon(Icons.mode_comment, color: Colors.blue),
        const SizedBox(width: 8),
        Text('Comments', style: Theme.of(context).textTheme.titleMedium),
        const Spacer(),
        IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: Colors.grey)),
      ]),
    );
  }
}

class _CommentsList extends StatelessWidget {
  const _CommentsList();
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 12,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const CircleAvatar(radius: 16, backgroundImage: NetworkImage('https://i.pravatar.cc/150')),
        const SizedBox(width: 8),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(child: Text('user_$i', style: Theme.of(context).textTheme.labelLarge)),
            Text('2h', style: Theme.of(context).textTheme.labelSmall),
          ]),
          Text('Beautiful textures and palette! Love the motion here.'),
          Row(children: const [Icon(Icons.favorite, size: 16, color: Colors.red), SizedBox(width: 4), Text('12')]),
        ])),
      ]),
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Row(children: [
          const CircleAvatar(radius: 16, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5')),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Add a comment...',
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
          ),
          const SizedBox(width: 8),
          FilledButton.tonalIcon(onPressed: () {}, icon: const Icon(Icons.send, color: Colors.blue), label: const Text('Send')),
        ]),
      ),
    );
  }
}