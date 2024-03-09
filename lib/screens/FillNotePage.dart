import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/database/Database.dart';
import '../core/repository/NoteRepository.dart';
import '../models/Note.dart';
import '../navigation/BottomBarActions.dart';
import '../viewmodel/NoteViewModel.dart';

class FillNotePage extends StatefulWidget {
  const FillNotePage({super.key});

  @override
  _FillNotePageState createState() => _FillNotePageState();
}

class _FillNotePageState extends State<FillNotePage> {
  late NoteRepository noteRepository;
  late NoteViewModel noteViewModel;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  Note? _currentNote;


  @override
  void initState() {
    super.initState();

    noteRepository = NoteRepository();

    noteViewModel = NoteViewModel(noteRepository);

    // Adiciona os ouvintes para atualizar a nota sempre que os campos de texto forem alterados
    _titleController.addListener(_updateNote);
    _messageController.addListener(_updateNote);
    _categoryController.addListener(_updateNote);
  }

  @override
  void dispose() {
    // Limpa os controladores de texto ao descartar a tela
    _titleController.dispose();
    _messageController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _updateNote() {
    // Atualiza a nota com os dados dos campos de texto
    setState(() {
      _currentNote = Note(
        title: _titleController.text,
        message: _messageController.text,
        category: _categoryController.text,
        lessons: []
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Anotação'),
      ),
      bottomNavigationBar: BottomBarNote(
        viewModel: noteViewModel, note: _currentNote,),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Insira um título para sua anotação',
                hintText: 'Insira um título para sua anotação',
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                labelText: 'Escreva sua anotação aqui',
                hintText: 'Escreva sua anotação aqui',
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                labelText: 'Qual a categoria da anotação?',
                hintText: '',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
