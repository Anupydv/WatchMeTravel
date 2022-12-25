import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_me_travel/pages/Loginpage.dart';
import 'package:watch_me_travel/pages/SignUpPage.dart';
import 'package:watch_me_travel/providers/user_provider.dart';
import 'package:watch_me_travel/responsive/mobile_layout.dart';
import 'package:watch_me_travel/responsive/responsive_layout.dart';
import 'package:watch_me_travel/responsive/web_layout.dart';
import 'package:watch_me_travel/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'responsive/responsive_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyA4OG8rk2EMQnK76KDJJhrW2Miiw4W_tBA',
          appId: '1:746467374720:web:3a0df722a78cdb149a9865',
          messagingSenderId: '746467374720',
          projectId: 'watch-me-travel',
          storageBucket: 'watch-me-travel.appspot.com'),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Watch Me Travel',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        //home: const Responsive(
        //webLayout: WebLayout(),
        //mobileLayout: MobileLayout(),
        //),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const Responsive(
                    mobileLayout: MobileLayout(),
                    webLayout: WebLayout(),
                  ); // ReponsiveLayout
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                } // Center
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: primaryColor,
                ));
              }
              return const LoginPage();
            }),
      ),
    );
  }
}
