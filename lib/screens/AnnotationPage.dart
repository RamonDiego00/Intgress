import 'package:flutter/material.dart';
import 'package:intgress/screens/FillNotePage.dart';
import 'package:intgress/viewmodel/NoteViewModel.dart';
import 'package:intgress/widgets/NoteItem.dart';


import '../core/repository/NoteRepository.dart';
import '../models/Note.dart';
import 'NotificationPage.dart'; // Importe o seu widget NoteItem aqui

class AnnotationPage extends StatefulWidget {
  const AnnotationPage({Key? key});

  @override
  _AnnotationPageState createState() => _AnnotationPageState();
}

class _AnnotationPageState extends State<AnnotationPage> {
  late NoteRepository noteRepository;
  late NoteViewModel noteViewModel;


  @override
  void initState() {
    super.initState();

    noteRepository = NoteRepository();
    noteViewModel = NoteViewModel(noteRepository);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NotificationPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Pesquise sua lista',
                  prefixIcon: Icon(Icons.dehaze_rounded),
                  suffixIcon: Icon(Icons.circle),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 12.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  hintStyle: const TextStyle(color: Colors.white54),
                  fillColor: const Color.fromRGBO(57, 57, 57, 1),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Note>>(
                future: noteViewModel.getAllNotes(), // Recupera todas as notas
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erro ao carregar notas');
                  } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                    return Text('Nenhuma nota encontrada');
                  } else {
                    // Mapeie cada nota para um widget NoteItem
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final note = snapshot.data![index];
                        return NoteItem(
                          note: note
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(57, 57, 57, 1),
        foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
        shape: const CircleBorder(),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return BottomSheet(
                builder: (context) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(Icons.checklist),
                                Text('Criar nova lista'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print('Clicou na Row!');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => FillNotePage(),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.short_text_rounded),
                                  Text('Criar nova anotação'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                    ],
                  );
                },
                onClosing: () {},
              );
            },
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
