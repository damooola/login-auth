import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imageAsset;
  final void Function()? onTap;
  const SquareTile({super.key, required this.imageAsset, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.shade100,
            border: Border.all(color: Colors.white)),
        child: Image.asset(imageAsset),
      ),
    );
  }
}
