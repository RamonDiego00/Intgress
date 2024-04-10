import 'package:audioplayers/audioplayers.dart';
import 'package:intgress/core/repository/LessonRepository.dart';
import 'package:intgress/viewmodel/LessonViewModel.dart';
import 'package:record/record.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../core/repository/NoteRepository.dart';
import '../models/Note.dart';
import '../navigation/BottomBarActions.dart';
import '../services/authenticationService.dart';
import '../viewmodel/NoteViewModel.dart';

class FillNotePage extends StatefulWidget {
  const FillNotePage({super.key});

  @override
  _FillNotePageState createState() => _FillNotePageState();
}

class _FillNotePageState extends State<FillNotePage> {
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  String dropdownValue = 'Categoria';
  List<DropdownMenuItem> items = [
    DropdownMenuItem(value: "Categoria", child: Text("Categoria 1")),
    DropdownMenuItem(value: "Categoria 2", child: Text("Categoria 2")),
  ];
  String newText = '';

  late AudioRecorder audioRecord;
  late AudioPlayer audioPlayer;

  late NoteRepository noteRepository;
  late NoteViewModel noteViewModel;
  late LessonRepository lessonRepository;
  late LessonViewModel lessonViewModel;
  late AuthenticationService authenticationService;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  Note? _currentNote;

  final FocusNode _focusNodeTitle = FocusNode();
  final FocusNode _focusNodeMessage = FocusNode();

  @override
  void initState() {
    super.initState();

    // setando as variaveis
    noteRepository = NoteRepository();
    lessonRepository = LessonRepository();
    noteViewModel = NoteViewModel(noteRepository);

    lessonViewModel = LessonViewModel(lessonRepository);
    authenticationService = AuthenticationService();

    // Adiciona os ouvintes para atualizar a nota sempre que os campos de texto forem alterados
    _titleController.addListener(_updateNote);
    _messageController.addListener(_updateNote);
    _categoryController.addListener(_updateNote);

    //Adicionando valores a variavel

    audioPlayer = AudioPlayer();
    audioRecord = AudioRecorder();
  }

  @override
  void dispose() {
    // Limpa os controladores de texto ao descartar a tela
    _titleController.dispose();
    _messageController.dispose();
    _categoryController.dispose();

    audioRecord.dispose();
    audioPlayer.dispose();

    super.dispose();
  }

  void _updateNote() {
    // dar acesso ao logibn do usuário nessa tela
    // Atualiza a nota com os dados dos campos de texto
    // remover id auto gerado das notas e dos demais objetos
    final uuid = Uuid();
    String id = uuid.v4();
    setState(() {
      _currentNote = Note(
          id: id,
          user_id: authenticationService.getCurrentUuser_id(),
          title: _titleController.text,
          message: _messageController.text,
          category: "Bioquímica");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Anotação'),
        actions: [
          Positioned(
            right: -2,
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_drop_down),
              elevation: 16,
              style: TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: [
                DropdownMenuItem(
                    value: "Categoria", child: Text("Categoria 1")),
                DropdownMenuItem(
                    value: "Categoria 2", child: Text("Categoria 2")),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SingleChildScrollView(
          reverse: true,
          child: BottomBarNote(
            lessonViewModel: lessonViewModel,
            viewModel: noteViewModel,
            note: _currentNote,
          )),
      body: Stack(
        children: [
          SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              reverse: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                      focusNode: _focusNodeTitle,
                      style: Theme.of(context).textTheme.titleLarge,
                      controller: _titleController,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "Título"),
                      maxLines: 2,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_focusNodeMessage);
                      },
                      onTap: () {
                        setState(() {});
                      },
                      onEditingComplete: () {
                        setState(() {});
                      }),
                  TextField(
                    focusNode: _focusNodeMessage,
                    textInputAction: TextInputAction.next,
                    style: Theme.of(context).textTheme.bodyMedium,
                    controller: _messageController,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: "Mensagem"),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                  const SizedBox(height: 8.0),
// Aqui eu preciso criar uma lista de Cards de audio, que vai executar o meu audio gravado
                ],
              ))
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
