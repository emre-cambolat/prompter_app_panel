import 'package:flutter/material.dart';
import 'package:prompter_app_panel/components/app_colors.dart';
import 'package:prompter_app_panel/components/loading_indicator.dart';
import 'package:prompter_app_panel/pages/edit_text.dart';
import 'package:prompter_app_panel/services/firebase_services.dart';

class HomePageUI extends StatefulWidget {
  const HomePageUI({Key? key}) : super(key: key);

  @override
  State<HomePageUI> createState() => _HomePageUIState();
}

class _HomePageUIState extends State<HomePageUI> {
  bool _isLoading = true;
  List<dynamic> _texts = [];

  @override
  void initState() {
    FirebaseService.getData().then(
      (value) {
        _texts = value["texts"];
        // debugPrint("xxxxx"+value["texts"][0].toString());
        setState(() {
          _isLoading = false;
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Metinleri yönet"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _goEditText(EditTextUI(_texts));
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: _isLoading
          ? loadingIndicator()
          : ListView.builder(
              itemCount: _texts.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(_texts[index]["title"]),
                            subtitle: Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                _texts[index]["text"],
                                maxLines: 2,
                              ),
                            ),
                            trailing: Icon(Icons.edit),
                            onTap: () {
                              // _goEditText(EditTextUI(_texts));
                            },
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                      "\'${_texts[index]["title"]}\' Metnini silmek istediğinizden emin misiniz?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _texts.removeAt(index);
                                        });
                                        Navigator.pop(context);
                                        _isLoading = true;
                                        FirebaseService.updateTexts(_texts)
                                            .whenComplete(
                                          () {
                                            setState(() {
                                              _isLoading = false;
                                            });
                                          },
                                        );
                                      },
                                      child: Text("Sil"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "İptal",
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            width: 48,
                            height: 64,
                            color: Colors.red,
                            child: Icon(
                              Icons.delete,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 5,
                    ),
                  ],
                );
              },
            ),
    );
  }

  void _goEditText(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    ).whenComplete(() {
      debugPrint("geri geldi moruqqqq");
      setState(() {});
    });
  }
}
