import 'package:barter/constants.dart';
import 'package:barter/handler/coreLogic.dart';
import 'package:barter/logic/postLogic.dart';
import 'package:barter/state/postState.dart';
import 'package:barter/widget/postCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreferPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: secondTheme,
        appBar: AppBar(
          backgroundColor: mainTheme,
          title: Text("Love Items"),
          centerTitle: true,
        ),
        body: BlocBuilder<PostLogic, PostState>(
          cubit: CoreLogic.instance.postLogic,
          builder: (context, state) {
            if (state.preferPosts.length == 0) {
              return Center(
                child: Text(
                  'No items you love yet!',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.preferPosts.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: PostCard(post: state.preferPosts[index]));
              },
            );
          },
        ));
  }
}
