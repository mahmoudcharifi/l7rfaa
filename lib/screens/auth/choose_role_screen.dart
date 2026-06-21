import 'package:flutter/material.dart';
import 'register_screen.dart';

class ChooseRoleScreen extends StatelessWidget {
  const ChooseRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Créer un compte",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 20),

            const Text(
              "Quel type de compte souhaitez-vous créer ?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "Choisissez le profil qui correspond à votre activité.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 35),

            RoleCard(
              title: "Artisan",
              icon: Icons.handyman,
              color: Colors.orange,
              description:
                  "Présentez vos services\nAjoutez votre portfolio\nRecevez des demandes",
              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) => const RegisterScreen(
                      role: "artisan",
                    ),

                  ),

                );

              },
            ),

            const SizedBox(height: 25),

            RoleCard(
              title: "Client",
              icon: Icons.person,
              color: Colors.blue,
              description:
                  "Recherchez un artisan\nContactez facilement\nAjoutez aux favoris",
              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) => const RegisterScreen(
                      role: "client",
                    ),

                  ),

                );

              },
            ),
          ],
        ),
      ),
    );
  }
}

class RoleCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [

            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 8,
              offset: const Offset(0,3),
            )

          ],
        ),
        child: Row(
          children: [

            CircleAvatar(
              radius: 30,
              backgroundColor: color.withOpacity(.15),
              child: Icon(
                icon,
                color: color,
                size: 32,
              ),
            ),

            const SizedBox(width: 20),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),

                ],
              ),
            ),

            const Icon(Icons.arrow_forward_ios)

          ],
        ),
      ),
    );
  }
}