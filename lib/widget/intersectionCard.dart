import 'package:barter/entity/intersection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntersectionCard extends StatelessWidget {
  IntersectionCard({this.intersection});
  final Intersection intersection;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.all(Radius.circular(20))),
      width: double.maxFinite,
      child: Row(children: [
        SizedBox(
          width: 20,
        ),
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Image.network(
            intersection.imgUrl,
            height: 140,
            width: 140,
          ),
        ),
        Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              intersection.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Text(intersection.description),
          ],
        ),
        Spacer()
      ]),
    );
  }
}
