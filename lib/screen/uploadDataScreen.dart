import 'package:barter/constants.dart';
import 'package:barter/handler/coreLogic.dart';
import 'package:barter/logic/uploadProcessLogic.dart';
import 'package:barter/state/uploadProcessState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondBg,
      appBar: AppBar(
        backgroundColor: mainTheme,
      ),
      body: BlocBuilder<UploadProcessLogic, UploadProcessState>(
        cubit: CoreLogic.instance.uploadProcessLogic,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Image.file(
                      state.image,
                      height: 200,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Center(child: TitleInput()),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TitleInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: secondTheme),
              shape: BoxShape.rectangle),
          child: Center(
              child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text("Title", style: TextStyle(fontSize: 20)))),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: secondTheme),
          ),
          child: TextFormField(
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
                hintText: "Name of the object",
                contentPadding: EdgeInsets.only(left: 20)),
          ),
        ),
      ],
    );
  }
}
