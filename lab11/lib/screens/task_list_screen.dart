import 'package:flutter/material.dart';
import '../models/task.dart';
import '../repositories/task_repository.dart';
import 'task_detail_screen.dart';

class TaskListScreen extends StatefulWidget {
  final TaskRepository? repository;

  const TaskListScreen({super.key, this.repository});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late final TaskRepository _repository;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _repository = widget.repository ?? TaskRepository();
  }

  void _addTask() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _repository.addTask(text);
      _controller.clear();
    });
  }

  void _toggleTask(Task task) {
    setState(() {
      _repository.updateTask(task.id, completed: !task.completed);
    });
  }

  void _deleteTask(Task task) {
    setState(() {
      _repository.deleteTask(task.id);
    });
  }

  Future<void> _openDetail(Task task) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TaskDetailScreen(
          task: task,
          repository: _repository,
        ),
      ),
    );
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = _repository.tasks;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF313244),
        title: const Text(
          'Taskly',
          style: TextStyle(
            color: Color(0xFFCDD6F4),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFF313244),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    key: const Key('addTaskField'),
                    controller: _controller,
                    style: const TextStyle(color: Color(0xFFCDD6F4)),
                    decoration: InputDecoration(
                      hintText: 'Enter a new task...',
                      hintStyle: const TextStyle(color: Color(0xFF6C7086)),
                      filled: true,
                      fillColor: const Color(0xFF45475A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    onSubmitted: (_) => _addTask(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  key: const Key('addTaskButton'),
                  onPressed: _addTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCBA6F7),
                    foregroundColor: const Color(0xFF1E1E2E),
                    padding: const EdgeInsets.all(14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Icon(Icons.add, size: 24),
                ),
              ],
            ),
          ),
          Expanded(
            child: tasks.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.checklist_rounded,
                          size: 80,
                          color: Color(0xFF6C7086),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No tasks yet. Add one!',
                          style: TextStyle(
                            color: Color(0xFF6C7086),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: tasks.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return _TaskTile(
                        task: task,
                        onTap: () => _openDetail(task),
                        onToggle: () => _toggleTask(task),
                        onDelete: () => _deleteTask(task),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const _TaskTile({
    required this.task,
    required this.onTap,
    required this.onToggle,
    required this.onDelete,
  });

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
