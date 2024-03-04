import "dart:io";

import "package:flutter/material.dart";
import "package:gen_ai_app/chat_comp.dart";
import "package:gen_ai_app/message_comp.dart";
import "package:gen_ai_app/submit_button.dart";
import "package:flutter_markdown/flutter_markdown.dart";
import "package:google_generative_ai/google_generative_ai.dart";
import "package:image_picker/image_picker.dart";

import "image_comp.dart";

const api_key = "";

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  late GenerativeModel generativeModel;
  late GenerativeModel generativeModel2;

  late ChatSession chatSession;
  TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;
  XFile? imageFile;

  final ImagePicker picker = ImagePicker();
  Future<void> _getImage(ImageSource source) async {
    XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
       imageFile = pickedFile;
      
    }
  }

  Future<void> _pickImage() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose an option"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text("Take a picture"),
                  onTap: () {
                    Navigator.of(context).pop();
                    _getImage(ImageSource.camera);
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text("Import from gallery"),
                  onTap: () {
                    Navigator.of(context).pop();
                    _getImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    generativeModel =
        GenerativeModel(model: "gemini-pro-vision", apiKey: api_key);
    chatSession = generativeModel.startChat();

    super.initState();
  }

  Future<void> sendMessage(String message) async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await chatSession.sendMessage(Content.text(message));
      final text = response.text;
      if (text == null) {
        Text("Nothing");
        return;
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      Text(e.toString());
    } finally {
      textEditingController.clear();
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "AI Copilot",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageFile != null)
         Image.file(File(imageFile!.path))
          ,
          Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: chatSession.history.length,
                  itemBuilder: (context, id) {
                    final content = chatSession.history.toList()[id];
                    final text = content.parts
                        .whereType<TextPart>()
                        .map((e) => e.text)
                        .join('');
                    return MessageComp(
                        text: text, isAi: content.role == 'user');
                  })),
          Row(
            children: [
           
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ChatComp(
                    text: "Enter the text",
                    icon: Icon(Icons.image),
                    textEditingController: textEditingController,
                    onPressed: () async {
                      _pickImage();
                    }),
              ),
              
               
              if (!isLoading)
                submitButton(
                  ontap: () async {
                    sendMessage(textEditingController.text);
                  },
                )
              else
                CircularProgressIndicator()
            ],
          ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
