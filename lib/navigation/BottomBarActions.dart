import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intgress/core/repository/NoteRepository.dart';
import 'package:intgress/viewmodel/NoteViewModel.dart';

import '../models/Note.dart';

class BottomBarNote extends StatelessWidget {
  final NoteViewModel viewModel;
  final Note? note;

  BottomBarNote({required this.viewModel, required this.note});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.sort_by_alpha),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.mic),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.check_circle_outline),
            onPressed: () {
              if (note != null) {
                viewModel.createNewNote(note!,context);
              }
            },
          ),
        ],
      ),
    );
  }
}
