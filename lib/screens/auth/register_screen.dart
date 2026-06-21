import 'package:flutter/material.dart';

import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_textfield.dart';
import '../../core/widgets/logo_widget.dart';
import '../../models/user.dart';
import '../../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  final String role;

  const RegisterScreen({
    super.key,
    required this.role,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final cityController = TextEditingController();
  final experienceController = TextEditingController();
  final descriptionController = TextEditingController();

  String? selectedJob;

  final List<String> jobs = [
    "Plombier",
    "Électricien",
    "Peintre",
    "Menuisier",
    "Maçon",
    "Carreleur",
    "Jardinier",
    "Climatisation",
    "Soudeur",
    "Plâtrier",
    "Technicien informatique",
    "Réparateur électroménager",
  ];

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    cityController.dispose();
    experienceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> register() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Les mots de passe ne correspondent pas.",
          ),
        ),
      );

      return;
    }

    if (widget.role == "artisan" && selectedJob == null) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Veuillez sélectionner votre métier.",
          ),
        ),
      );

      return;
    }

    // Partie 3
    
    final user = UserModel(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      phone: phoneController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      role: widget.role,
      city: widget.role == "artisan"
          ? cityController.text.trim()
          : null,
      job: widget.role == "artisan"
          ? selectedJob
          : null,
      description: widget.role == "artisan"
          ? descriptionController.text.trim()
          : null,
      experience: widget.role == "artisan"
          ? experienceController.text.trim()
          : null,
      image: null,
    );

    final AuthService authService = AuthService();

    bool success = await authService.register(user);

    if (!mounted) return;

    if (success) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Compte créé avec succès."),
        ),
      );

      Navigator.pop(context);

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Cet email existe déjà."),
        ),
      );

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        centerTitle: true,
        title: const Text("Créer un compte"),
      ),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(20),

          child: Form(

            key: _formKey,

            child: Column(

              children: [

                const SizedBox(height: 20),

                const LogoWidget(width: 170),

                const SizedBox(height: 25),

                const Text(
                  "Créer un compte",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Inscrivez-vous gratuitement",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 35),

                CustomTextField(
                  controller: firstNameController,
                  hint: "Nom",
                  icon: Icons.person_outline,
                ),

                const SizedBox(height: 18),

                CustomTextField(
                  controller: lastNameController,
                  hint: "Prénom",
                  icon: Icons.person_outline,
                ),

                const SizedBox(height: 18),

                CustomTextField(
                  controller: phoneController,
                  hint: "Téléphone",
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 18),

                CustomTextField(
                  controller: emailController,
                  hint: "Email",
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 18),

                CustomTextField(
                  controller: passwordController,
                  hint: "Mot de passe",
                  icon: Icons.lock_outline,
                  obscureText: true,
                ),

                const SizedBox(height: 18),

                CustomTextField(
                  controller: confirmPasswordController,
                  hint: "Confirmer le mot de passe",
                  icon: Icons.lock_outline,
                  obscureText: true,
                ),

                CustomTextField(
                  controller: confirmPasswordController,
                  hint: "Confirmer le mot de passe",
                  icon: Icons.lock_outline,
                  obscureText: true,
                ),

                  const SizedBox(height: 20),

                if (widget.role == "artisan") ...[

                  CustomTextField(
                    controller: cityController,
                    hint: "Ville",
                    icon: Icons.location_on_outlined,
                  ),

                  const SizedBox(height: 18),

                  DropdownButtonFormField<String>(
                    value: selectedJob,
                    decoration: InputDecoration(
                      hintText: "Sélectionner votre métier",
                      prefixIcon: const Icon(Icons.work_outline),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xff1565C0),
                          width: 2,
                        ),
                      ),
                    ),
                    items: jobs.map((job) {
                      return DropdownMenuItem<String>(
                        value: job,
                        child: Text(job),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedJob = value;
                      });
                    },
                  ),

                  const SizedBox(height: 18),

                  CustomTextField(
                    controller: experienceController,
                    hint: "Années d'expérience",
                    icon: Icons.workspace_premium_outlined,
                    keyboardType: TextInputType.number,
                  ),

                  const SizedBox(height: 18),

                  TextField(
                    controller: descriptionController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Décrivez votre activité",
                      alignLabelWithHint: true,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(bottom: 70),
                        child: Icon(Icons.description_outlined),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xff1565C0),
                          width: 2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),
                ],

                CustomButton(
                  text: "Créer mon compte",
                  onPressed: register,
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const Text(
                      "Vous avez déjà un compte ?",
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Se connecter",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

