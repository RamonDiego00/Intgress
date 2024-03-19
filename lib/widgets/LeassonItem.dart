import 'package:flutter/material.dart';

import '../core/repository/LessonRepository.dart';
import '../core/repository/NoteRepository.dart';
import '../models/Lesson.dart';
import '../models/Note.dart';
import '../viewmodel/LessonViewModel.dart';
import '../viewmodel/NoteViewModel.dart';

class LessonItem extends StatefulWidget {
  final Lesson lesson;

  const LessonItem({required this.lesson});

  @override
  _LessonItem createState() => _LessonItem();
}

class _LessonItem extends State<LessonItem> {
  late LessonRepository lessonRepository;
  late LessonViewModel lessonViewModel;
  bool _checkBoxValue1 = false;
  bool _checkBoxValue2 = false;
  bool _checkBoxValue3 = false;

  @override
  void initState() {
    super.initState();

    lessonRepository = LessonRepository();
    lessonViewModel = LessonViewModel(lessonRepository);
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Ajusta a elevação do card
      margin: EdgeInsets.all(8), // Margem ao redor do card
      child: InkWell(
        onTap: () {
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
                        // baseado no Id da nota eu vou precisar capturar essas informações
                        Text(
                          widget.lesson.categoryNote,
                          style: const TextStyle(),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.lesson.titleNote,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.lesson.statement,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.lesson.statement,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      widget.lesson.question,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Checkbox(value: _checkBoxValue1,onChanged: (bool ? newValue){
                              setState(() {
                                _checkBoxValue1 = newValue!;
                              });
                            },),
                            SizedBox(height: 10),
                            Text(
                              widget.lesson.alternative1,
                              style: const TextStyle(fontSize: 16.0),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(value:_checkBoxValue2,onChanged: (bool ? newValue){
                              setState(() {
                                _checkBoxValue2 = newValue!;
                              });
                            },),
                            SizedBox(height: 10),
                            Text(
                              widget.lesson.alternative2,
                              style: const TextStyle(fontSize: 16.0),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(value:_checkBoxValue3,onChanged: (bool ? newValue){
                              setState(() {
                                _checkBoxValue3 = newValue!;
                              });
                            },),
                            SizedBox(height: 10),
                            Text(
                              widget.lesson.alternative3,
                              style: const TextStyle(fontSize: 16.0),
                            )
                          ],
                        ),
                      ],
                    )
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
