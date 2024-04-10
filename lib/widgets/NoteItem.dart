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
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    noteRepository = NoteRepository();
    noteViewModel = NoteViewModel(noteRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromRGBO(57, 57, 57, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Colors.white54, // Altere a cor aqui
          width: 2,
        ),
      ),
      elevation: 4,
      // Ajusta a elevação do card
      margin: EdgeInsets.all(8),
      // Margem ao redor do card
      child: InkWell(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.note.title,
                      style: Theme.of(context).textTheme.titleLarge
                    ),
                  ),
                  if (_isExpanded)
                    GestureDetector(
                      onTap: () {
                        noteRepository.deleteNote(widget.note);
                      },
                      child: Icon(
                        Icons.delete,
                        size: 20,
                      ),
                    ),
                  SizedBox(width: 10),
                ],
              ),
              if (_isExpanded)
                Wrap(
                  children: [
                    Text(
                      widget.note.message,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
