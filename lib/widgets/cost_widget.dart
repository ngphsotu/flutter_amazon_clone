import 'dart:ui';
import 'package:flutter/material.dart';

class CostWidget extends StatelessWidget {
  //
  final double cost;
  final Color color;

  const CostWidget({
    Key? key,
    required this.cost,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '\$',
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontFeatures: const [
              FontFeature.superscripts(),
            ],
          ),
        ),
        Text(
          cost.toInt().toString(),
          style: TextStyle(
            color: color,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          (cost - cost.truncate()).toString(),
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontFeatures: const [
              FontFeature.superscripts(),
            ],
          ),
        ),
      ],
    );
  }
}
