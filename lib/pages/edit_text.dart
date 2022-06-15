import 'package:flutter/material.dart';
import 'package:prompter_app_panel/components/app_colors.dart';
import 'package:prompter_app_panel/components/loading_indicator.dart';
import 'package:prompter_app_panel/services/firebase_services.dart';

class EditTextUI extends StatefulWidget {
  EditTextUI(this.texts, {Key? key}) : super(key: key);
  List<dynamic> texts;
  @override
  State<EditTextUI> createState() => _EditTextUIState();
}

class _EditTextUIState extends State<EditTextUI> {
  late TextEditingController _title;
  late TextEditingController _content;
  bool _isLoading = false;

  @override
  void initState() {
    _title = TextEditingController();
    _content = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _title.dispose();
    _content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_title.text.isNotEmpty && _content.text.isNotEmpty) {
            _isLoading = true;
            widget.texts.add({
              "title": _title.text,
              "text": _content.text,
              "is_file": false,
            });
            FirebaseService.updateTexts(widget.texts).whenComplete(
              () {
                setState(() {
                  _isLoading = false;
                  Navigator.pop(context);
                });
              },
            );
          }
        },
        icon: Icon(Icons.save),
        label: Text("Kaydet"),
        backgroundColor: AppColors.primaryColor,
      ),
      appBar: AppBar(
        title: Text("Metin Ekle"),
      ),
      body: _isLoading
          ? loadingIndicator()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: _title,
                    decoration: InputDecoration(
                      hintText: "Başlık",
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: TextField(
                      controller: _content,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.multiline,
                      minLines: 5,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "İçerik",
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
