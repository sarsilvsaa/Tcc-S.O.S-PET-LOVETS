import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:teste/screens/tela_ajustes.dart';

void main() {
  runApp(MaterialApp(
    home: NotepadApp(),
  ));
}

class NotepadApp extends StatefulWidget {
  @override
  _NotepadAppState createState() => _NotepadAppState();
}

class _NotepadAppState extends State<NotepadApp> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  List<Map<String, String>> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  _loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final notes = prefs.getStringList('notes');
    if (notes != null) {
      setState(() {
        _notes = notes.map((note) {
          final parts = note.split(',');
          return {
            'title': parts[0] ?? '',
            'content': parts[1] ?? '',
            'date': parts[2] ?? '',
          };
        }).toList();
      });
    }
  }

  _saveNote() async {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "O título e o conteúdo não podem estar vazios.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 18.0,
      );
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final title = _titleController.text;
    final content = _contentController.text;
    final date = _dateController.text ?? '';
    final newNote = '$title,$content,$date';
    setState(() {
      _notes.add({'title': title, 'content': content, 'date': date});
    });
    final noteStrings = _notes
        .map((note) => '${note['title']},${note['content']},${note['date']}')
        .toList();
    prefs.setStringList('notes', noteStrings);
    _titleController.clear();
    _contentController.clear();
    _dateController.clear();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  _showNotePopup({int index = -1}) {
    if (index != -1) {
      _titleController.text = _notes[index]['title'] ?? '';
      _contentController.text = _notes[index]['content'] ?? '';
      _dateController.text = _notes[index]['date'] ?? '';
    }

    showDialog(
      context: context,
      builder: (context) {
        AppTheme appTheme = Provider.of<AppTheme>(context);
        return AlertDialog(
          backgroundColor:
              appTheme.modoNoturno ? Color(0xff754343) : Color(0xffE89999),
          title: Text(index == -1 ? 'Nova Nota' : 'Editar Nota',
              style: TextStyle(
                color: appTheme.modoNoturno
                    ? Color(0xffffffff)
                    : Color(0xff000000),
                fontFamily: 'Pangolin',
              )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Título',
                  labelStyle: TextStyle(
                    color: appTheme.modoNoturno
                        ? Color(0xffffffff)
                        : Color(0xff000000),
                    fontFamily: 'Pangolin',
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: appTheme.modoNoturno
                          ? Color(0xffB94F4F)
                          : Color(0xffECD1D1),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: _contentController,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Conteúdo',
                  labelStyle: TextStyle(
                    color: appTheme.modoNoturno
                        ? Color(0xffffffff)
                        : Color(0xff000000),
                    fontFamily: 'Pangolin',
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: appTheme.modoNoturno
                          ? Color(0xffB94F4F)
                          : Color(0xffECD1D1),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Data',
                  labelStyle: TextStyle(
                    color: appTheme.modoNoturno
                        ? Color(0xffffffff)
                        : Color(0xff000000),
                    fontFamily: 'Pangolin',
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: appTheme.modoNoturno
                          ? Color(0xffB94F4F)
                          : Color(0xffECD1D1),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isEmpty ||
                    _contentController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('O título e o conteúdo não podem estar vazios.'),
                    ),
                  );
                } else {
                  if (index == -1) {
                    _saveNote();
                  } else {
                    _updateNote(index);
                  }
                  Navigator.of(context).pop();
                }
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  _updateNote(int index) {
    setState(() {
      _notes[index]['title'] = _titleController.text;
      _notes[index]['content'] = _contentController.text;
      _notes[index]['date'] = _dateController.text ?? '';
    });
    final noteStrings = _notes
        .map((note) => '${note['title']},${note['content']},${note['date']}')
        .toList();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setStringList('notes', noteStrings);
    });
  }

  _showNoteOptions(int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.edit,
              ),
              title: Text(
                'Editar',
              ),
              onTap: () {
                Navigator.of(context).pop();
                _showNotePopup(index: index);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.delete,
              ),
              title: Text(
                'Excluir',
              ),
              onTap: () {
                _deleteNote(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _deleteNote(int index) {
    setState(() {
      _notes.removeAt(index);
    });
    final noteStrings = _notes
        .map((note) => '${note['title']},${note['content']},${note['date']}')
        .toList();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setStringList('notes', noteStrings);
    });
  }

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = Provider.of<AppTheme>(context);
    return Scaffold(
      backgroundColor:
          appTheme.modoNoturno ? Color(0xff353333) : Color(0xffFFFFFF),
      appBar: AppBar(
        title: Text('Bloco de notas'),
        backgroundColor:
            appTheme.modoNoturno ? Color(0xffB94F4F) : Color(0xffF8CCCC),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
          ),
          itemCount: _notes.length,
          itemBuilder: (context, index) {
            return Card(
              color:
                  appTheme.modoNoturno ? Color(0xffB94F4F) : Color(0xffF8CCCC),
              child: ListTile(
                title: Text(
                  _notes[index]['title'] ?? '',
                  style: TextStyle(
                    color: appTheme.modoNoturno
                        ? Color(0xffffffff)
                        : Color(0xff000000),
                    fontFamily: 'Pangolin',
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _notes[index]['content'] ?? '',
                      style: TextStyle(
                        color: appTheme.modoNoturno
                            ? Color(0xffffffff)
                            : Color(0xff000000),
                        fontFamily: 'Pangolin',
                      ),
                    ),
                    Text(
                      _notes[index]['date'] ?? '',
                      style: TextStyle(
                        color: appTheme.modoNoturno
                            ? Color(0xffffffff)
                            : Color(0xff000000),
                        fontFamily: 'Pangolin',
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: appTheme.modoNoturno
                        ? Color(0xffffffff)
                        : Color(0xff000000),
                  ),
                  onPressed: () {
                    _showNoteOptions(index);
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNotePopup();
        },
        backgroundColor:
            appTheme.modoNoturno ? Color(0xff754343) : Color(0xffF06292),
        child: Icon(Icons.add),
      ),
    );
  }
}
