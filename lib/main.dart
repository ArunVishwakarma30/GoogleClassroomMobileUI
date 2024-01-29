import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hci_lms/controllers/auth_provider.dart';
import 'package:hci_lms/controllers/create_class_provider.dart';
import 'package:hci_lms/controllers/navbar_provider.dart';
import 'package:hci_lms/views/app_constants.dart';
import 'package:hci_lms/views/ui/auth/login_page.dart';
import 'package:hci_lms/views/ui/main/home_page.dart';
import 'package:provider/provider.dart';

void main() {
WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (create) => AuthProvider()),
      ChangeNotifierProvider(create: (create) => CreateClassProvider()),
      ChangeNotifierProvider(create: (create) => NavbarProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

          appBarTheme: const AppBarTheme(
            color: Colors.white, // Set your desired background color

          // Other theme configurations...
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: darkThemeColor),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
