import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo_app/modules/online_conect/online_edit_screen.dart';
import 'package:todo_app/modules/online_conect/widget.dart';
import '../../main.dart';
import '../../sherd/const.dart';
import '../../sherd/diohelper.dart';

class OnlineNotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<OnlineNotesPage> {
  bool isLoading = false;
  HttpHelper httpHelper = HttpHelper();

  Future getNote() async {
    var response = await httpHelper.postRequest(linkViewNote, {
      'id': sharedPreferences.getString('id'),
    });
    return response;
  }

  Widget buildNotes() => FutureBuilder(
        future: getNote(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['status'] == 'fail') {
              return Text('No Notes');
            }
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
//final note = snapshot.data[index]['title'];

                return StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  itemCount: snapshot.data['data'].length,
                  staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OnlineEditNotePage(
                                note: snapshot.data['data'][index])));
                      },
                      child: NoteCardWidget(
                        title: snapshot.data['data'][index]['title'],
                        index: index,
                        content: snapshot.data['data'][index]['content'],
                      ),
                    );
                  },
                );
              },
              itemCount: 1,
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Is Loading .....');
          }
          if (snapshot.hasError) {
            return Text('Is have Error .....');
          }
          return Text('Is Loading .....');
        },
      );

  /* Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8),
        itemCount: 2,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          return FutureBuilder(
            future: getNote(),

            builder: (context, snapshot) {

              if (snapshot.hasData) {
                return ListView.builder(

                  shrinkWrap: true,
                  physics:NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    //final note = snapshot.data[index]['title'];
                    return GestureDetector(
                      onTap: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              NoteDetailPage(noteId: snapshot.data['data'][index]['id']),
                        ));

                        refreshNotes();
                      },
                      child: NoteCardWidget(
                          title: snapshot.data['data'][index]['title'],
                          index: index,
                        content:snapshot.data['data'][index]['content'] ,
                      ),
                    );
                  },
                  itemCount:snapshot.data['data'].length ,
                );
              }
              if (snapshot.connectionState==ConnectionState.waiting) {
                return Text('Is Loading .....');
              }
              if (snapshot.hasError) {
                return Text('Is have Error .....');
              }
              return Text('Is Loading .....');
            },
          );
        },
      );


  */
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Notes',
            style: TextStyle(fontSize: 30, color: Colors.purple),
          ),
          actions: [
            Row(
              children: [
                Icon(
                  Icons.note_alt,
                  color: Colors.purple,
                ),
                Text(
                  ': {notes.length}',
                  style: TextStyle(color: Colors.purple[200]),
                ),
              ],
            ),
            const SizedBox(width: 12),
          ],
        ),
        body: Center(
          child: buildNotes(),
        ),
        drawer: Drawer(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.purple,
                  ),
                  title: Text(
                    '${sharedPreferences.getString('username')}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 20, color: Colors.white),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.purple,
                  ),
                  title: Text(
                    '${sharedPreferences.getString('email')}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 15, color: Colors.white),
                  ),
                ),
                ListTile(
                  onTap: () {
                    sharedPreferences.clear();
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'login', (route) => false);
                  },
                  leading: Icon(
                    Icons.logout,
                    color: Colors.purple,
                  ),
                  title: Text(
                    "SignOut",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 15, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          child: Icon(
            Icons.add,
            color: Colors.purple[200],
          ),
          onPressed: () {
            Navigator.of(context).pushNamed('add');

            // refreshNotes();
          },
        ),
      );
}
