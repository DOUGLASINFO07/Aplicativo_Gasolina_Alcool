import 'dart:async';
import 'package:aplicativo_gasolina_alcool/util/route_generator.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  // *** INIT STATE ***
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, RouteGenerator.ROTA_HOME);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff08abca),
      body: Center(
        child: Container(
          // color: const Color(0xff0066cc),
          padding: const EdgeInsets.all(50),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                    'assets/imagens/texto_splash.jpg',
                ),
                Image.asset(
                    'assets/imagens/splash.jpg',
                  height: 250,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
