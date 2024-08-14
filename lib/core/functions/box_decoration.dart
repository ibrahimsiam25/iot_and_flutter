
  import 'package:flutter/material.dart';

BoxDecoration boxDecoration() {
    return const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff4d6c92),
              Color(0xff1d1a30),
              Color(0xff1d1a30),
              Color(0xff1d1a30),
              Color(0xff4d6c92),
            ],
            tileMode: TileMode.clamp,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        );
  }