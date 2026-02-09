# auto_height_bottom_sheet

**English** | [中文](README_ZH.md)

---

A Flutter bottom sheet widget whose height adapts to content and keyboard, and which avoids the extra rebuilds that can occur with the official `showModalBottomSheet`.

![Demo](https://github.com/user-attachments/assets/b52279ba-fb63-48a6-8a4f-55531fd56c38)

![showModalBottomSheet rebuild](https://github.com/user-attachments/assets/712890f1-8356-4be4-8853-615acae58be0)

## Features

### 1. Height adapts to content

Sheet height is computed from its content—no fixed or max height needed. More content means a taller sheet; less content means a shorter one, with no awkward empty space or overflow.

### 2. Fewer unnecessary rebuilds

The official `showModalBottomSheet` can trigger multiple redundant `build` calls in some cases, affecting performance and state. This implementation avoids that, reducing rebuilds and keeping the sheet behavior stable.

### 3. Adjusts with keyboard—inputs stay visible

When the sheet contains inputs like `TextField`, it shifts up with the keyboard so the focused field is not covered.

### 4. Overlay a LoadingIndicator on the sheet

You can show a loading overlay on top of the sheet (e.g. while submitting) by wrapping `AutoHeightSheet` in a `Stack`:

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

## Installation

Add the dependency in `pubspec.yaml`:

```yaml
dependencies:
  auto_height_bottom_sheet: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Usage

```dart
import 'package:auto_height_bottom_sheet/auto_height_bottom_sheet.dart';

// Show a bottom sheet that adapts to content height
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

### AutoHeightSheet usage

- **header and footer** — Act as **persistent header/footer** inside the scroll area: they do not scroll with the content and stay visible.
- **Middle content** — Use either **`scrollableChild`** or **`children`** (not both).
  - **`scrollableChild`** — The scrollable middle section. Prefer putting a **`SingleChildScrollView`** or **`ListView`** with **`shrinkWrap: true`** here so the inner Scaffold’s `resizeToAvoidBottomInset` and scrolling can keep the keyboard from covering inputs.
  - **`children`** — The middle content is a list of widgets, similar to **`ListView`’s `children`**; scrolling is handled internally.

Example with `scrollableChild` (recommended when using inputs so the keyboard doesn’t cover them):

```dart
AutoHeightSheet(
  header: AppBar(title: Text('Title')),
  footer: Padding(
    padding: EdgeInsets.all(16),
    child: ElevatedButton(onPressed: () {}, child: Text('Confirm')),
  ),
  scrollableChild: SingleChildScrollView(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(decoration: InputDecoration(labelText: 'Input')),
        // ...
      ],
    ),
  ),
);
```

### Main API

- **`showAutoHeightBottomSheet`** — Presents the bottom sheet and returns a `Future<T?>` that completes with a value when the sheet is closed (if any).
- **`AutoHeightSheet`** — The sheet content container:
  - `header` — Persistent top area (does not scroll)
  - `footer` — Persistent bottom area (does not scroll)
  - `scrollableChild` — Single scrollable child (use this or `children`; prefer `SingleChildScrollView` or `ListView(shrinkWrap: true)` for keyboard behavior)
  - `children` — List of middle children (use this or `scrollableChild`; behaves like ListView’s children)
  - `topMargin`, `backgroundColor`, `isDismissible`, and more

See the source docs or the `example` app for more options and parameters.
