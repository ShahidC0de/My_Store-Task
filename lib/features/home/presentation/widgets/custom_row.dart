import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:task/core/theme/pallete.dart';

class CustomRow extends StatelessWidget {
  final String productAttributeTitle;
  final String productAttributeValue;
  final double? ratings;

  const CustomRow({
    super.key,
    required this.productAttributeTitle,
    required this.productAttributeValue,
    this.ratings,
  });

  @override
  Widget build(BuildContext context) {
    if (productAttributeTitle == "Description") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$productAttributeTitle:',
            style: Pallete.titleText.copyWith(fontSize: 12),
          ),
          const SizedBox(height: 5),
          Text(
            productAttributeValue,
            style: Pallete.normalSizeText.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 10),
        ],
      );
    } else if (ratings != null && ratings! > 0) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$productAttributeTitle:',
              style: Pallete.titleText.copyWith(fontSize: 12),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            ratings!.toStringAsFixed(1),
            style: Pallete.normalSizeText.copyWith(fontSize: 12),
          ),
          const SizedBox(width: 5),
          RatingBarIndicator(
            rating: ratings!,
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 16,
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            '$productAttributeTitle:',
            style: Pallete.titleText.copyWith(fontSize: 12),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            productAttributeValue,
            style: Pallete.normalSizeText,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
