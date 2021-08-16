import 'package:flutter/material.dart';

import 'package:movieapp/movielist.dart';

class FormPage extends StatefulWidget {
  final MovieList? movie;
  final Function(String name, String director, String url) onClickedDone;

  const FormPage({
    Key? key,
    this.movie,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final directorController = TextEditingController();
  final urlController = TextEditingController();


  @override
  void initState() {
    super.initState();

    if (widget.movie != null) {
      final transaction = widget.movie!;

      nameController.text = transaction.name;
      directorController.text = transaction.director;
      urlController.text= transaction.url;
    }
  }
  @override
  void dispose() {
    nameController.dispose();
    directorController.dispose();
    urlController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final isEditing = widget.movie != null;
    final title = isEditing ? 'Edit Details' : 'Add Movie';
    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 8),
              buildName(),
              SizedBox(height: 8),
              buildDirector(),
              SizedBox(height: 8),
              buildUrl(),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, isEditing: isEditing),
      ],
    );
  }
  Widget buildName() => TextFormField(
        controller: nameController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Name',
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'Enter a name' : null,
      );

  Widget buildDirector() => TextFormField(
        controller: directorController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Director',
        ),
        validator: (director) =>
            director != null && director.isEmpty ? 'Enter Director Name' : null,
      );

  Widget buildUrl() => TextFormField(
        controller: urlController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter url',
        ),
        validator: (url) =>
            url != null && url.isEmpty ? 'Enter valid url' : null,
      );

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final name = nameController.text;
          final director = directorController.text;
          final url = urlController.text;

          widget.onClickedDone(name, director, url);

          Navigator.of(context).pop();
        }
      },
    );
  }
}