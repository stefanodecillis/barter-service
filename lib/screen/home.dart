import 'package:barter/event/IntersectionEvent.dart';
import 'package:barter/handler/coreLogic.dart';
import 'package:barter/logic/IntersectionLogic.dart';
import 'package:barter/state/IntersectionState.dart';
import 'package:barter/widget/barterDrawer.dart';
import 'package:barter/widget/intersectionCard.dart';
import 'package:barter/widget/intersectionFIlters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final IntersectionLogic logic = CoreLogic.instance.intersectionLogic;
  TextEditingController _textEditingController = TextEditingController();
  bool searching = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    logic.add(FetchIntersections());
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: searching
              ? TextField(
                  controller: _textEditingController,
                  onSubmitted: (str) => onSearchBtnPressed(),
                  style: TextStyle(fontSize: 20, color: Colors.white))
              : Text('Barter'),
          actions: [
            BlocBuilder<IntersectionLogic, IntersectionState>(
              cubit: logic,
              builder: (context, state) {
                if (state.filtered) {
                  return IconButton(
                    icon: Icon(Icons.settings_backup_restore),
                    onPressed: () {
                      logic.add(RestoreResult());
                    },
                  );
                } else {
                  return IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      if (searching)
                        logic.add(FetchFilter(_textEditingController.text));
                      setState(() {
                        searching = !searching;
                      });
                    },
                  );
                }
              },
            ),
          ],
        ),
        drawer: BarterDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.red,
          child: Icon(Icons.add),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          searching ? IntersectionFilters() : SizedBox(),
          BlocBuilder<IntersectionLogic, IntersectionState>(
            cubit: logic,
            builder: (context, state) {
              var list = state.filtered
                  ? state.filteredIntersections
                  : state.intersections;
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  padding: EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: IntersectionCard(
                        intersection: list[index],
                      ),
                    );
                  });
            },
          )
        ])));
  }

  void onSearchBtnPressed() {
    if (searching) logic.add(FetchFilter(_textEditingController.text));
    setState(() {
      searching = !searching;
    });
  }
}
