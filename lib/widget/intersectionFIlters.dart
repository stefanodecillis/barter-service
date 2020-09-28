import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntersectionFilters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Container(
                child: Center(child: Text('filter 1')),
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Container(
                child: Center(child: Text('filter 1')),
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Container(
                child: Center(child: Text('filter 1')),
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Container(
                child: Center(child: Text('filter 1')),
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Container(
                child: Center(child: Text('filter 1')),
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
              ),
            ),
          ],
        ));
  }
}
