import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TaskTile({
    required Key key,
    required this.task,
    required this.onTap,
    required this.onToggle,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF313244),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: GestureDetector(
          onTap: onToggle,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: task.completed
                  ? const Color(0xFFA6E3A1)
                  : Colors.transparent,
              border: Border.all(
                color: task.completed
                    ? const Color(0xFFA6E3A1)
                    : const Color(0xFF6C7086),
                width: 2,
              ),
            ),
            child: task.completed
                ? const Icon(Icons.check, size: 16, color: Color(0xFF1E1E2E))
                : null,
          ),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            color: task.completed
                ? const Color(0xFF6C7086)
                : const Color(0xFFCDD6F4),
            decoration: task.completed ? TextDecoration.lineThrough : null,
            fontSize: 16,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline,
              color: Color(0xFFF38BA8), size: 20),
          onPressed: onDelete,
        ),
        onTap: onTap,
      ),
    );
  }
}
