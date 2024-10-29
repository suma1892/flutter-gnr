import 'package:flutter/material.dart';

class MainServiceTab extends StatelessWidget {
  const MainServiceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          ElevatedButton(onPressed: () => {}, child: Text('test')),
          ElevatedButton(onPressed: () => {}, child: Text('test')),
          ElevatedButton(onPressed: () => {}, child: Text('test'))
        ],
      ),
    );
  }
}
