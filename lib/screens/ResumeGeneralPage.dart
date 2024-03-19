import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/repository/NoteRepository.dart';
import '../models/Note.dart';
import '../viewmodel/NoteViewModel.dart';
import '../widgets/NoteItem.dart';
import 'NotificationPage.dart';

class ResumeGeneralPage extends StatefulWidget {
  const ResumeGeneralPage({super.key});

  @override
  _ResumeGeneralPageState createState() => _ResumeGeneralPageState();
}

class _ResumeGeneralPageState extends State<ResumeGeneralPage> {
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
                  builder: (context) => NotificationPage(),
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
                child: Container(
                  width: 320,child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Pesquise seu resumo',
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
                )
            ),
            Expanded(
              child: FutureBuilder<List<Note>>(
                future: noteViewModel.geminiAllNotes(), // Recupera todas as notas
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Column(children: [SizedBox(height: 30.0,),Text('Erro ao carregar as notas')],);
                  } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                    return Column(children: [SizedBox(height: 30.0,),Text('Nenhuma nota encontrada')],);
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
    );
  }
}
