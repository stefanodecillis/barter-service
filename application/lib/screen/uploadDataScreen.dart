import 'package:barter/constants.dart';
import 'package:barter/entity/post.dart';
import 'package:barter/event/uploadProcessEvent.dart';
import 'package:barter/handler/coreLogic.dart';
import 'package:barter/logic/uploadProcessLogic.dart';
import 'package:barter/state/uploadProcessState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UploadDataScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
          _titleController.text = "";
          _descriptionController.text = "";

          String hints = state.imageRecognitionResult==null?null:state.imageRecognitionResult.providedResults();

          return SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.only( bottom: 10),
                    child: Image.file(
                      state.image,
                      //height: 200,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                    child: TitleInput(
                  controller: _titleController,
                      hint: hints,
                )),
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: DescriptionInput(
                  controller: _descriptionController,
                )),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 40,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    onPressed: () {
                      if (_titleController.text.isEmpty ||
                          _descriptionController.text.isEmpty) {
                        onError(context, "Please fill all the field");
                        return;
                      }
                      onSuccess(context);
                      CoreLogic.instance.uploadProcessLogic.add(UploadPost(post: Post.file(title: _titleController.text,
                          description: _descriptionController.text, file: state.image)),
                      );
                    },
                    color: mainTheme,
                    textColor: Colors.white,
                    child: Text("Upload".toUpperCase(),
                        style: TextStyle(fontSize: 16)),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void onSuccess(BuildContext context) {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Congraturations!",
      desc:
          "Your item post is pending for review by our team. \nIt will be evaluated within 24h",
      buttons: [
        DialogButton(
          child: Text(
            "GOT IT",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            while (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(0.0),
        ),
      ],
    ).show();
  }

  void onError(BuildContext context, String description) {
    Alert(
      context: context,
      type: AlertType.info,
      title: "Ops!",
      desc: description,
      buttons: [
        DialogButton(
          child: Text(
            "CANCEL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: mainTheme,
          radius: BorderRadius.circular(0.0),
        ),
      ],
    ).show();
  }
}

class TitleInput extends StatelessWidget {
  TitleInput({this.controller, this.hint});
  final String hint;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.15,
          decoration: BoxDecoration(
              border: Border.all(color: secondTheme),
              shape: BoxShape.rectangle),
          child: Center(
              child: Padding(
                  padding: EdgeInsets.only(left: 3, right: 3),
                  child: Text("Title",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)))),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: secondTheme),
          ),
          child: TextFormField(
            controller: controller,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
                hintText: hint==null?"Name of the object": hint,
                contentPadding: EdgeInsets.only(left: 20)),
          ),
        ),
      ],
    );
  }
}

class DescriptionInput extends StatelessWidget {
  DescriptionInput({this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: secondTheme),
              shape: BoxShape.rectangle),
          child: Center(
              child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text("Description",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)))),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            border: Border.all(color: secondTheme),
          ),
          child: TextFormField(
            controller: controller,
            style: TextStyle(fontSize: 20),
            maxLines: null,
            decoration: InputDecoration(
                hintText: "Put here its description",
                contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10)),
          ),
        ),
      ],
    );
  }
}
