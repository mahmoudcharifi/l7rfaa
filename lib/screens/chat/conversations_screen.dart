import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../services/message_service.dart';
import '../../services/user_service.dart';
import '../../models/user.dart';
import 'chat_screen.dart';

class ConversationsScreen extends StatefulWidget {

  const ConversationsScreen({super.key});

  @override
  State<ConversationsScreen> createState() =>
      _ConversationsScreenState();
}

class _ConversationsScreenState
    extends State<ConversationsScreen> {

  final MessageService messageService =
      MessageService();

  final UserService userService =
      UserService();

  final AuthService authService =
      AuthService();

  List<Map<String, dynamic>> conversations = [];

  bool isLoading = true;

  @override
  void initState() {

    super.initState();

    loadConversations();

  }

  Future<void> loadConversations() async {

    final id = await authService.getUserId();

    if (id == null) return;

    conversations =
        await messageService.getConversations(id);

    setState(() {

      isLoading = false;

    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text("Conversations"),

        centerTitle: true,

      ),

      body: isLoading

          ? const Center(
              child: CircularProgressIndicator(),
            )

          : conversations.isEmpty

              ? const Center(
                  child: Text(
                    "Aucune conversation",
                  ),
                )

              : ListView.builder(

                  itemCount: conversations.length,

                  itemBuilder: (context, index) {

                    final conversation =
                        conversations[index];

                                            return FutureBuilder<UserModel?>(

                      future: userService.getUserById(
                        conversation["id"] as int,
                      ),

                      builder: (context, snapshot) {

                        if (!snapshot.hasData) {
                          return const SizedBox();
                        }

                        final user = snapshot.data!;

                        return ListTile(

                          leading: CircleAvatar(

                            radius: 28,

                            backgroundColor:
                                const Color(0xff1565C0),

                            child: Text(

                              user.firstName
                                  .substring(0, 1)
                                  .toUpperCase(),

                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),

                            ),

                          ),

                          title: Text(

                            "${user.firstName} ${user.lastName}",

                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),

                          ),

                          subtitle: Text(

                            conversation["message"] ?? "",

                            maxLines: 1,

                            overflow:
                                TextOverflow.ellipsis,

                          ),

                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                          ),

                          onTap: () {

                            Navigator.push(

                              context,

                              MaterialPageRoute(

                                builder: (_) => ChatScreen(

                                  receiver: user,

                                ),

                              ),

                            ).then((_) {

                              loadConversations();

                            });

                          },

                        );

                      },

                    );

                  },

                ),

    );

  }

}