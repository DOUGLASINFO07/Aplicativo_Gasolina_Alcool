import 'package:aplicativo_gasolina_alcool/splash.dart';
import 'package:aplicativo_gasolina_alcool/util/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'ad_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  runApp(
    Provider.value(
      value: adState,
      builder: (context, child) => MaterialApp(
        title: "Gasolina Álcool",
        theme: ThemeData().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                secondary: const Color(0xffffffff),
                primary: const Color(0xff08abca),
              ),
        ),
        initialRoute: "/",
        onGenerateRoute: RouteGenerator.generateRoute,
        home: Splash(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
