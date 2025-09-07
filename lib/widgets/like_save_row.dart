import 'package:flutter/material.dart';

class LikeSaveRow extends StatefulWidget {
  final VoidCallback? onCommentTap;
  const LikeSaveRow({super.key, this.onCommentTap});

  @override
  State<LikeSaveRow> createState() => _LikeSaveRowState();
}

class _LikeSaveRowState extends State<LikeSaveRow> {
  bool liked = false;
  bool saved = false;
  int likes = 124;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      IconButton(
        icon: Icon(liked ? Icons.favorite : Icons.favorite_border, color: Colors.red),
        onPressed: () => setState(() { liked = !liked; likes += liked ? 1 : -1; }),
      ),
      Text('$likes'),
      const SizedBox(width: 8),
      IconButton(icon: const Icon(Icons.mode_comment_outlined, color: Colors.blue), onPressed: widget.onCommentTap),
      const Spacer(),
      IconButton(
        icon: Icon(saved ? Icons.bookmark : Icons.bookmark_border, color: Colors.pink),
        onPressed: () => setState(() => saved = !saved),
      ),
    ]);
  }
}