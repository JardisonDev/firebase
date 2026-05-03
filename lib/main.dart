import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:inspector_ro/pages/login_page.dart';
import 'package:inspector_ro/pages/management.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: RotasTelas()));
}

class RotasTelas extends StatelessWidget {
  const RotasTelas({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Fork',
                      style: TextStyle(
                        fontFamily: 'Lufga',

                        color: Color(0xff323232),
                        fontSize: 45,
                        //fontWeight: FontWeight.bold,
                        height: 1,
                        //fontFamily:
                      ),
                    ),
                    Text(
                      'Lift',
                      style: TextStyle(
                        fontFamily: 'Lufga',
                        color: Color(0xffd1655b),
                        fontSize: 45,
                        //fontWeight: FontWeight.w700,
                        height: 1,
                        //fontFamily:
                      ),
                    ),
                  ],
                ),
                const Text('Carregando Frota'),
                const CircularProgressIndicator(),
              ],
            ),
          );
        } else {
          if (snapshot.hasData) {
            return ManagementScreen();
          } else {
            return LoginPage();
          }
        }
      },
    );
  }
}
