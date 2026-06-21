import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'screens/splash/splash_screen.dart';
import 'services/fake_data_service.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await FakeDataService().insertFakeArtisans();

  runApp(const L7RFA());

}

class L7RFA extends StatelessWidget {

  const L7RFA({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'L7RFA',

      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,

      home: const SplashScreen(),

    );

  }

}