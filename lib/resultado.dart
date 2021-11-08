import 'package:aplicativo_gasolina_alcool/model/resultado_model.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'ad_state.dart';

class Resultado extends StatefulWidget {
  ResultadoModel? resultado;

  Resultado(this.resultado);

  @override
  _ResultadoState createState() => _ResultadoState();
}

class _ResultadoState extends State<Resultado> {

  String _tipoCalculo = "Simples";
  String _tipoCombustivel = "Gasolina";

  BannerAd? banner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization!.then((status) {
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
  void initState() {
    _tipoCalculo = widget.resultado!.tipoCalculo;
    _tipoCombustivel = widget.resultado!.tipoCombustivel;
    super.initState();
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
            const Text("Relatório"),
          ],
        ),
      ),
      backgroundColor: Color(0xff08abca),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/imagens/splash.jpg',
                          height: 250,
                        ),
                        const Text(
                          "Melhor abastecer com: ",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffffffff),
                          ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                        _tipoCalculo != "Simples"
                            ? Center(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 50,
                                      // width: 200,
                                      alignment: Alignment.center,
                                      color: Colors.white,
                                      child: Text(
                                        _tipoCombustivel,
                                        style: const TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff11445f),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(15),
                                      // alignment: Alignment.centerLeft,
                                      color: Colors.white,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "* Abastecendo R\$ ${widget.resultado!.valorAbastecer.toStringAsFixed(2).replaceAll(".", ",")}.",
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff11445f),
                                            ),
                                          ),
                                          Text(
                                            "* ${widget.resultado!.litrosGasolina.toStringAsFixed(2).replaceAll(".", ",")} litros de gasolina.",
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff11445f),
                                            ),
                                          ),
                                          Text(
                                            "* ${widget.resultado!.litrosAlcool.toStringAsFixed(2).replaceAll(".", ",")} litros de álcool.",
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff11445f),
                                            ),
                                          ),
                                          Text(
                                            "* Vai rodar ${widget.resultado!.kmAlcool.toStringAsFixed(2).replaceAll(".", ",")} Km no álcool.",
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff11445f),
                                            ),
                                          ),
                                          Text(
                                            "* Vai rodar ${widget.resultado!.kmGasolina.toStringAsFixed(2).replaceAll(".", ",")} Km na gasolina.",
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff11445f),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Center(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 50,
                                      // width: 200,
                                      alignment: Alignment.center,
                                      color: Colors.white,
                                      child: Text(
                                        _tipoCombustivel,
                                        style: const TextStyle(
                                          fontSize: 34,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff11445f),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 60,
                                    ),
                                  ],
                                ),
                              ),
                        // *** BOTÃO DE CADASTRO ***
                        Padding(
                          padding: const EdgeInsets.only(top: 14, bottom: 8),
                          child: SizedBox(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Novo cálculo",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xff216222),
                                elevation: 5,
                                padding:
                                    const EdgeInsets.fromLTRB(32, 16, 32, 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (banner == null)
              const SizedBox(
                height: 50,
              )
            else
              Container(
                height: 50,
                child: AdWidget(ad: banner!),
              ),
          ],
        ),
      ),
    );
  }
}
