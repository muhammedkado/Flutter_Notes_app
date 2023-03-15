import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/sherd/const.dart';
import 'package:todo_app/sherd/diohelper.dart';

class OnlineEditNotePage extends StatefulWidget {
  final note;

  const OnlineEditNotePage({super.key, required this.note});

  @override
  _EditNotePageState createState() => _EditNotePageState();
}

class _EditNotePageState extends State<OnlineEditNotePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  HttpHelper httpHelper = HttpHelper();

  Future editNote() async {
    if (_formKey.currentState!.validate()) {
      var response = await httpHelper.postRequest(linkEditeNote, {
        "title": titleController.text,
        "content": contentController.text,
        "id": widget.note['id'].toString(),
      });
      if (response['status'] == 'Seccuss') {
        Navigator.pushNamedAndRemoveUntil(context, 'notes', (route) => false);
      } else {
        AwesomeDialog(context: context, title: 'fail add note pleas try ')
          ..show();
      }
    }
  }

  Future deleteNote() async {
    var response = await httpHelper.postRequest(linkDeleteNote, {
      'id': widget.note['id'].toString(),
    });
    if (response['status'] == 'Seccuss') {
      Navigator.pushNamedAndRemoveUntil(context, 'notes', (route) => false);
    } else {
      AwesomeDialog(context: context, title: 'fail add note pleas try ')
        ..show();
    }
  }

/*
  @override
  void initState() {
    super.initState();

    isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.number ?? 0;
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
  }

 */
  @override
  void initState() {
    // TODO: implement initState
    titleController.text = widget.note['title'];
    contentController.text = widget.note['content'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  maxLines: 1,
                  // initialValue: title,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'this line do not be empty';
                    }
                    return null;
                  },

                  onChanged: (va) {},
                  controller: titleController,
                ),
                TextFormField(
                  controller: contentController,
                  maxLines: 16,
                  //  initialValue: description,
                  style: const TextStyle(color: Colors.white60, fontSize: 18),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type something...',
                    hintStyle: TextStyle(color: Colors.white60),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'this line do not be empty';
                    }
                    return null;
                  },
                  onChanged: (val) {},
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildButton() {
    //final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        children: [
          IconButton(
              onPressed: () async {
                await deleteNote();
              },
              icon: Icon(Icons.delete)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.purple[50],
              backgroundColor: Colors.purple[800],
            ),
            onPressed: () async {
              await editNote();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
