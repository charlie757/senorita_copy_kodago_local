import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final bool isActive;
  const Indicator(this.isActive, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 5),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: isActive?Colors.white:Colors.grey,
          borderRadius: BorderRadius.circular(8)
      ),
    );
  }
}