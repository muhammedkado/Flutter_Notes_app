import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/sherd/const.dart';
import 'package:todo_app/sherd/diohelper.dart';


class OnlineAddNotePage extends StatefulWidget {

  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<OnlineAddNotePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController=TextEditingController();
  TextEditingController contentController=TextEditingController();

  HttpHelper httpHelper=HttpHelper();
  Future addNote() async{
   if (_formKey.currentState!.validate()) {
     var response = await httpHelper.postRequest(linkAddNote, {
       "title": titleController.text,
       "content": contentController.text,
       "user_id": sharedPreferences.getString('id'),
       "ima": titleController.text,

     });
     if (response['status']=='Seccuss'){
       Navigator.pushNamedAndRemoveUntil(context, 'notes', (route) => false);
     }else{
       AwesomeDialog(
         context:context,
         title: 'fail add note pleas try '
       )..show();
     }
   
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
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              TextFormField(
              maxLines: 1,
             // initialValue: title,
              style:const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Title',
                hintStyle: TextStyle(color: Colors.white70),
              ),
              validator: (val){
                if(val!.isEmpty){
                  return 'this line do not be empty';
                }
                return null;
              },

              onChanged: (va){},
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
              validator: (val){
                if(val!.isEmpty){
                  return 'this line do not be empty';
                }
                return null;
              },
              onChanged: (val){},
            ),
            ],),
          ),
        ),
      );

  Widget buildButton() {
    //final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.purple[200],
          backgroundColor: Colors.purple[800],
        ),
        onPressed: () async{
          await addNote();
        },
        child: const Text('Save'),
      ),
    );
  }
/*
  void addOrUpdateNote() async {

  final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }
      Navigator.of(context).pop();
    }

  }

  Future updateNote() async {
    final note = widget.note!.copy(
      isImportant: isImportant,
      number: number,
      title: title,
      description: description,
    );


    await NotesDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = Note(
      title: title,
      isImportant: true,
      number: number,
      description: description,
      createdTime: DateTime.now(), id: null,
      //id: null,
    );

    await NotesDatabase.instance.create(note);
  }

 */
}
/*
NoteFormWidget(
            isImportant: isImportant,
            number: number,
            title: title,
            description: description,
            onChangedImportant: (isImportant) =>
                setState(() => this.isImportant = isImportant),
            onChangedNumber: (number) => setState(() => this.number = number),
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) =>
                setState(() => this.description = description),
          )
 */