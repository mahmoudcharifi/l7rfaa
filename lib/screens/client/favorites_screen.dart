import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        title: const Text("Mes Favoris"),
        centerTitle: true,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Icon(
                Icons.favorite_border_rounded,
                size: 90,
                color: Colors.grey.shade400,
              ),

              const SizedBox(height: 25),

              const Text(
                "Aucun favori",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                "Vous n'avez ajouté aucun artisan à vos favoris pour le moment.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.search),
                label: const Text("Rechercher un artisan"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1565C0),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(220, 50),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}