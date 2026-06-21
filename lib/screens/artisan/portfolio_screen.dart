import 'dart:io';

import 'package:flutter/material.dart';

import '../../models/portfolio_model.dart';
import '../../services/auth_service.dart';
import '../../services/portfolio_service.dart';
import 'add_portfolio_screen.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {

  final PortfolioService portfolioService = PortfolioService();
  final AuthService authService = AuthService();

  List<PortfolioModel> portfolioList = [];

  int? userId;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPortfolio();
  }

  Future<void> loadPortfolio() async {

    userId = await authService.getUserId();

    if (userId == null) {

      setState(() {
        isLoading = false;
      });

      return;
    }

    portfolioList = await portfolioService.getPortfolio(userId!);

    setState(() {
      isLoading = false;
    });

  }

    @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Mon Portfolio"),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton.extended(

  backgroundColor: const Color(0xff1565C0),

  foregroundColor: Colors.white,

  icon: const Icon(Icons.add),

  label: const Text("Ajouter"),

  onPressed: () async {

    if (userId == null) return;

    final result = await Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) => AddPortfolioScreen(
          userId: userId!,
        ),

      ),

    );

    if (result == true) {

      setState(() {
        isLoading = true;
      });

      await loadPortfolio();

    }

  },

),

      body: isLoading

          ? const Center(
              child: CircularProgressIndicator(),
            )

          : portfolioList.isEmpty

              ? const Center(

                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      Icon(
                        Icons.photo_library_outlined,
                        size: 80,
                        color: Colors.grey,
                      ),

                      SizedBox(height: 20),

                      Text(
                        "Aucune réalisation",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        "Ajoutez votre première réalisation.",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                    ],

                  ),

                )

              : ListView.builder(

                  padding: const EdgeInsets.all(15),

                  itemCount: portfolioList.length,

                  itemBuilder: (context, index) {

                    final portfolio = portfolioList[index];

                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(18),
                          ),
child :ClipRRect(
  borderRadius: const BorderRadius.vertical(
    top: Radius.circular(18),
  ),
  child: Image.file(

    File(portfolio.image),

    height: 180,

    width: double.infinity,

    fit: BoxFit.cover,

    errorBuilder: (_, __, ___) {

      return Container(

        height: 180,

        color: Colors.grey.shade300,

        child: Center(

          child: Icon(
            Icons.image,
            size: 60,
            color: Colors.grey,
          ),

        ),

      );

    },

  ),

),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [

                              Text(
                                portfolio.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                portfolio.description,
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  height: 1.4,
                                ),
                              ),

                              const SizedBox(height: 15),

                              Row(
                                children: [

                                  const Icon(
                                    Icons.calendar_today,
                                    size: 16,
                                    color: Colors.grey,
                                  ),

                                  const SizedBox(width: 6),

                                  Text(
                                    "20 Juin 2026",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),

                                ],
                              ),

                              const SizedBox(height: 18),

                              Row(
                                children: [

                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: () {

                                        // Modifier

                                      },
                                      icon: const Icon(Icons.edit),
                                      label: const Text("Modifier"),
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                      ),
onPressed: () async {

  final confirm = await showDialog<bool>(

    context: context,

    builder: (context) {

      return AlertDialog(

        title: const Text("Supprimer"),

        content: const Text(
          "Voulez-vous vraiment supprimer cette réalisation ?",
        ),

        actions: [

          TextButton(

            onPressed: () {

              Navigator.pop(context, false);

            },

            child: const Text("Annuler"),

          ),

          ElevatedButton(

            onPressed: () {

              Navigator.pop(context, true);

            },

            child: const Text("Supprimer"),

          ),

        ],

      );

    },

  );

  if (confirm == true) {

    await portfolioService.deletePortfolio(
      portfolio.id!,
    );

    await loadPortfolio();

  }

},
                                      icon: const Icon(Icons.delete),
                                      label: const Text("Supprimer"),
                                    ),
                                  ),

                                ],
                              ),

                            ],
                          ),
                        ),

                      ],
                    ),
                  );

                  },

                ),

    );

  }

}
