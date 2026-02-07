import 'package:flutter/material.dart';

class NormalPage extends StatelessWidget {
  NormalPage({super.key});

  final firstFocusNode = FocusNode();
  final secondFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final children = [
      AppBar(
        title: Text('Normal Page'),
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
          focusNode: firstFocusNode,
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
          focusNode: secondFocusNode,
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
              firstFocusNode.unfocus();
              secondFocusNode.unfocus();
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

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(mainAxisSize: MainAxisSize.min, children: children),
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
