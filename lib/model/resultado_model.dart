class ResultadoModel{

  double _litrosGasolina = 0;
  double _litrosAlcool = 0;
  double _kmGasolina = 0;
  double _kmAlcool = 0;
  double _valorAbastecer = 0;
  String _tipoCombustivel = "";
  String _tipoCalculo = "";

  ResultadoModel();

  double get litrosGasolina => _litrosGasolina;

  set litrosGasolina(double value) {
    _litrosGasolina = value;
  }

  double get litrosAlcool => _litrosAlcool;

  String get tipoCalculo => _tipoCalculo;

  set tipoCalculo(String value) {
    _tipoCalculo = value;
  }

  String get tipoCombustivel => _tipoCombustivel;

  set tipoCombustivel(String value) {
    _tipoCombustivel = value;
  }

  double get valorAbastecer => _valorAbastecer;

  set valorAbastecer(double value) {
    _valorAbastecer = value;
  }

  double get kmAlcool => _kmAlcool;

  set kmAlcool(double value) {
    _kmAlcool = value;
  }

  double get kmGasolina => _kmGasolina;

  set kmGasolina(double value) {
    _kmGasolina = value;
  }

  set litrosAlcool(double value) {
    _litrosAlcool = value;
  }
}