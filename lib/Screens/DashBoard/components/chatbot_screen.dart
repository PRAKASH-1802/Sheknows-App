import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sheknows_app/Screens/DashBoard/components/ComponentHealth/gemini_service.dart';
import 'package:sheknows_app/Screens/DashBoard/home.dart';

class AskQuestionScreen extends StatefulWidget {
  @override
  _AskQuestionScreenState createState() => _AskQuestionScreenState();
}

class _AskQuestionScreenState extends State<AskQuestionScreen> {
  final TextEditingController _questionController = TextEditingController();
  final List<Map<String, dynamic>> _messages = []; // Store conversation history
  bool _isLoading = false;
  File? _selectedImage;
  final GeminiService _geminiService = GeminiService();
  final ImagePicker _picker = ImagePicker();
  final ScrollController _scrollController = ScrollController();

  // Image pick karne ka function
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
      // Add the image to the conversation
      _messages.add({
        'type': 'image',
        'content': _selectedImage,
        'isUser': true,
      });
      _scrollToBottom();
    }
  }

  void _fetchAnswer() async {
    String question = _questionController.text.trim();
    if (question.isEmpty && _selectedImage == null) {
      setState(() {
        _messages.add({
          'type': 'text',
          'content': "Please enter a question or upload an image.",
          'isUser': false,
        });
      });
      _scrollToBottom();
      return;
    }

    // Add the user's question to the conversation
    if (question.isNotEmpty) {
      setState(() {
        _messages.add({
          'type': 'text',
          'content': question,
          'isUser': true,
        });
      });
      _scrollToBottom();
    }

    setState(() {
      _isLoading = true;
    });

    String answer;
    if (_selectedImage != null) {
      // Image ke saath sawaal
      final imageBytes = await _selectedImage!.readAsBytes();
      String mimeType =
          _selectedImage!.path.endsWith('.png') ? 'image/png' : 'image/jpeg';
      answer = await _geminiService.getImageAnswer(
          question.isEmpty ? "Analyze this image" : question,
          mimeType,
          imageBytes);
    } else {
      // Sirf text sawaal
      answer = await _geminiService.getTextAnswer(question);
    }

    setState(() {
      _messages.add({
        'type': 'text',
        'content': answer,
        'isUser': false,
      });
      _isLoading = false;
      _selectedImage = null; // Clear the image after sending
      _questionController.clear(); // Clear the text field
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigate to DashBoard when the back button is pressed
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => Home(
                    email: '',
                  )),
        );
        return false; // Prevent default back button behavior
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("ChatBot"),
          backgroundColor: Colors.purpleAccent.shade100,
        ),
        body: Column(
          children: [
            // Chat messages
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isUser = message['isUser'] as bool;
                  if (message['type'] == 'text') {
                    return Align(
                      alignment:
                          isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: isUser ? Colors.blueAccent : Colors.grey[300],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          message['content'] as String,
                          style: TextStyle(
                            color: isUser ? Colors.white : Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  } else if (message['type'] == 'image') {
                    return Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Image.file(
                          message['content'] as File,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
            // Input area
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.image, color: Colors.blueAccent),
                    onPressed: _pickImage,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _questionController,
                      decoration: InputDecoration(
                        hintText: "Type your question...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      onSubmitted: (value) {
                        if (!_isLoading) _fetchAnswer();
                      },
                    ),
                  ),
                  _isLoading
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CircularProgressIndicator(),
                        )
                      : IconButton(
                          icon: Icon(Icons.send, color: Colors.purpleAccent),
                          onPressed: _fetchAnswer,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
