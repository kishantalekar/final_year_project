import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SummaryCountCard extends StatelessWidget {
  const SummaryCountCard({
    super.key,
    required this.title,
    this.count = 0,
  });
  final String title;
  final int count;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(TSizes.borderRadiusMd)),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              count.toString(),
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}
