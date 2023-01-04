import 'package:flutter/material.dart';

double distance = 16;

BoxDecoration boxDecoration = BoxDecoration(
  color: Colors.grey[200],
  borderRadius: BorderRadius.circular(16.0),
  boxShadow: [
    BoxShadow(
      offset: Offset(distance, distance),
      color: Colors.black38,
      blurRadius: distance,
      spreadRadius: 2,
    ),
    BoxShadow(
      offset: Offset(-distance, -distance),
      color: Colors.white70,
      blurRadius: distance,
      spreadRadius: 2,
    ),
  ],
);

BoxDecoration btnBoxDecoration = BoxDecoration(
  color: Colors.grey[200],
  borderRadius: BorderRadius.circular(16.0),
  boxShadow: const [
    BoxShadow(
      offset: Offset(10, 10),
      color: Colors.black38,
      blurRadius: 14,
      spreadRadius: 1,
    ),
    BoxShadow(
      offset: Offset(-10, -10),
      color: Colors.white12,
      blurRadius: 14,
      spreadRadius: 1,
    ),
  ],
);