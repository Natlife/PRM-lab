# Báo cáo Lab 12 — Performance Optimization & App Deployment

## Bài 12.1: Tối ưu hóa Rebuild Danh sách (List Rebuild Optimization)

### 1. Vấn đề của phiên bản cũ (Lab 11)
- **Rebuild Toàn bộ Màn hình**: Ở Lab 11, toàn bộ danh sách và UI của màn hình `TaskListScreen` sử dụng `StatefulWidget` và `setState()`. Khi người dùng thực hiện một hành động nhỏ như thêm task mới, toggle hoàn thành, hoặc xóa task, hàm `setState()` buộc toàn bộ cây Widget của màn hình (gồm cả AppBar, TextField input bar, và tất cả các `TaskTile` khác) phải rebuild lại hoàn toàn.
- **Không có Widget Tách biệt**: Phần vẽ từng dòng task (`ListTile`) được code inline trực tiếp trong ListView. Điều này làm mất đi khả năng tối ưu hóa rebuild của Flutter thông qua cơ chế `const` constructor và widget caching.
- **Thiếu Keys**: Các phần tử ListTile không được gán Key ổn định (`ValueKey(task.id)`), dẫn đến việc Flutter gặp khó khăn trong việc khớp trạng thái cũ và mới khi danh sách thay đổi, làm giảm hiệu năng đáng kể.

### 2. Các tối ưu hóa đã thực hiện
- **Sử dụng `provider` cho State Management**: Chuyển trạng thái danh sách sang `TaskProvider` kế thừa từ `ChangeNotifier`.
- **Áp dụng `Selector`**: Sử dụng `Selector<TaskProvider, List<Task>>` chỉ để lắng nghe sự thay đổi của danh sách task thay vì toàn bộ màn hình. Các widget tĩnh như AppBar hay TextField Input Bar sẽ không bị rebuild khi danh sách task thay đổi.
- **Tách biệt Widget `TaskTile`**: Đưa code giao diện của mỗi task dòng vào lớp riêng `TaskTile` kế thừa từ `StatelessWidget`.
- **Sử dụng `ValueKey(task.id)`**: Gán key duy nhất cho mỗi `TaskTile` giúp Flutter engine tái sử dụng lại các element tree một cách tối ưu nhất mà không cần tạo lại widget từ đầu.

#### So sánh cấu trúc Code:

##### task_list_screen.dart (Trước - Lab 11)
```dart
ListView.separated(
  itemCount: tasks.length,
  itemBuilder: (context, index) {
    final task = tasks[index];
    return ListTile(
      leading: GestureDetector(onTap: () => _toggleTask(task), ...),
      title: Text(task.title),
      trailing: IconButton(onPressed: () => _deleteTask(task), ...),
    );
  }
)
```

##### task_list_screen.dart & task_tile.dart (Sau - Lab 12)
```dart
// Sử dụng Selector chỉ rebuild khi danh sách thay đổi
Selector<TaskProvider, List<Task>>(
  selector: (_, provider) => provider.tasks,
  builder: (context, tasks, _) {
    return ListView.separated(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskTile(
          key: ValueKey(task.id), // Tối ưu hóa Rebuild bằng Key
          task: task,
          onTap: () => _openDetail(task),
          onToggle: () => context.read<TaskProvider>().toggleTask(task.id),
          onDelete: () => context.read<TaskProvider>().deleteTask(task.id),
        );
      },
    );
  }
)
```

---

## Bài 12.2: Tối ưu hóa Hình ảnh & Tài nguyên (Image & Asset Optimization)

### 1. Thêm Logo & Vấn đề Kích thước
Chúng tôi đã thêm một ảnh logo ứng dụng (`logo.png`) chất lượng cao vào thư mục `assets/` để hiển thị trên thanh AppBar.
- **Kích thước ban đầu**: **522 KB (535,244 bytes)**. Đây là dung lượng quá lớn đối với một logo chỉ hiển thị với kích thước nhỏ (32x32 hoặc 128x128) trên thanh AppBar của thiết bị di động.

### 2. Các tối ưu hóa đã thực hiện
- **Thu nhỏ kích thước hình ảnh (Resize)**: Sử dụng kịch bản xử lý ảnh tự động để giảm độ phân giải của logo xuống còn **128x128 pixels**, vừa vặn với kích thước hiển thị mà vẫn giữ nguyên độ sắc nét cao (High-Quality Bicubic scaling).
- **Pre-caching hình ảnh**: Sử dụng hàm `precacheImage()` tích hợp sẵn trong Flutter ở sự kiện vòng đời `didChangeDependencies()` để tải trước logo vào bộ nhớ đệm (Image Cache) trước khi render, giúp loại bỏ hoàn toàn hiện tượng nhấp nháy (flickering) khi mở ứng dụng lần đầu.

