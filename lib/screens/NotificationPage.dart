import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});


// Vai ter uma lista de atividades
  // uma atividade é composta por categoria,titulo da nota referente a ela
  // logo após vai ter uma lista de tarefas
  // cada tarefa vai ter um enunciado, uma pergunta e 3 alternativas possiveis

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: const Center(
        child: Text(''),
      ),
    );
  }
}