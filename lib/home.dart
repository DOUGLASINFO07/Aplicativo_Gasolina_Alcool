import 'package:aplicativo_gasolina_alcool/util/route_generator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'ad_state.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  BannerAd? banner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization!.then((status){
      setState(() {
        banner = BannerAd(
            size: AdSize.banner,
            adUnitId: adState.bannerAdUnitid,
            listener: adState.adListener!,
            request: const AdRequest(),
        )..load();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Image.asset(
              'assets/imagens/bomba.png',
              height: 40,
              width: 40,
            ),
            const SizedBox(
              width: 20,
            ),
            const Text("Aplicativo Gasolina ou Álcool"),
          ],
        ),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xffffffff),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 50,
                    ),
                    Image.asset('assets/imagens/principal.jpg',
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              "Gasolina ou Álcool?",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff11445f),
                              ),
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                            const Text(
                              "Escolha uma opção abaixo e faça o "
                                  "cálculo para saber qual o melhor "
                                  "combustível para abastecer seu carro, "
                                  "baseado no preço dos combustiveis!",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff11445f),
                              ),
                              // textAlign: ,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            // *** BOTÃO DE CALCULO SIMPLES ***
                            Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 8),
                              child: SizedBox(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, RouteGenerator.ROTA_CALCULO_SIMPLES);
                                  },
                                  child: const Text(
                                    "Cálculo simples",
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xff08abca),
                                    elevation: 5,
                                    padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                          color: Theme.of(context).colorScheme.secondary),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // *** BOTÃO DE CALCULO COMPLETO ***
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: SizedBox(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, RouteGenerator.ROTA_CALCULO_COMPLETO);
                                  },
                                  child: const Text(
                                    "Cálculo completo",
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xff08abca),
                                    elevation: 5,
                                    padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                          color: Theme.of(context).colorScheme.secondary),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: <Widget>[
                            //     Image.asset('assets/imagens/logo_info07.png',
                            //       height: 70,
                            //       width: 70,
                            //     ),
                            //     const SizedBox(
                            //       width: 20,
                            //     ),
                            //     Image.asset('assets/imagens/dimtech_simbolo.png',
                            //       height: 40,
                            //       width: 40,
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if(banner == null)
              const SizedBox(
                height: 50,
              )
            else
              Container(
                height: 50,
                child: AdWidget(ad: banner!),
              )
          ],
        ),
      )
    );
  }
}
