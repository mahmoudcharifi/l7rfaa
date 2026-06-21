import 'package:flutter/material.dart';

import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_textfield.dart';
import '../../core/widgets/logo_widget.dart';
import 'choose_role_screen.dart';
import '../../services/auth_service.dart';
import '../client/client_dashboard.dart';
import '../artisan/artisan_dashboard.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

 Future<void> login() async {

  if (emailController.text.trim().isEmpty ||
      passwordController.text.trim().isEmpty) {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Veuillez remplir tous les champs."),
      ),
    );

    return;
  }

  final authService = AuthService();

  final user = await authService.login(
    emailController.text.trim(),
    passwordController.text.trim(),
  );

  if (!mounted) return;

  if (user == null) {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text("Email ou mot de passe incorrect."),
      ),
    );

    return;
  }

  if (user.role == "client") {

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const ClientDashboard(),
      ),
    );

  } else {

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const ArtisanDashboard(),
      ),
    );

  }

}

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF5F7FA),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 20,
          ),

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.center,

            children: [

              const SizedBox(height: 25),

              const LogoWidget(width: 180),

              const SizedBox(height: 30),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Bienvenue 👋",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Connectez-vous à votre compte",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(height: 35),

              CustomTextField(
                controller: emailController,
                hint: "Email",
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),

              CustomTextField(
                controller: passwordController,
                hint: "Mot de passe",
                icon: Icons.lock_outline,
                obscureText: true,
              ),

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {

                  },
                  child: const Text(
                    "Mot de passe oublié ?",
                  ),
                ),
              ),

              const SizedBox(height: 10),

              CustomButton(
                text: "Connexion",
                onPressed: login,
              ),

              const SizedBox(height: 35),

              Row(

                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  const Text(
                    "Vous n'avez pas de compte ?",
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ChooseRoleScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Créer un compte",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                ],

              )

            ],

          ),

        ),

      ),

    );

  }

}