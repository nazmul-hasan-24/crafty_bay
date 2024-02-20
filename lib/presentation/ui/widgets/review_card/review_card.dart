import 'package:crafty_bay/data/models/review_data.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatefulWidget {
  const ReviewCard({
    super.key,
    required this.reviewData,
  });

  final ReviewData reviewData;

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1.0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18.0,
                  backgroundColor: Colors.blueGrey.shade100,
                  child: const Icon(
                    Icons.person_outline,
                    color: Colors.lightBlue,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        '${widget.reviewData.profile!.cusName}',
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 22,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    const Icon(Icons.star, color: Colors.amberAccent),
                    Text(widget.reviewData.rating.toString())
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                '${widget.reviewData.description}',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
