import 'package:flutter/material.dart';
import 'package:idm_phone/data.dart';

class PointInfo extends StatelessWidget {
  const PointInfo({Key? key, required this.point, this.isRecent = false})
      : super(key: key);

  final IdmPathPoint point;
  final bool isRecent;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isRecent ? "Данные о последней точке" : "Данные о точке",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 28,
          ),
        ),
      ],
    );
  }
}
