import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_textfield.dart';
import '../../models/portfolio_model.dart';
import '../../services/portfolio_service.dart';

class AddPortfolioScreen extends StatefulWidget {

  final int userId;

  const AddPortfolioScreen({
    super.key,
    required this.userId,
  });

  @override
  State<AddPortfolioScreen> createState() =>
      _AddPortfolioScreenState();
}

class _AddPortfolioScreenState
    extends State<AddPortfolioScreen> {

  final titleController = TextEditingController();

  final descriptionController =
      TextEditingController();

  File? image;

  final picker = ImagePicker();

  final portfolioService = PortfolioService();

  Future<void> pickImage() async {

    final XFile? pickedImage =
        await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {

      setState(() {

        image = File(pickedImage.path);

      });

    }

  }

    Future<void> savePortfolio() async {

    if (titleController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty ||
        image == null) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Veuillez remplir tous les champs."),
        ),
      );

      return;
    }

    PortfolioModel portfolio = PortfolioModel(
      userId: widget.userId,
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      image: image!.path,
    );

    await portfolioService.addPortfolio(portfolio);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text("Réalisation ajoutée avec succès."),
      ),
    );

    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Ajouter une réalisation"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            GestureDetector(

              onTap: pickImage,

              child: Container(

                height: 220,

                width: double.infinity,

                decoration: BoxDecoration(

                  color: Colors.grey.shade200,

                  borderRadius: BorderRadius.circular(20),

                ),

                child: image == null

                    ? const Column(

                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [

                          Icon(
                            Icons.add_a_photo,
                            size: 60,
                            color: Colors.grey,
                          ),

                          SizedBox(height: 10),

                          Text(
                            "Choisir une image",
                          ),

                        ],

                      )

                    : ClipRRect(

                        borderRadius: BorderRadius.circular(20),

                        child: Image.file(
                          image!,
                          fit: BoxFit.cover,
                        ),

                      ),

              ),

            ),

            const SizedBox(height: 25),

            CustomTextField(
              controller: titleController,
              hint: "Titre",
              icon: Icons.title,
            ),

            const SizedBox(height: 20),

            TextField(

              controller: descriptionController,

              maxLines: 5,

              decoration: InputDecoration(

                hintText: "Description",

                filled: true,

                fillColor: Colors.white,

                border: OutlineInputBorder(

                  borderRadius: BorderRadius.circular(16),

                ),

              ),

            ),

            const SizedBox(height: 30),

            CustomButton(

              text: "Enregistrer",

              onPressed: savePortfolio,

            ),

          ],

        ),

      ),

    );

  }

}

