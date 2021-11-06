import 'package:aplicativo_gasolina_alcool/model/resultado_model.dart';
import 'package:aplicativo_gasolina_alcool/util/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'ad_state.dart';

class CalculoCompleto extends StatefulWidget {

  @override
  _CalculoCompletoState createState() => _CalculoCompletoState();
}

class _CalculoCompletoState extends State<CalculoCompleto> {

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

  final _textFieldConsumoCarroAlcool = TextEditingController();
  final _textFieldConsumoCarroGasolina = TextEditingController();
  final _textFieldPrecoGasolina = TextEditingController();
  final _textFieldPrecoAlcool = TextEditingController();
  final _textFieldAbastecimento = TextEditingController();

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
    if (_textFieldConsumoCarroGasolina.text == "") {
      _alerta_validar_campos("Informe a média de consumo do seu veículo com gasolina!", "ATENÇÃO!");
    } else {
      if (_textFieldPrecoGasolina.text == "") {
        _alerta_validar_campos("Informe o preço da gasolina!", "ATENÇÃO");
      } else {
        if (_textFieldConsumoCarroAlcool.text == "") {
          _alerta_validar_campos("Informe a média de consumo do seu veículo com álcool!", "ATENÇÃO");
        } else {
          if (_textFieldPrecoAlcool.text == "") {
            _alerta_validar_campos("Informe o preço do álcool!", "ATENÇÃO");
          } else {
            if (_textFieldAbastecimento.text == "") {
              _alerta_validar_campos("Informe o valor para abastecer!", "ATENÇÃO");
            } else {
                _calculo();
                Navigator.pushNamed(context, RouteGenerator.ROTA_RESULTADO, arguments: resultado);
            }
          }
        }
      }
    }
  }

  _calculo(){

    double calculoGasolina = (double.parse(_textFieldAbastecimento.text.replaceAll("R\$ ", "").replaceAll(",", "."))
        / double.parse(_textFieldPrecoGasolina.text.replaceAll("R\$ ", "").replaceAll(",", "."))
     * double.parse(_textFieldConsumoCarroGasolina.text.replaceAll("R\$ ", "").replaceAll(",", ".")));

    double calculoAlcool = (double.parse(_textFieldAbastecimento.text.replaceAll("R\$ ", "").replaceAll(",", "."))
        / double.parse(_textFieldPrecoAlcool.text.replaceAll("R\$ ", "").replaceAll(",", "."))
        * double.parse(_textFieldConsumoCarroAlcool.text.replaceAll("R\$ ", "").replaceAll(",", ".")));

    double calculoLitroGasolina = (double.parse(_textFieldAbastecimento.text.replaceAll("R\$ ", "").replaceAll(",", "."))
        / double.parse(_textFieldPrecoGasolina.text.replaceAll("R\$ ", "").replaceAll(",", ".")));

    double calculoLitroAlcool = (double.parse(_textFieldAbastecimento.text.replaceAll("R\$ ", "").replaceAll(",", "."))
        / double.parse(_textFieldPrecoAlcool.text.replaceAll("R\$ ", "").replaceAll(",", ".")));

    resultado.kmGasolina = calculoGasolina;
    resultado.kmAlcool = calculoAlcool;
    resultado.litrosGasolina = calculoLitroGasolina;
    resultado.litrosAlcool = calculoLitroAlcool;
    resultado.valorAbastecer = double.parse(_textFieldAbastecimento.text.replaceAll("R\$ ", "").replaceAll(",", "."));

    if(calculoGasolina > calculoAlcool){
      resultado.tipoCombustivel = "Gasolina";
    }else{
      resultado.tipoCombustivel = "Álcool";
    }
    resultado.tipoCalculo = "Completo";

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
            const Text("Cálculo completo"),
          ],
        ),
      ),
      backgroundColor: Color(0xff08abca),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/imagens/splash.jpg',
                  height: 200,
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    cursorColor:  const Color(0xffbb330d),
                    cursorWidth: 3,
                    controller: _textFieldConsumoCarroGasolina,
                    keyboardType: TextInputType.number,
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
                      labelText: "Km por litro de gasolina.",
                      labelStyle: const TextStyle(
                        color: Color(0xff216222),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        height: 3,
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
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    cursorColor: const Color(0xffbb330d),
                    cursorWidth: 3,
                    controller: _textFieldPrecoGasolina,
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
                      labelText: "Preço por litro da gasolina",
                      labelStyle: const TextStyle(
                        color: Color(0xff216222),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        height: 3,
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
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    cursorColor:  const Color(0xffbb330d),
                    cursorWidth: 3,
                    controller: _textFieldConsumoCarroAlcool,
                    keyboardType: TextInputType.number,
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
                      labelText: "Km por litro de álcool.",
                      labelStyle: const TextStyle(
                        color: Color(0xff216222),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        height: 3,
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
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    cursorColor: const Color(0xffbb330d),
                    cursorWidth: 3,
                    controller: _textFieldPrecoAlcool,
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
                      labelText: "Preço por litro do álcool",
                      labelStyle: const TextStyle(
                        color: Color(0xff216222),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        height: 3,
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
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    cursorColor: const Color(0xffbb330d),
                    cursorWidth: 3,
                    controller: _textFieldAbastecimento,
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
                      labelText: "Vai abastecer quantos reais?",
                      labelStyle: const TextStyle(
                        color: Color(0xff216222),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        height: 3,
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

                // *** BOTÃO DE CADASTRO ***
                Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 8),
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
                  height: 10,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     Image.asset('assets/imagens/logo_info07.png',
                //       height: 60,
                //       width: 60,
                //     ),
                //     const SizedBox(
                //       width: 20,
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

