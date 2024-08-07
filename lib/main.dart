import 'package:ecomerance_app/Screens/stripescreen.dart';
import 'package:ecomerance_app/Screens/welcome_screen.dart';
import 'package:ecomerance_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Stripe.publishableKey =
      'pk_test_51PlB8iBwFdLEhpT1ik70Ywl3IZaxIXg6HzKd9HkQOXkNq6vQa5d932hxTDnlTfhtXH1huY6AbAbhYJbFnemyrVM700rgeTe10k';
  await Stripe.instance.applySettings();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => PaymentController())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BAHTAREEN.COM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
    );
  }
}



// class AuthDecisionScreen extends StatefulWidget {
//   const AuthDecisionScreen({Key? key});
//
//   @override
//   _AuthDecisionScreenState createState() => _AuthDecisionScreenState();
// }
//
// class _AuthDecisionScreenState extends State<AuthDecisionScreen> {
//   Future<bool?> _getUserRole() async {
//     final User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       try {
//         DocumentSnapshot<Map<String, dynamic>> snapshot =
//         await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
//         if (snapshot.exists) {
//           final String? role = snapshot.data()?['role'];
//           if (role != null) {
//             return role.toLowerCase() == 'admin';
//           }
//         }
//       } catch (e) {
//         print('Error determining user role: $e');
//       }
//     }
//     return null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<bool?>(
//       future: _getUserRole(),
//       builder: (BuildContext context, AsyncSnapshot<bool?> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator(color: Colors.teal,));
//         }
//         if (snapshot.hasError || !snapshot.hasData) {
//           return AuthPage();
//         }
//         if (snapshot.data!) {
//           return AdminAuthPage();
//         } else {
//           return AuthPage();
//         }
//       },
//     );
//   }
// }