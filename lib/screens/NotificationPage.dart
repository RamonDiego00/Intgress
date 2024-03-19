import 'package:flutter/material.dart';
import 'package:intgress/models/Lesson.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

// Vai ter uma lista de atividades
  // uma atividade é composta por categoria,titulo da nota referente a ela
  // logo após vai ter uma lista de tarefas
  // cada tarefa vai ter um enunciado, uma pergunta e 3 alternativas possiveis

  // mudar para Stateful



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atividades'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder<List<Lesson>>(
                future: lessonViewModel.getAllLessons(), // Recupera todas as lições
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
                        return LessonItem(
                            lesson: lesson
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
