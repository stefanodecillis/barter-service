import 'package:barter/constants.dart';
import 'package:barter/event/postEvent.dart';
import 'package:barter/handler/coreLogic.dart';
import 'package:barter/logic/postLogic.dart';
import 'package:barter/screen/uploadScreen.dart';
import 'package:barter/state/postState.dart';
import 'package:barter/widget/barterDrawer.dart';
import 'package:barter/widget/postCard.dart';
import 'package:barter/widget/postFIlters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PostLogic logic = CoreLogic.instance.postLogic;
  TextEditingController _textEditingController = TextEditingController();
  bool searching = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    logic.add(FetchPosts());
    return Scaffold(
        backgroundColor: secondTheme,
        appBar: AppBar(
          backgroundColor: mainTheme,
          centerTitle: true,
          title: searching
              ? TextField(
                  controller: _textEditingController,
                  onSubmitted: (str) => onSearchBtnPressed(),
                  style: TextStyle(fontSize: 20, color: Colors.white))
              : Text('Barter'),
          actions: [
            BlocBuilder<PostLogic, PostState>(
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UploadScreen()),
            );
          },
          backgroundColor: mainTheme,
          child: Icon(Icons.add),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          searching ? PostFilters() : SizedBox(),
          BlocBuilder<PostLogic, PostState>(
            cubit: logic,
            builder: (context, state) {
              var list = state.filtered ? state.filteredPosts : state.posts;
              return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: list.length,
                  padding: EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: PostCard(
                        post: list[index],
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
