import 'package:flutter/material.dart';

import '../core/repository/NoteRepository.dart';
import '../models/Note.dart';
import '../viewmodel/NoteViewModel.dart';

class NoteItem extends StatefulWidget {
  final Note note;

  const NoteItem({required this.note});

  @override
  _NoteItemState createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  late NoteRepository noteRepository;
  late NoteViewModel noteViewModel;


  @override
  void initState() {
    super.initState();

    noteRepository = NoteRepository();
    noteViewModel = NoteViewModel(noteRepository);

  }

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Ajusta a elevação do card
      margin: EdgeInsets.all(8), // Margem ao redor do card
      child: InkWell(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.note.title,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '90%',
                          style: TextStyle(color: Colors.green),
                        ),
                        SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                           noteRepository.deleteNote(widget.note);
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    if (_isExpanded)
                      Text(
                        widget.note.message,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    Row(children: [
                      GestureDetector(
                        onTap: () {

                        },
                        child: Icon(Icons.share)
                        ,
                      )
                    ,
                      GestureDetector(
                        onTap: () {

                        },
                        child: Icon(Icons.send),
                      ),
                    ])
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
