import 'package:flutter/material.dart';

class WeightWidget extends StatelessWidget {
  final String type;
  final String value;
  const WeightWidget({
    super.key,
    required this.type,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 48,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            type,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Color.fromRGBO(107, 107, 107, 1),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color.fromRGBO(22, 26, 51, 1),
            ),
          ),
        ],
      ),
    );
  }
}
