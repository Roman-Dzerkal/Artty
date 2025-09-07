import 'package:flutter/material.dart';
import 'package:artty/widgets/post_card.dart';
import 'package:artty/widgets/follow_button.dart';
import 'package:artty/firestore/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final scheme = Theme.of(context).colorScheme;
        return AlertDialog(
          title: Text(
            'Выйти из аккаунта?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Text(
            'Вы уверены, что хотите выйти из приложения?',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Отмена',
                style: TextStyle(color: scheme.onSurface),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  await AuthService.signOut();
                  // Auth wrapper will handle navigation back to sign in
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Logout failed: $e'),
                      backgroundColor: scheme.error,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: scheme.error,
                foregroundColor: scheme.onError,
              ),
              child: Text('Выйти'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            expandedHeight: 120,
            actions: [
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert,
                  color: scheme.onPrimaryContainer,
                ),
                onSelected: (value) {
                  if (value == 'logout') {
                    _showLogoutDialog(context);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: scheme.error,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Выйти',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: scheme.error,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Alex Rivera'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [scheme.primaryContainer, scheme.inversePrimary]),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(children: const [
                      CircleAvatar(radius: 34, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12')),
                      SizedBox(width: 12),
                      Expanded(child: _Bio()),
                    ]),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(children: const [
                FollowButton(),
                SizedBox(width: 12),
                _Stat(label: 'Followers', value: '12.4k'),
                SizedBox(width: 12),
                _Stat(label: 'Following', value: '318'),
              ]),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList.separated(
            itemCount: 5,
            itemBuilder: (_, i) => Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: PostCard.sample(index: i)),
            separatorBuilder: (_, __) => const SizedBox(height: 16),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }
}

class _Bio extends StatelessWidget {
  const _Bio();
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('@alex_r', style: Theme.of(context).textTheme.titleMedium),
      Text('Painter • Digital artist • NYC', style: Theme.of(context).textTheme.bodyMedium),
    ]);
  }
}

class _Stat extends StatelessWidget {
  final String label; final String value; const _Stat({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(value, style: style.titleLarge),
      Text(label, style: style.labelSmall),
    ]);
  }
}