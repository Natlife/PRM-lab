import 'package:uuid/uuid.dart';
import '../models/task.dart';

class TaskRepository {
  final List<Task> _tasks = [];
  final _uuid = const Uuid();

  List<Task> get tasks => List.unmodifiable(_tasks);

  Task addTask(String title) {
    final task = Task(
      id: _uuid.v4(),
      title: title,
    );
    _tasks.add(task);
    return task;
  }

  bool deleteTask(String id) {
    final initialLength = _tasks.length;
    _tasks.removeWhere((task) => task.id == id);
    return _tasks.length < initialLength;
  }

  Task? updateTask(String id, {String? title, bool? completed}) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index == -1) return null;

    if (title != null) _tasks[index].title = title;
    if (completed != null) _tasks[index].completed = completed;
    return _tasks[index];
  }

  void clear() {
    _tasks.clear();
  }
}
