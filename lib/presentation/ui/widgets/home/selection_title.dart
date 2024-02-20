import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';

class SelectionTitl extends StatelessWidget {
  final String title;
  final VoidCallback onTapSeeAll;
  const SelectionTitl({
    super.key,
    required this.title,
    required this.onTapSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 6.5),
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: onTapSeeAll,
          child: const Text(
            'See All',
            style: TextStyle(color: AppColors.primaryColor),
          ),
        )
      ],
    );
  }
}
