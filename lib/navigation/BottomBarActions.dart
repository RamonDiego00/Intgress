import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intgress/core/repository/NoteRepository.dart';
import 'package:intgress/utils/AudioMethods.dart';
import 'package:intgress/viewmodel/NoteViewModel.dart';
import 'package:record/record.dart';

import '../models/Note.dart';

class BottomBarNote extends StatefulWidget {
  final NoteViewModel viewModel;
  final Note? note;

  BottomBarNote({
    required this.viewModel,
    required this.note,
  });

  @override
  _BottomBarNoteState createState() => _BottomBarNoteState();
}

class _BottomBarNoteState extends State<BottomBarNote> {
  late AudioRecorder audioRecord;
  late AudioPlayer audioPlayer;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    audioRecord = AudioRecorder();
    audioPlayer = AudioPlayer();
  }

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
          ...isRecording ? [
            IconButton(
              icon: Icon(Icons.stop_circle_outlined),
              onPressed: () {
                setState(() {
                  isRecording = false;
                });
                AudioMethods().stopRecording(true, audioRecord, audioPlayer);
              },
            )
          ] : [
            IconButton(
              icon: Icon(Icons.mic),
              onPressed: () {
                setState(() {
                  isRecording = true;
                });
                AudioMethods().startRecording(true, audioRecord, audioPlayer);
              },
            )
          ],
          IconButton(
            icon: Icon(Icons.check_circle_outline),
            onPressed: () {
              if (widget.note != null) {
                widget.viewModel.createNewNote(widget.note!, context);
              }
            },
          ),
        ],
      ),
    );
  }
}
