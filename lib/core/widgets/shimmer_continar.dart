import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';


class ShimmerContinar extends StatelessWidget {
  const ShimmerContinar({super.key});

  @override
  Widget build(context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Shimmer.fromColors(
          baseColor:  Color(0xff1d1a30),
          highlightColor:  Color(0xff4d6c92),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                color: Color(0xff4d6c92),
                borderRadius: BorderRadius.circular(16)),
          )),
    );
  }
}
