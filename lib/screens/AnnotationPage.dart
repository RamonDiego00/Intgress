import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intgress/widgets/ListItemTask.dart';

class AnnotationPage extends StatelessWidget {
  const AnnotationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Align(
            alignment: Alignment.topCenter,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Pesquise sua lista',
                prefixIcon: Icon(Icons.dehaze_rounded),
                // Ícone no início
                suffixIcon: Icon(Icons.circle),
                // Ícone no final
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
          ),
         ListView(
             shrinkWrap: true,
              children: [
                ListItemTask(),
               ListItemTask(),
                // Adicione mais ListTiles conforme necessário.
              ],
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(57, 57, 57, 1),
          foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
          shape: const CircleBorder(),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return BottomSheet(
                  builder: (context) {
                    return const Column(
                      children: [
                        Icon(Icons.checklist),
                        Text('Criar nova lista'),
                        Divider(),
                        Icon(Icons.short_text_rounded),
                        Text('Criar nova anotação'),
                      ],
                    );
                  },
                  onClosing: () {},
                );
              },
            );
          },
          child: const Icon(Icons.edit)),
    );
  }
}
