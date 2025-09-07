import 'package:flutter/material.dart';

class FollowButton extends StatefulWidget {
  const FollowButton({super.key});

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool following = false;
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: following
          ? OutlinedButton.icon(
              key: const ValueKey('following'),
              onPressed: () => setState(() => following = false),
              icon: const Icon(Icons.check, color: Colors.green),
              label: const Text('Following'),
              style: OutlinedButton.styleFrom(foregroundColor: scheme.onSurface),
            )
          : FilledButton.icon(
              key: const ValueKey('follow'),
              onPressed: () => setState(() => following = true),
              icon: const Icon(Icons.person_add, color: Colors.white),
              label: const Text('Follow'),
              style: FilledButton.styleFrom(backgroundColor: scheme.primary, foregroundColor: scheme.onPrimary),
            ),
    );
  }
}