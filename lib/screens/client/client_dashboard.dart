import 'package:flutter/material.dart';

import 'favorites_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';
import '../chat/conversations_screen.dart';
class ClientDashboard extends StatefulWidget {
  const ClientDashboard({super.key});

  @override
  State<ClientDashboard> createState() => _ClientDashboardState();
}

class _ClientDashboardState extends State<ClientDashboard> {

  int currentIndex = 0;

  final List<Widget> pages = const [

    SearchScreen(),

    FavoritesScreen(),

    ConversationsScreen(),

    ProfileScreen(),

  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: pages[currentIndex],

      bottomNavigationBar: NavigationBar(

        selectedIndex: currentIndex,

        onDestinationSelected: (index){

          setState(() {

            currentIndex = index;

          });

        },

        destinations: const [

          NavigationDestination(

            icon: Icon(Icons.search_outlined),

            selectedIcon: Icon(Icons.search),

            label: "Recherche",

          ),

          NavigationDestination(

            icon: Icon(Icons.favorite_border),

            selectedIcon: Icon(Icons.favorite),

            label: "Favoris",

          ),

          NavigationDestination(

            icon: Icon(Icons.chat_outlined),

            selectedIcon: Icon(Icons.chat),

            label: "Messages",

          ),

          NavigationDestination(

            icon: Icon(Icons.person_outline),

            selectedIcon: Icon(Icons.person),

            label: "Profil",

          ),

        ],

      ),

    );

  }

}
