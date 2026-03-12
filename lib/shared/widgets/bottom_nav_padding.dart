import 'package:flutter/material.dart';

class BottomNavPadding extends StatelessWidget {
  const BottomNavPadding({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    return SizedBox(height: 80 + bottomInset);
  }
}