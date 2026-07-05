# Lab 11 — Testing & Debugging In Flutter (Taskly App)

## Mô tả

**Taskly App** là một ứng dụng quản lý task đơn giản được xây dựng để minh hoạ các kỹ năng Testing trong Flutter theo 3 cấp độ:

| Cấp độ | Loại Test | File |
|--------|-----------|------|
| 1 | Unit Tests | `test/unit/task_model_test.dart` |
| 1 | Unit Tests | `test/unit/task_repository_test.dart` |
| 2 | Widget Tests | `test/widget/task_list_widget_test.dart` |
| 2 | Widget Tests | `test/widget/task_detail_widget_test.dart` |
| 3 | Integration Tests | `test/integration/task_integration_test.dart` |

## Cấu trúc Project

```
lab11/
├── lib/
│   ├── main.dart
│   ├── models/
│   │   └── task.dart            # Task model (id, title, completed, toggle())
│   ├── repositories/
│   │   └── task_repository.dart # CRUD: addTask, deleteTask, updateTask
│   └── screens/
│       ├── task_list_screen.dart  # Màn hình danh sách task
│       └── task_detail_screen.dart # Màn hình chi tiết / chỉnh sửa task
└── test/
    ├── unit/
    │   ├── task_model_test.dart       # 6 unit tests cho Task model
    │   └── task_repository_test.dart  # 13 unit tests cho TaskRepository
    ├── widget/
    │   ├── task_list_widget_test.dart   # 6 widget tests cho TaskListScreen
    │   └── task_detail_widget_test.dart # 5 widget tests cho TaskDetailScreen
    └── integration/
        └── task_integration_test.dart  # 5 integration tests end-to-end
```

## Chạy Tests

```bash
# Chạy tất cả tests
flutter test --reporter expanded

# Chỉ chạy unit tests
flutter test test/unit/

# Chỉ chạy widget tests
flutter test test/widget/

# Chỉ chạy integration tests
flutter test test/integration/
```

## Kết quả: **35/35 Tests PASSED ✅**

## Các khái niệm được áp dụng

### 1. Unit Tests (AAA Pattern)
- **Arrange**: Chuẩn bị data và đối tượng cần test
- **Act**: Gọi method cần kiểm tra
- **Assert**: Xác nhận kết quả trả về đúng như kỳ vọng

### 2. Widget Tests
- Dùng `WidgetTester` để tương tác với UI
- `find.byKey()` — tìm widget bằng Key
- `tester.enterText()` — nhập văn bản
- `tester.tap()` / `tester.pump()` — tap + rebuild UI

### 3. Integration Tests
- Kiểm tra toàn bộ flow: từ thêm task → xem list → xoá task → navigate

### 4. Debugging Tools
- Named `Key` trên widget để dễ tìm trong tests
- `setUp()` — reset state trước mỗi test
- `testWidgets()` với `pumpAndSettle()` cho navigation

## Phụ thuộc

```yaml
dependencies:
  uuid: ^4.5.1   # Tạo unique ID cho mỗi Task

dev_dependencies:
  flutter_test:
    sdk: flutter  # Built-in testing framework
```
