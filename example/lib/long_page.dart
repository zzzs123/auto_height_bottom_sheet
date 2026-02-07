import 'package:auto_height_bottom_sheet/auto_height_bottom_sheet.dart';
import 'package:flutter/material.dart';

class LongController {
  final String title;

  LongController({required this.title});

  final firstFocusNode = FocusNode();
  final secondFocusNode = FocusNode();

  final ValueNotifier<bool> showLoadingIndicator = ValueNotifier(false);

  void confirm() async {
    firstFocusNode.unfocus();
    secondFocusNode.unfocus();

    showLoadingIndicator.value = true;
    await Future.delayed(const Duration(seconds: 3));
    showLoadingIndicator.value = false;
  }
}

class LongPage extends StatelessWidget {
  const LongPage({super.key, required this.controller});

  final LongController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildContent(context),
        ValueListenableBuilder(
          valueListenable: controller.showLoadingIndicator,
          builder: (context, value, child) {
            return value ? const LoadingIndicator() : const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    final children = [
      AppBar(
        title: Text(controller.title),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      Container(height: 250, width: double.infinity, color: Colors.blue),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: TextField(
          focusNode: controller.firstFocusNode,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'TextField 1',
            labelStyle: TextStyle(color: Colors.white),
            filled: true,
            isDense: true,
            fillColor: Colors.blueGrey,
          ),
        ),
      ),
      Container(width: double.infinity, height: 200, color: Colors.green),
      Container(
        margin: EdgeInsets.only(top: 16),
        width: double.infinity,
        height: 200,
        color: Colors.teal,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: TextField(
          focusNode: controller.secondFocusNode,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'TextField 2',
            labelStyle: TextStyle(color: Colors.white),
            filled: true,
            fillColor: Colors.purple,
          ),
        ),
      ),
      Container(width: double.infinity, height: 50, color: Colors.blueGrey),
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: InkWell(
            onTap: () {
              controller.confirm();
            },
            child: Container(
              width: double.infinity,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Center(
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ];

    return AutoHeightSheet(
      scrollableChild: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(mainAxisSize: MainAxisSize.min, children: children),
      ),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      onVerticalDragStart: (_) {},
      child: Container(
        color: Colors.white.withOpacity(0.5),
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
