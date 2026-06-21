import 'dart:io';

import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../services/auth_service.dart';
import '../../services/user_service.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final AuthService authService = AuthService();
  final UserService userService = UserService();

  UserModel? user;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {

    final id = await authService.getUserId();

    if (id == null) return;

    user = await userService.getUserById(id);

    setState(() {
      isLoading = false;
    });

  }

  Future<void> logout() async {

    await authService.logout();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(

      context,

      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),

      (route) => false,

    );

  }

  @override
  Widget build(BuildContext context) {

    if (isLoading) {

      return const Scaffold(

        body: Center(
          child: CircularProgressIndicator(),
        ),

      );

    }

    return Scaffold(

      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(

        title: const Text("Mon Profil"),

        centerTitle: true,

      ),

      body: SingleChildScrollView(

        child: Column(

          children: [

            const SizedBox(height: 25),

            CircleAvatar(

              radius: 55,

              backgroundColor: const Color(0xff1565C0),

              backgroundImage:

                  user!.image != null &&
                          user!.image!.isNotEmpty

                      ? FileImage(
                          File(user!.image!),
                        )

                      : null,

              child:

                  user!.image == null ||
                          user!.image!.isEmpty

                      ? const Icon(

                          Icons.person,

                          color: Colors.white,

                          size: 55,

                        )

                      : null,

            ),

            const SizedBox(height: 15),

            Text(

              "${user!.firstName} ${user!.lastName}",

              style: const TextStyle(

                fontSize: 24,

                fontWeight: FontWeight.bold,

              ),

            ),

            const SizedBox(height: 5),

            Text(

              user!.email,

              style: const TextStyle(

                color: Colors.grey,

                fontSize: 16,

              ),

            ),

            const SizedBox(height: 30),

                        Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [

                    ListTile(
                      leading: const Icon(
                        Icons.phone,
                        color: Colors.green,
                      ),
                      title: const Text("Téléphone"),
                      subtitle: Text(user!.phone),
                    ),

                    const Divider(height: 1),

                    ListTile(
                      leading: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      title: const Text("Ville"),
                      subtitle: Text(
                        user!.city?.isNotEmpty == true
                            ? user!.city!
                            : "Non renseignée",
                      ),
                    ),

                    const Divider(height: 1),

                    ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: Color(0xff1565C0),
                      ),
                      title: const Text("Type de compte"),
                      subtitle: Text(
                        user!.role == "artisan"
                            ? "Artisan"
                            : "Client",
                      ),
                    ),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [

                    ListTile(
                      leading: const Icon(
                        Icons.edit,
                        color: Colors.orange,
                      ),
                      title: const Text("Modifier le profil"),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                      onTap: () {

                        // EditProfileScreen

                      },
                    ),

                    const Divider(height: 1),

                    ListTile(
                      leading: const Icon(
                        Icons.info_outline,
                        color: Colors.blue,
                      ),
                      title: const Text("À propos de L7RFA"),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                      onTap: () {

                        showAboutDialog(

                          context: context,

                          applicationName: "L7RFA",

                          applicationVersion: "1.0.0",

                          applicationLegalese:
                              "Développé avec Flutter & SQLite",

                        );

                      },
                    ),

                    const Divider(height: 1),

                    ListTile(
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      title: const Text(
                        "Déconnexion",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      onTap: () async {

                        final confirm =
                            await showDialog<bool>(

                          context: context,

                          builder: (_) => AlertDialog(

                            title: const Text(
                              "Déconnexion",
                            ),

                            content: const Text(
                              "Voulez-vous vraiment vous déconnecter ?",
                            ),

                            actions: [

                              TextButton(

                                onPressed: () {

                                  Navigator.pop(
                                    context,
                                    false,
                                  );

                                },

                                child: const Text("Annuler"),

                              ),

                              ElevatedButton(

                                onPressed: () {

                                  Navigator.pop(
                                    context,
                                    true,
                                  );

                                },

                                child: const Text("Oui"),

                              ),

                            ],

                          ),

                        );

                        if (confirm == true) {

                          await logout();

                        }

                      },
                    ),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

          ],

        ),

      ),

    );

  }

}