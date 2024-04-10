import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intgress/models/Lesson.dart';

class DetailsLessonPage extends StatefulWidget {
  final Lesson lesson;

  const DetailsLessonPage({required this.lesson});

  _DetailsLessonPageState createState() => _DetailsLessonPageState();
}

enum SingingCharacter { alternative1, alternative2, alternative3 }

class _DetailsLessonPageState extends State<DetailsLessonPage> {
  SingingCharacter? _character = SingingCharacter.alternative1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 320,
              child: Text(
                widget.lesson.category_note,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          Container(
            child: Text(widget.lesson.statement, style: Theme.of(context).textTheme.bodyMedium),
          ),
          Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      child: Column(
                        children:[Column(
                    children: <Widget>[
                      RadioListTile(
                          title: Text(widget.lesson.alternative1, style: Theme.of(context).textTheme.bodyMedium,),
                          value: SingingCharacter.alternative1,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                          }),
                      RadioListTile(
                          title: Text(widget.lesson.alternative2, style: Theme.of(context).textTheme.bodyMedium,),
                          value: SingingCharacter.alternative2,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                          }),
                      RadioListTile(
                          title: Text(widget.lesson.alternative3, style: Theme.of(context).textTheme.bodyMedium,),
                          value: SingingCharacter.alternative3,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                          }),
                    ],),
                          ElevatedButton(
                            onPressed: () {


                            },
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                              minimumSize: MaterialStateProperty.all(Size(
                                  MediaQuery.of(context).size.width *
                                      0.8, // 40% da largura da tela
                                  40.0)),
                              textStyle: MaterialStateProperty.all(
                                  TextStyle(fontSize: 16.0)),
                              // Cor de fundo personalizada
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  // Borda arredondada
                                  side: BorderSide(
                                      color: Colors.blue), // Cor da borda
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                // Icon(Icons.login),
                                // Ícone ao lado do texto
                                SizedBox(width: 8.0),
                                // Espaçamento entre o ícone e o texto
                                Text(
                                  'Confirmar',
                                ),
                              ],
                            ),
                          ),
                        ]
                  )))
            ],
          )
        ],
      )),
    );
  }
}
