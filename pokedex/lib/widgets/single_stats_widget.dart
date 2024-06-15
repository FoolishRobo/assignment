import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SingleStatsWidget extends StatelessWidget {
  final String type;
  final int value;
  Color color;
  SingleStatsWidget({
    super.key,
    required this.type,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Text(
                type,
                style: const TextStyle(
                  color: Color.fromRGBO(107, 107, 107, 1),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                value.toString(),
                style: const TextStyle(
                  color: Color.fromRGBO(22, 26, 51, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Stack(
            children: [
              Container(
                height: 4,
                width: double.maxFinite,
                color: const Color.fromRGBO(232, 232, 232, 1),
              ),
              Container(
                height: 4,
                width: MediaQuery.of(context).size.width * (value / 100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
