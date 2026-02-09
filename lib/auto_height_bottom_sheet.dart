/// A modal bottom sheet whose height adapts to content and keyboard.
///
/// Use [showAutoHeightBottomSheet] to display a bottom sheet, and
/// [AutoHeightSheet] as the content widget. The sheet height follows its
/// content, avoids extra rebuilds common with [showModalBottomSheet], and
/// shifts with the keyboard so inputs are not covered.
library;

export 'src/auto_height_bottom_sheet.dart';
