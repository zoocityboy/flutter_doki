import 'package:flutter/material.dart';

enum Award {
  award1(1, Color(0xff800026)),
  award2(2, Color(0xffbd0026)),
  award3(3, Color(0xffe31a1c)),
  award4(4, Color(0xfffc4e2a)),
  award5(5, Color(0xfffd8d3c)),
  award6(6, Color(0xfffeb24c)),
  award7(7, Color(0xfffed976)),
  award8(8, Color(0xffffeda0)),
  award9(9, Color(0xffffeda0)),
  award10(10, Color(0xffffeda0)),
  defaultAward(-1, Color(0xffffedc9));

  const Award(this.position, this.color);
  final int position;
  final Color color;
}
