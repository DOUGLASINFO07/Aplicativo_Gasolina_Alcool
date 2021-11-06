import 'package:aplicativo_gasolina_alcool/model/resultado_model.dart';
import 'package:aplicativo_gasolina_alcool/util/route_generator.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'ad_state.dart';

class CalculoSimples extends StatefulWidget {

  @override
  _CalculoSimplesState createState() => _CalculoSimplesState();
}

class _CalculoSimplesState extends State<CalculoSimples> {

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

  final _textFieldGasolina = TextEditingController();
  final _textFieldAlcool = TextEditingController();

  ResultadoModel resultado = ResultadoModel();

  _alerta_validar_campos(String textoConteudo, String textoTitulo) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Ok",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xffea651d),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
          backgroundColor: Colors.white,
          title: Text(textoTitulo),
          titleTextStyle: const TextStyle(
            fontSize: 24,
            color: Color(0xff583479),
            fontWeight: FontWeight.bold,
          ),
          titlePadding: const EdgeInsets.all(10),
          content: Text(
            textoConteudo,
          ),
          contentPadding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
                width: 3, color: Theme.of(context).colorScheme.primary),
          ),
          contentTextStyle: const TextStyle(
            fontSize: 20,
            color: Color(0xff583479),
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }

  // *** VALIDA OS CAMPOS DO FORMULÁRIO. ***
  _validarConsulta() {
    if (_textFieldGasolina.text == "") {
      _alerta_validar_campos("Informe o preço da gasolina!", "ATENÇÃO!");
    } else {
      if (_textFieldAlcool.text == "") {
        _alerta_validar_campos("Informe o preço do álcool!", "ATENÇÃO");
      } else {
        _calculo();
        Navigator.pushNamed(context, RouteGenerator.ROTA_RESULTADO, arguments: resultado);
      }
    }
  }

  _calculo(){
    double calculo = double.parse(_textFieldAlcool.text.replaceAll("R\$ ", "").replaceAll(",", "."))
        / double.parse(_textFieldGasolina.text.replaceAll("R\$ ", "").replaceAll(",", "."));
  if(calculo < 0.7){
    resultado.tipoCombustivel = "Álcool";
  }else{
    resultado.tipoCombustivel = "Gasolina";
  }
    resultado.tipoCalculo = "Simples";
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
            const Text("Cálculo simples"),
          ],
        ),
      ),
      backgroundColor: Color(0xff08abca),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/imagens/splash.jpg',
                  height: 250,
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: TextField(
                    cursorColor:  const Color(0xffbb330d),
                    cursorWidth: 3,
                    controller: _textFieldGasolina,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RealInputFormatter(centavos: true, moeda: true),
                    ],
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Color(0xff216222)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                        const BorderSide(color:  const Color(0xffbb330d), width: 2),
                      ),
                      labelText: "Preço da gasolina",
                      labelStyle: const TextStyle(
                        color: Color(0xff216222),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        height: 2.5,
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      // hintText: "E-mail",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 20,
                      height: 1.7,
                    ),
                    onChanged: (valor) {
                     //TODO
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: TextField(
                    cursorColor: const Color(0xffbb330d),
                    cursorWidth: 3,
                    controller: _textFieldAlcool,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RealInputFormatter(centavos: true, moeda: true),
                    ],
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Color(0xff216222)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                        const BorderSide(color:  const Color(0xffbb330d), width: 2),
                      ),
                      labelText: "Preço do álcool",
                      labelStyle: const TextStyle(
                        color: Color(0xff216222),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        height: 2.5,
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      // hintText: "E-mail",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 20,
                      height: 1.7,
                    ),
                    onChanged: (valor) {
                      //TODO
                    },
                  ),
                ),

                // *** BOTÃO DE CALCULO ***
                Padding(
                  padding: const EdgeInsets.only(top: 14, bottom: 8),
                  child: SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      onPressed: () {
                       _validarConsulta();
                      },
                      child: const Text(
                        "Calcular",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xff216222),
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
                  height: 50,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     Image.asset('assets/imagens/logo_info07.png',
                //       height: 60,
                //       width: 60,
                //     ),
                //     const SizedBox(
                //      width: 20,
                //     ),
                //     Image.asset('assets/imagens/dimtech_simbolo.png',
                //       height: 60,
                //       width: 60,
                //     ),
                //   ],
                // ),
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
          ),
        ),
      ),
    );
  }
}

