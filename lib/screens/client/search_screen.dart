
import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../services/user_service.dart';
import '../../core/widgets/artisan_card.dart';
import 'artisan_profile_screen.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final UserService userService = UserService();

    List<UserModel> artisans = [];

    bool isLoading = true;

  final TextEditingController searchController =
      TextEditingController();

  final List<Map<String, dynamic>> categories = [

    {
      "title": "Plombier",
      "icon": Icons.plumbing,
    },

    {
      "title": "Électricien",
      "icon": Icons.electrical_services,
    },

    {
      "title": "Peintre",
      "icon": Icons.format_paint,
    },

    {
      "title": "Menuisier",
      "icon": Icons.handyman,
    },

    {
      "title": "Maçon",
      "icon": Icons.foundation,
    },

    {
      "title": "Climatisation",
      "icon": Icons.ac_unit,
    },

  ];

  @override
void initState() {
  super.initState();
  loadArtisans();
}

Future<void> loadArtisans() async {

  artisans = await userService.getArtisans();

  setState(() {
    isLoading = false;
  });

}


Future<void> search(String value) async {

  if (value.trim().isEmpty) {

    loadArtisans();

    return;

  }

  artisans = await userService.searchArtisans(value);

  setState(() {});

}

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(

        title: const Text("L7RFA"),

        centerTitle: true,

        elevation: 0,

      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(

              "Bonjour 👋",

              style: TextStyle(

                fontSize: 30,

                fontWeight: FontWeight.bold,

              ),

            ),

            const SizedBox(height: 8),

            const Text(

              "Quel artisan recherchez-vous ?",

              style: TextStyle(

                color: Colors.grey,

                fontSize: 16,

              ),

            ),

            const SizedBox(height: 25),

            TextField(

              controller: searchController,
                onChanged: (value) {

                  search(value);

                },
              decoration: InputDecoration(

                hintText:
                    "Rechercher un artisan...",

                prefixIcon:
                    const Icon(Icons.search),

                filled: true,

                fillColor: Colors.white,

                border: OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(18),

                  borderSide: BorderSide.none,

                ),

              ),

            ),

            const SizedBox(height: 30),

            const Text(

              "Catégories",

              style: TextStyle(

                fontSize: 22,

                fontWeight: FontWeight.bold,

              ),

            ),

            const SizedBox(height: 20),

                        SizedBox(

              height: 120,

              child: ListView.builder(

                scrollDirection: Axis.horizontal,

                itemCount: categories.length,

                itemBuilder: (context, index) {

                  return  GestureDetector(

                      onTap: () async {

                        if (categories[index]["title"] == "Tous") {

                          await loadArtisans();

                          return;

                        }

                        artisans = await userService.getArtisansByJob(
                          categories[index]["title"],
                        );

                        setState(() {});

                      },

                    child: Container(

                    width: 100,

                    margin: const EdgeInsets.only(right: 15),

                    decoration: BoxDecoration(

                      color: Colors.white,

                      borderRadius: BorderRadius.circular(20),

                      boxShadow: [

                        BoxShadow(

                          color: Colors.grey.withOpacity(.15),

                          blurRadius: 8,

                          offset: const Offset(0, 4),

                        ),

                      ],

                    ),

                    child: Column(

                      mainAxisAlignment:
                          MainAxisAlignment.center,

                      children: [

                        Icon(

                          categories[index]["icon"],

                          color: Colors.blue,

                          size: 38,

                        ),

                        const SizedBox(height: 10),

                        Text(

                          categories[index]["title"],

                          textAlign: TextAlign.center,

                          style: const TextStyle(

                            fontWeight: FontWeight.w600,

                          ),

                        ),

                      ],

                    ),

                  ),);

                },

              ),

            ),

            const SizedBox(height: 35),

            const Text(

              "Artisans recommandés",

              style: TextStyle(

                fontSize: 22,

                fontWeight: FontWeight.bold,

              ),

            ),

            const SizedBox(height: 20),

          isLoading

    ? const Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: CircularProgressIndicator(),
        ),
      )

    : artisans.isEmpty

        ? const Center(
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                "Aucun artisan disponible.",
                style: TextStyle(fontSize: 18),
              ),
            ),
          )

        : ListView.builder(

            shrinkWrap: true,

            physics: const NeverScrollableScrollPhysics(),

            itemCount: artisans.length,

            itemBuilder: (context, index) {

              final artisan = artisans[index];

              return Padding(

                padding: const EdgeInsets.only(bottom: 15),

                child: ArtisanCard(
  name: "${artisan.firstName} ${artisan.lastName}",
  job: artisan.job ?? "",
  city: artisan.city ?? "",
  rating: "5.0",
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ArtisanProfileScreen(
          artisan: artisan,
        ),
      ),
    );
  },
),

              );

            },

          ),

          ],

        ),

      ),

    );

  }



  @override
  void dispose() {

    searchController.dispose();

    super.dispose();

  }

}