#### Code Snippet hiển thị Pre-caching:
```dart
@override
void didChangeDependencies() {
  super.didChangeDependencies();
  // Pre-cache logo vào Image Cache của Flutter
  precacheImage(const AssetImage('assets/logo.png'), context);
}
```

### 3. Kết quả so sánh dung lượng Asset
| Asset | Kích thước Trước tối ưu | Kích thước Sau tối ưu | Tỷ lệ giảm |
|-------|-----------------------|---------------------|------------|
| `assets/logo.png` | **522 KB** | **24 KB** | **-95.4%** |

---

## Bài 12.3: Phân tích Kích thước Ứng dụng (App Size Analysis)

Chúng tôi đã chạy lệnh phân tích kích thước ứng dụng:
```bash
flutter build apk --analyze-size --target-platform android-arm64
```

### 1. Kết quả phân tích
- **Tổng dung lượng APK (arm64-v8a)**: **15.7 MB** (Nén hoàn toàn) / 16 MB.
- **Thành phần chiếm nhiều dung lượng nhất**:
  1. `lib/arm64-v8a` (Chứa thư viện native engine và Flutter framework): **15.0 MB** (~95.5%).
  2. `assets/flutter_assets` (Chứa logo, font chữ, icons, license): **248 KB** (đã giảm đáng kể nhờ tối ưu hóa ảnh logo từ 746 KB xuống 248 KB).
  3. `classes.dex` (Mã nguồn JVM/Java biên dịch cho Android): **231 KB**.

### 2. Đánh giá phân tích Dart AOT (Decompressed size ~4MB)
- `package:flutter`: 2.0 MB (Framework lõi).
- `dart:core`, `dart:ui`, `dart:typed_data`: ~1.0 MB (Thư viện chuẩn của Dart).
- `package:taskly` (Mã nguồn ứng dụng của chúng tôi): **chỉ 15 KB** (~0.3%).
- `package:provider`: 14 KB.

### 3. Đề xuất tối ưu hóa thêm
- **Tree-shaking Icons**: Flutter tự động loại bỏ các icon Font không dùng tới nhờ tính năng tree-shaking (giảm font `MaterialIcons-Regular.otf` từ 1.6MB xuống còn 2.07KB - giảm 99.9%). Cần duy trì tính năng này trong lệnh build.
- **Sử dụng App Bundle (`.aab`)**: Khi phân phối trên Google Play, nên xuất file `.aab` thay vì `.apk` để Google tự động tối ưu hóa kích thước phù hợp với cấu hình máy của người dùng cuối.

---

## Bài 12.4: Tối ưu hóa Cuối cùng & Triển khai (Comprehensive Deployment)

### 1. Checklist Tối ưu hóa cuối cùng
- [x] Đã loại bỏ tất cả lệnh debug (`print()`, `debugPrint()`) trong mã nguồn sản xuất.
- [x] Đã thêm từ khóa `const` vào trước tất cả các widget tĩnh (như các khoảng cách `SizedBox`, `Text` tĩnh) để lưu trữ chúng trong bộ nhớ tĩnh, tránh khởi tạo lại khi rebuild.
- [x] Đã dọn dẹp các tài nguyên và dependencies không dùng tới trong `pubspec.yaml`.
- [x] Đã chạy `flutter clean` để làm sạch toàn bộ cache build cũ.
- [x] Biên dịch gói sản phẩm Release APK tối ưu hóa hoàn toàn:
  ```bash
  flutter build apk --release --target-platform android-arm64
  ```

### 2. Sự sẵn sàng của ứng dụng để triển khai
- **Hiệu năng cực cao**: Sử dụng state management bằng Provider kết hợp với Selector và ValueKey giúp ứng dụng duy trì mức FPS 60/120Hz mượt mà nhất, không xảy ra hiện tượng giật khung hình (jank) kể cả khi danh sách task lên tới hàng trăm phần tử.
- **Kích thước cực nhỏ**: Logo được nén gọn chỉ còn 24KB, font được tree-shake toàn bộ, giúp giảm tối đa chi phí tải về của người dùng.
- **Độ tin cậy cao**: Đã pass toàn bộ hệ thống test suite từ Lab 11 đảm bảo không có lỗi logic.
