import 'package:flutter/material.dart';

import 'messages_screen.dart';
import 'portfolio_screen.dart';
import 'profile_screen.dart';

class ArtisanDashboard extends StatefulWidget {
  const ArtisanDashboard({super.key});

  @override
  State<ArtisanDashboard> createState() => _ArtisanDashboardState();
}

class _ArtisanDashboardState extends State<ArtisanDashboard> {

  int currentIndex = 0;

  final List<Widget> pages = const [

    PortfolioScreen(),

    MessagesScreen(),

    ArtisanProfileScreen(),

  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: pages[currentIndex],

      bottomNavigationBar: NavigationBar(

        selectedIndex: currentIndex,

        onDestinationSelected: (index){

          setState(() {

            currentIndex=index;

          });

        },

        destinations: const [

          NavigationDestination(

            icon: Icon(Icons.work_outline),

            selectedIcon: Icon(Icons.work),

            label: "Portfolio",

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