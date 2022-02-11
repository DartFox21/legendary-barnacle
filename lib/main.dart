import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:godartadmin/routing/route_names.dart';
import 'package:provider/provider.dart';

import 'package:url_strategy/url_strategy.dart';

import 'locator.dart';
import 'routing/router.dart';
import 'services/providers.dart';

void main() async {
  // await dotenv.load(fileName: '.env');
  setupLocator();
  setPathUrlStrategy();
  runApp(MultiProvider(providers: initProviders, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Godart Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Airbnb Cereal',
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      initialRoute: authRoute,
      builder: EasyLoading.init(),
    );
  }
}
