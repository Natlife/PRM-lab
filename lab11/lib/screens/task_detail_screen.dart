import 'package:flutter/material.dart';
import '../models/task.dart';
import '../repositories/task_repository.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;
  final TaskRepository repository;

  const TaskDetailScreen({
    super.key,
    required this.task,
    required this.repository,
  });

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late TextEditingController _titleController;
  late bool _completed;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _completed = widget.task.completed;
  }

  void _save() {
    widget.repository.updateTask(
      widget.task.id,
      title: _titleController.text.trim(),
      completed: _completed,
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF313244),
        title: const Text(
          'Task Detail',
          style: TextStyle(
            color: Color(0xFFCDD6F4),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFCDD6F4)),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Task Title',
              style: TextStyle(
                color: Color(0xFF6C7086),
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              key: const Key('detailTitleField'),
              controller: _titleController,
              style: const TextStyle(
                color: Color(0xFFCDD6F4),
                fontSize: 18,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF313244),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFCBA6F7),
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
              ),
              maxLines: 3,
              minLines: 1,
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF313244),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SwitchListTile(
                title: const Text(
                  'Completed',
                  style: TextStyle(
                    color: Color(0xFFCDD6F4),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  _completed ? 'Task is done ✓' : 'Task is pending',
                  style: TextStyle(
                    color: _completed
                        ? const Color(0xFFA6E3A1)
                        : const Color(0xFF6C7086),
                    fontSize: 13,
                  ),
                ),
                value: _completed,
                activeColor: const Color(0xFFA6E3A1),
                onChanged: (val) => setState(() => _completed = val),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                key: const Key('saveButton'),
                onPressed: _save,
                icon: const Icon(Icons.save_rounded),
                label: const Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCBA6F7),
                  foregroundColor: const Color(0xFF1E1E2E),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
