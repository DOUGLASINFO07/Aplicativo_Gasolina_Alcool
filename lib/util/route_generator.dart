import 'package:aplicativo_gasolina_alcool/calculo_completo.dart';
import 'package:aplicativo_gasolina_alcool/calculo_simples.dart';
import 'package:aplicativo_gasolina_alcool/home.dart';
import 'package:aplicativo_gasolina_alcool/resultado.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const String ROTA_HOME = "/home";
  static const String ROTA_CALCULO_SIMPLES = "/simples";
  static const String ROTA_CALCULO_COMPLETO = "/completo";
  static const String ROTA_RESULTADO = "/resultado";
  // static const String ROTA_MEUS_ANUNCIOS = "/meus_anuncios";
  // static const String ROTA_NOVO_ANUNCIO = "/novo_anuncio";
  // static const String ROTA_EDITAR_ANUNCIO = "/editar_anuncio";
  // static const String ROTA_DETALHES_ANUNCIO = "/detalhes_anuncio";

  static var args;

  static Route<dynamic> generateRoute(RouteSettings settings) {
   args = settings.arguments;

    switch (settings.name) {
      case ROTA_HOME:
        return MaterialPageRoute(
          builder: (_) => Home(),
        );
      case ROTA_CALCULO_SIMPLES:
        return MaterialPageRoute(
          builder: (_) => CalculoSimples(),
        );
      case ROTA_CALCULO_COMPLETO:
        return MaterialPageRoute(
          builder: (_) => CalculoCompleto(),
        );
      case ROTA_RESULTADO:
        return MaterialPageRoute(
          builder: (_) => Resultado(args),
        );
      // case ROTA_MEUS_ANUNCIOS:
      //   return MaterialPageRoute(
      //     builder: (_) => MeusAnuncios(),
      //   );
      //   case ROTA_NOVO_ANUNCIO:
      //   return MaterialPageRoute(
      //     builder: (_) => NovoAnuncio(),
      //   );
      //   case ROTA_EDITAR_ANUNCIO:
      //   return MaterialPageRoute(
      //     builder: (_) => EditarAnuncio(idAnuncio: args),
      //   );
      //   case ROTA_DETALHES_ANUNCIO:
      //   return MaterialPageRoute(
      //     builder: (_) => DetalhesAnuncio(args),
      //   );
      default:
        return _errorRota();
    }
  }

  static Route<dynamic> _errorRota() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Tela não encontrada"),
          ),
          body: const Center(
            child: Text(
              "Tela não encontrada",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
