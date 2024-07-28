import 'package:expense_tracker/login_page.dart';
import 'package:expense_tracker/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';
//import 'package:flutter/services.dart' show rootBundle;
import 'config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await dotenv.load(fileName: 'assets/.env');

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: Config.apiKey,
      appId: Config.appId,
      messagingSenderId: Config.messagingSenderId,
      projectId: 'expense-tracker-bed74',
      authDomain: 'expense-tracker-bed74.firebaseapp.com',
      storageBucket: 'expense-tracker-bed74.appspot.com',
  ));
  runApp(const ExpenseTracker());
}

class ExpenseTracker extends StatelessWidget {
  const ExpenseTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracking App',
      theme: ThemeData(primarySwatch: Colors.blue),
      // home: SummaryView(),
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Center(
          child: Text('Welcome to ExpenseTracker!'),
        ),
      ),
      backgroundColor: Colors.indigo.shade400,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
                print('Login Pressed');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.teal),
              ),
              child: Text('Login'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignupPage()));
                print('Signup Pressed');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.teal),
              ),
              child: Text('Signup'),
            ),
          ],
        ),
      ),
    );
  }
}
