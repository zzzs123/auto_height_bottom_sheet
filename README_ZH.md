# auto_height_bottom_sheet

[English](README.md) | **中文**

---

一个 Flutter 底部弹窗（Bottom Sheet）组件，高度随内容与键盘自适应，并避免官方 `showModalBottomSheet` 带来的多余重建。

![Demo](https://github.com/user-attachments/assets/b52279ba-fb63-48a6-8a4f-55531fd56c38)


![showModalBottomSheet rebuild](https://github.com/user-attachments/assets/712890f1-8356-4be4-8853-615acae58be0)


## 功能特点

### 1. 高度随内容自适应

弹窗高度会根据内部内容（content）自动计算，无需手动指定固定高度或最大高度。内容多则弹窗高，内容少则弹窗矮，避免留白或超出屏幕。

### 2. 避免多次 Rebuild

在官方 `showModalBottomSheet` 中，某些场景下会触发多次不必要的 `build`，影响性能和状态。本组件在实现上规避了这类问题，减少多余重建，使弹窗表现更稳定。

### 3. 随键盘高度调整，不遮挡输入框

当弹窗内存在 `TextField` 等输入控件时，键盘弹出后，弹窗高度会随键盘高度自动上移调整，输入区域不会被键盘遮挡。

### 4. 支持在 Sheet 上覆盖 LoadingIndicator

可以在弹窗内容之上叠加加载指示器（如提交时的 loading），只需用 `Stack` 包住`AutoHeightSheet`与 `ValueListenableBuilder`，例如：

```dart
return Stack(
  children: [
    AutoHeightSheet...,
    ValueListenableBuilder(
      valueListenable: controller.showLoadingIndicator,
      builder: (context, value, child) {
        return value ? const LoadingIndicator() : const SizedBox.shrink();
      },
    ),
  ],
);
```

## 安装

在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  auto_height_bottom_sheet: ^0.0.1
```

然后执行：

```bash
flutter pub get
```

## 使用示例

```dart
import 'package:auto_height_bottom_sheet/auto_height_bottom_sheet.dart';

// 显示自适应高度的底部弹窗
showAutoHeightBottomSheet(
  context: context,
  builder: (context) => AutoHeightSheet(
      scrollableChild: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(mainAxisSize: MainAxisSize.min, children: [...]),
      ),
    ),
);
```

### AutoHeightSheet 用法

- **header 与 footer**：相当于滚动区域内的**固定头部/底部**（persistent header/footer），不会随内容一起滚动，始终可见。
- **中间内容**：只能使用 **`scrollableChild`** 或 **`children`** 其一，不能同时使用。
  - **`scrollableChild`**：中间可滚动区域。建议在里面放一个 **`SingleChildScrollView`** 或 **`ListView`**，并设置 **`shrinkWrap: true`**，这样才能利用内部 Scaffold 的 `resizeToAvoidBottomInset` 和滚动，在键盘弹出时避免遮挡输入框。
  - **`children`**：中间内容为一组子组件，行为类似 **`ListView` 的 `children`**，由组件内部处理滚动。

示例：

```dart
AutoHeightSheet(
  header: AppBar(title: Text('标题')),
  footer: Padding(
    padding: EdgeInsets.all(16),
    child: ElevatedButton(onPressed: () {}, child: Text('确定')),
  ),
  scrollableChild: SingleChildScrollView(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(decoration: InputDecoration(labelText: '输入框')),
        // ...
      ],
    ),
  ),
);
```

### 主要 API

- **`showAutoHeightBottomSheet`**：展示底部弹窗，返回 `Future<T?>`，关闭时可传回结果。
- **`AutoHeightSheet`**：弹窗内容容器，支持：
  - `header`：顶部固定区域（不随滚动）
  - `footer`：底部固定区域（不随滚动）
  - `scrollableChild`：可滚动子组件（与 `children` 二选一；建议用 `SingleChildScrollView`/`ListView(shrinkWrap: true)` 以配合键盘）
  - `children`：中间子组件列表（与 `scrollableChild` 二选一；行为类似 ListView 的 children）
  - `topMargin`、`backgroundColor`、`isDismissible` 等

更多用法与参数可参考源码注释或 `example` 示例工程。
