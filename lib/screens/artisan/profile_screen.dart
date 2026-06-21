import 'dart:io';

import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../services/auth_service.dart';
import '../../services/user_service.dart';
import '../auth/login_screen.dart';
import 'edit_artisan_profile_screen.dart';

class ArtisanProfileScreen extends StatefulWidget {
  const ArtisanProfileScreen({super.key});

  @override
  State<ArtisanProfileScreen> createState() =>
      _ArtisanProfileScreenState();
}

class _ArtisanProfileScreenState
    extends State<ArtisanProfileScreen> {

  final AuthService authService = AuthService();
  final UserService userService = UserService();

  UserModel? artisan;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadArtisan();
  }

  Future<void> loadArtisan() async {

    final id = await authService.getUserId();

    if (id == null) return;

    artisan = await userService.getUserById(id);

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

    if (artisan == null) {

      return const Scaffold(

        body: Center(
          child: Text("Utilisateur introuvable"),
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

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

 CircleAvatar(
  radius: 55,
  backgroundColor: const Color(0xff1565C0),

  backgroundImage: (artisan?.image?.isNotEmpty ?? false)
      ? FileImage(File(artisan!.image!))
      : null,

  child: !(artisan?.image?.isNotEmpty ?? false)
      ? const Icon(
          Icons.person,
          color: Colors.white,
          size: 55,
        )
      : null,
),

            const SizedBox(height: 18),

            Text(

              "${artisan!.firstName} ${artisan!.lastName}",

              style: const TextStyle(

                fontSize: 25,

                fontWeight: FontWeight.bold,

              ),

            ),

            const SizedBox(height: 8),

            Text(

              artisan!.job ?? "",

              style: const TextStyle(

                color: Colors.grey,

                fontSize: 18,

              ),

            ),

            const SizedBox(height: 25),
            Card(

  elevation: 2,

  shape: RoundedRectangleBorder(

    borderRadius: BorderRadius.circular(18),

  ),

  child: Column(

    children: [

      ListTile(

        leading: const CircleAvatar(

          backgroundColor: Color(0xffE3F2FD),

          child: Icon(
            Icons.phone,
            color: Color(0xff1565C0),
          ),

        ),

        title: const Text("Téléphone"),

        subtitle: Text(artisan!.phone),

      ),

      const Divider(height: 1),

      ListTile(

        leading: const CircleAvatar(

          backgroundColor: Color(0xffE3F2FD),

          child: Icon(
            Icons.email,
            color: Color(0xff1565C0),
          ),

        ),

        title: const Text("Email"),

        subtitle: Text(artisan!.email),

      ),

      const Divider(height: 1),

      ListTile(

        leading: const CircleAvatar(

          backgroundColor: Color(0xffE3F2FD),

          child: Icon(
            Icons.location_on,
            color: Color(0xff1565C0),
          ),

        ),

        title: const Text("Ville"),

        subtitle: Text(

          artisan!.city?.isNotEmpty == true

              ? artisan!.city!

              : "Non renseignée",

        ),

      ),

      const Divider(height: 1),

      ListTile(

        leading: const CircleAvatar(

          backgroundColor: Color(0xffE3F2FD),

          child: Icon(
            Icons.work,
            color: Color(0xff1565C0),
          ),

        ),

        title: const Text("Expérience"),

        subtitle: Text(

          artisan!.experience?.isNotEmpty == true

              ? artisan!.experience!

              : "Non renseignée",

        ),

      ),

      const Divider(height: 1),

      ListTile(

        leading: const CircleAvatar(

          backgroundColor: Color(0xffE3F2FD),

          child: Icon(
            Icons.description,
            color: Color(0xff1565C0),
          ),

        ),

        title: const Text("Description"),

        subtitle: Text(

          artisan!.description?.isNotEmpty == true

              ? artisan!.description!

              : "Aucune description.",

        ),

      ),

    ],

  ),

),

const SizedBox(height: 25),

SizedBox(

  width: double.infinity,

  child: ElevatedButton.icon(

    style: ElevatedButton.styleFrom(

      backgroundColor: const Color(0xff1565C0),

      foregroundColor: Colors.white,

      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),

      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(14),

      ),

    ),

    onPressed: () async {

      final result = await Navigator.push(

        context,

        MaterialPageRoute(

          builder: (_) => const EditArtisanProfileScreen(),

        ),

      );

      if (result == true) {

        setState(() {
          isLoading = true;
        });

        await loadArtisan();

      }

    },

    icon: const Icon(Icons.edit),

    label: const Text(
      "Modifier le profil",
      style: TextStyle(
        fontSize: 16,
      ),
    ),

  ),

),

const SizedBox(height: 15),

SizedBox(

  width: double.infinity,

  child: OutlinedButton.icon(

    style: OutlinedButton.styleFrom(

      foregroundColor: Colors.red,

      side: const BorderSide(
        color: Colors.red,
      ),

      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),

      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(14),

      ),

    ),

    onPressed: () async {

      final confirm = await showDialog<bool>(

        context: context,

        builder: (_) {

          return AlertDialog(

            title: const Text("Déconnexion"),

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

                child: const Text("Déconnexion"),

              ),

            ],

          );

        },

      );

      if (confirm == true) {

        await logout();

      }

    },

    icon: const Icon(Icons.logout),

    label: const Text(
      "Déconnexion",
      style: TextStyle(
        fontSize: 16,
      ),
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