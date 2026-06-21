import 'dart:io';

import 'package:flutter/material.dart';

import '../../models/portfolio_model.dart';
import '../../models/user.dart';
import '../../services/portfolio_service.dart';
import '../chat/chat_screen.dart';


class ArtisanProfileScreen extends StatefulWidget {

  final UserModel artisan;

  const ArtisanProfileScreen({
    super.key,
    required this.artisan,
  });

  @override
  State<ArtisanProfileScreen> createState() =>
      _ArtisanProfileScreenState();
}

class _ArtisanProfileScreenState
    extends State<ArtisanProfileScreen> {

  final PortfolioService portfolioService =
      PortfolioService();

  List<PortfolioModel> portfolio = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPortfolio();
  }

  Future<void> loadPortfolio() async {

    portfolio = await portfolioService
        .getPortfolio(widget.artisan.id!);

    setState(() {
      isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(

        title: const Text("Profil Artisan"),

        centerTitle: true,

      ),

      body: SingleChildScrollView(

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Container(

              width: double.infinity,

              padding: const EdgeInsets.all(25),

              decoration: const BoxDecoration(

                color: Color(0xff1565C0),

                borderRadius: BorderRadius.only(

                  bottomLeft: Radius.circular(30),

                  bottomRight: Radius.circular(30),

                ),

              ),

              child: Column(

                children: [

                  CircleAvatar(

                    radius: 55,

                    backgroundColor: Colors.white,

                    backgroundImage:

                        widget.artisan.image != null &&
                                widget.artisan.image!
                                    .isNotEmpty

                            ? FileImage(
                                File(
                                  widget.artisan.image!,
                                ),
                              )

                            : null,

                    child:

                        widget.artisan.image == null ||

                                widget.artisan.image!
                                    .isEmpty

                            ? const Icon(

                                Icons.person,

                                size: 55,

                                color: Color(
                                  0xff1565C0,
                                ),

                              )

                            : null,

                  ),

                  const SizedBox(height: 15),

                  Text(

                    "${widget.artisan.firstName} ${widget.artisan.lastName}",

                    style: const TextStyle(

                      color: Colors.white,

                      fontSize: 24,

                      fontWeight:
                          FontWeight.bold,

                    ),

                  ),

                  const SizedBox(height: 10),

                  Container(

                    padding:
                        const EdgeInsets.symmetric(

                      horizontal: 15,

                      vertical: 8,

                    ),

                    decoration: BoxDecoration(

                      color: Colors.white,

                      borderRadius:
                          BorderRadius.circular(20),

                    ),

                    child: Text(

                      widget.artisan.job ?? "",

                      style: const TextStyle(

                        color:
                            Color(0xff1565C0),

                        fontWeight:
                            FontWeight.bold,

                      ),

                    ),

                  ),

                ],

              ),

            ),

            const SizedBox(height: 25),

            Padding(

              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Card(

                shape: RoundedRectangleBorder(

                  borderRadius:
                      BorderRadius.circular(18),

                ),

                child: Padding(

                  padding:
                      const EdgeInsets.all(18),

                  child: Column(

                    children: [

                      ListTile(

                        leading: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),

                        title:
                            const Text("Ville"),

                        subtitle: Text(
                          widget.artisan.city ??
                              "-",
                        ),

                      ),

                      const Divider(),

                      ListTile(

                        leading: const Icon(
                          Icons.phone,
                          color: Colors.green,
                        ),

                        title: const Text(
                            "Téléphone"),

                        subtitle: Text(
                          widget.artisan.phone,
                        ),

                      ),

                      const Divider(),

                      ListTile(

                        leading: const Icon(
                          Icons.email,
                          color: Colors.blue,
                        ),

                        title:
                            const Text("Email"),

                        subtitle: Text(
                          widget.artisan.email,
                        ),

                      ),

                      const Divider(),

                      ListTile(

                        leading: const Icon(
                          Icons.workspace_premium,
                          color: Colors.orange,
                        ),

                        title: const Text(
                          "Expérience",
                        ),

                        subtitle: Text(
                          "${widget.artisan.experience ?? "0"} ans",
                        ),

                      ),

                    ],

                  ),

                ),

              ),

            ),

                        const SizedBox(height: 25),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "À propos",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Text(
                    widget.artisan.description == null ||
                            widget.artisan.description!.isEmpty
                        ? "Aucune description."
                        : widget.artisan.description!,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Portfolio",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : portfolio.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            "Aucune réalisation.",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics:
                            const NeverScrollableScrollPhysics(),
                        padding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: portfolio.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemBuilder: (context, index) {

                          final item = portfolio[index];

                          return ClipRRect(
                            borderRadius:
                                BorderRadius.circular(18),
                            child: Image.file(
                              File(item.image),
                              fit: BoxFit.cover,
                            ),
                          );

                        },
                      ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [

                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Favoris
                      },
                      icon: const Icon(Icons.favorite_border),
                      label: const Text("Favori"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(55),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: ElevatedButton.icon(
                    onPressed: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) => ChatScreen(

                            receiver: widget.artisan,

                          ),

                        ),

                      );

                    },
                      icon: const Icon(Icons.chat),
                      label: const Text("Message"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xff1565C0),
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(55),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 25),

          ],

        ),

      ),

    );

  }

}