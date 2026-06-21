import 'package:flutter/material.dart';

import '../../models/message_model.dart';
import '../../models/user.dart';
import '../../services/auth_service.dart';
import '../../services/message_service.dart';

class ChatScreen extends StatefulWidget {

  final UserModel receiver;

  const ChatScreen({
    super.key,
    required this.receiver,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final MessageService messageService = MessageService();

  final AuthService authService = AuthService();

  final TextEditingController messageController =
      TextEditingController();

  List<MessageModel> messages = [];

  int? myId;

  bool isLoading = true;

  @override
  void initState() {

    super.initState();

    loadConversation();

  }

  Future<void> loadConversation() async {

    myId = await authService.getUserId();

    if (myId == null) return;

    messages = await messageService.getConversation(
      myId!,
      widget.receiver.id!,
    );

    setState(() {

      isLoading = false;

    });

  }

  Future<void> sendMessage() async {

    if (messageController.text.trim().isEmpty) return;

    await messageService.sendMessage(

      MessageModel(

        senderId: myId!,

        receiverId: widget.receiver.id!,

        message: messageController.text,

        date: DateTime.now().toString(),

      ),

    );

    messageController.clear();

    loadConversation();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Row(

          children: [

            const CircleAvatar(

              child: Icon(Icons.person),

            ),

            const SizedBox(width: 12),

            Text(

              "${widget.receiver.firstName} ${widget.receiver.lastName}",

            ),

          ],

        ),

      ),

      body: Column(

        children: [

          Expanded(

            child: isLoading

                ? const Center(
                    child: CircularProgressIndicator(),
                  )

                : ListView.builder(

                    padding: const EdgeInsets.all(15),

                    itemCount: messages.length,

                    itemBuilder: (context, index) {

                      final message = messages[index];

                      bool me =
                          message.senderId == myId;

                      return Align(

                        alignment: me
                            ? Alignment.centerRight
                            : Alignment.centerLeft,

                        child: Container(

                          margin: const EdgeInsets.only(
                            bottom: 10,
                          ),

                          padding:
                              const EdgeInsets.all(14),

                          decoration: BoxDecoration(

                            color: me
                                ? const Color(0xff1565C0)
                                : Colors.grey.shade300,

                            borderRadius:
                                BorderRadius.circular(18),

                          ),

                          child: Text(

                            message.message,

                            style: TextStyle(

                              color: me
                                  ? Colors.white
                                  : Colors.black,

                            ),

                          ),

                        ),

                      );

                    },

                  ),

          ),

                    Container(

            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),

            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.2),
                  blurRadius: 8,
                ),
              ],
            ),

            child: SafeArea(

              child: Row(

                children: [

                  Expanded(

                    child: TextField(

                      controller: messageController,

                      decoration: InputDecoration(

                        hintText: "Écrire un message...",

                        filled: true,

                        fillColor: Colors.grey.shade100,

                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),

                        border: OutlineInputBorder(

                          borderRadius:
                              BorderRadius.circular(30),

                          borderSide: BorderSide.none,

                        ),

                      ),

                    ),

                  ),

                  const SizedBox(width: 10),

                  FloatingActionButton(

                    heroTag: "sendMessage",

                    mini: true,

                    backgroundColor:
                        const Color(0xff1565C0),

                    onPressed: sendMessage,

                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),

                  ),

                ],

              ),

            ),

          ),

        ],

      ),

    );

  }

  @override
  void dispose() {

    messageController.dispose();

    super.dispose();

  }

}