import 'package:flutter/material.dart';
import 'package:artty/widgets/category_filter_strip.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  bool isEvent = false;
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  String _category = 'Painting';

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(isEvent ? 'Share Event' : 'Create Post')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _ModeChip(
                  icon: Icons.image_outlined,
                  label: 'Post',
                  selected: !isEvent,
                  onTap: () => setState(() => isEvent = false),
                ),
                const SizedBox(width: 12),
                _ModeChip(
                  icon: Icons.event_outlined,
                  label: 'Event',
                  selected: isEvent,
                  onTap: () => setState(() => isEvent = true),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                prefixIcon: Icon(Icons.title, color: Colors.blue),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descController,
              maxLines: 6,
              decoration: InputDecoration(
                labelText: isEvent ? 'Description & details' : 'Caption / Description',
                alignLabelWithHint: true,
                prefixIcon: const Icon(Icons.edit_note, color: Colors.purple),
                border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
              ),
            ),
            const SizedBox(height: 12),
            Text('Category', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            CategoryFilterStrip(
              categories: const ['Painting', 'Digital', 'Jewelry', 'Clothing', 'Sculpture', 'Photography'],
              selected: _category,
              onChanged: (c) => setState(() => _category = c),
            ),
            const SizedBox(height: 16),
            if (isEvent) ...[
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Location',
                  prefixIcon: Icon(Icons.location_on, color: Colors.red),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
                ),
              ),
              const SizedBox(height: 12),
              Row(children: const [
                Expanded(child: _DateField(label: 'Start date', icon: Icons.calendar_today)),
                SizedBox(width: 12),
                Expanded(child: _DateField(label: 'End date', icon: Icons.calendar_month)),
              ]),
              const SizedBox(height: 16),
            ],
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.publish, color: Colors.white),
                label: Text(isEvent ? 'Publish Event' : 'Share Post'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: scheme.primary,
                  foregroundColor: scheme.onPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModeChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _ModeChip({required this.icon, required this.label, required this.selected, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? scheme.primaryContainer : scheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: selected ? scheme.primary : scheme.onSurface.withValues(alpha: 0.12)),
        ),
        child: Row(children: [
          Icon(icon, color: selected ? Colors.blue : Colors.grey),
          const SizedBox(width: 8),
          Text(label, style: Theme.of(context).textTheme.labelLarge),
        ]),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final String label; final IconData icon;
  const _DateField({required this.label, required this.icon});
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.teal),
        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
      ),
      readOnly: true,
      onTap: () {},
    );
  }
}