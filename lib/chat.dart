import 'package:flutter/material.dart';
import 'package:law_app/lawyers.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.professional}) : super(key: key);

  final Professional professional;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _messages = [];

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _messages.insert(0, text);
    });
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.blue,
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration(
                  hintText: 'Send a message',
                  hintStyle: TextStyle(
                    color: Colors.blue,
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(16, 16, 32, 16),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.insert_emoticon),
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return EmojiPicker(
                    onEmojiSelected: (category, emoji) {
                      setState(() {
                        _textController.text += emoji.emoji;
                      });
                    },
                  );
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return Expanded( // Replace Flexible with Expanded
      child: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        reverse: true,
        itemCount: _messages.length,
        itemBuilder: (_, int index) => _buildMessageItem(index),
      ),
    );
  }

  Widget _buildMessageItem(int index) {
    return ListTile(
      title: Text(_messages[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.professional.name}'),
        backgroundColor: Colors.blue,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          )
        ),
      ),
      body: Column(
        children: <Widget>[
          _buildMessageList(), // No need for Flexible here
          const Divider(height: 1.0), 
          _buildTextComposer(),
        ],
      ),
    );
  }
}
