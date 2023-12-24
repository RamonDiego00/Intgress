import 'package:flutter/material.dart';

class ListItemTask extends StatefulWidget {
  @override
  _ListItemTaskState createState() => _ListItemTaskState();
}

class _ListItemTaskState extends State<ListItemTask> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _expanded = !_expanded;
          });
        },
        child: Container(
          color: Colors.transparent, // Torna o Container transparente para permitir a detecção do toque.
          child: _expanded
              ? _buildExpandedContent()
              : _buildCollapsedContent(),
        ),
      ),
    );
  }

  Widget _buildCollapsedContent() {
    return Row(
      children: [
        Icon(Icons.arrow_forward),
        Text("Titulo"),
        Text("90%"),
        Icon(Icons.expand_more),
      ],
    );
  }

  Widget _buildExpandedContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.arrow_drop_down),
            Text("Titulo"),
            Text("90%"),
            Icon(Icons.expand_less),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCheckBoxColumn("Coluna 1", ["Opção 1", "Opção 2"]),
            _buildCheckBoxColumn("Coluna 2", ["Opção 3", "Opção 4"]),
          ],
        ),
      ],
    );
  }

  Widget _buildCheckBoxColumn(String title, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        for (var option in options)
          CheckboxListTile(
            title: Text(option),
            value: false,
            onChanged: (value) {
              // Lógica quando a opção é marcada ou desmarcada.
            },
          ),
      ],
    );
  }
}
