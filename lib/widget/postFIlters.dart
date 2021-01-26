import 'package:barter/constants.dart';
import 'package:barter/event/postEvent.dart';
import 'package:barter/handler/coreLogic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostFilters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            PostFilter(
              name: "Near",
            ),
            PostFilter(name: "Cheap"),
            PostFilter(name: "Homemade"),
            PostFilter(name: "Vintage"),
          ],
        ));
  }
}

class PostFilter extends StatefulWidget {
  PostFilter({this.name});
  final String name;

  @override
  _PostFilterState createState() => new _PostFilterState(name: name);
}

class _PostFilterState extends State<PostFilter> {
  _PostFilterState({this.name});
  final String name;
  bool isEnabled = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isEnabled = !isEnabled;
          });
          CoreLogic.instance.postLogic.add(AddFilter(name));
        },
        child: Container(
          child: Center(child: Text(name)),
          width: 100,
          height: 30,
          decoration: BoxDecoration(
              color: isEnabled ? enabledSecondTheme : secondBg,
              borderRadius: BorderRadius.all(Radius.circular(40))),
        ),
      ),
    );
  }
}
