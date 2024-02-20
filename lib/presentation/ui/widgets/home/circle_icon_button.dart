import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.onTap,
    required this.iconData,
  });
  final VoidCallback onTap;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: CircleAvatar(
          radius: 15.0,
          backgroundColor: Colors.grey.shade200,
          child: Icon(
            iconData,
            size: 20.0,
          ),
        ),
      ),
    );
  }
}
