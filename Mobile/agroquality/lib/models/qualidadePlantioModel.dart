import 'package:agroquality/models/plantioModel.dart';

class QualidadePlantio {

  int id;
  double qualidadeVelocidade;
  double qualidadeProfundidade;
  double qualidadePopulacao;
  double qualidadeCov;
  int idVariavelPlantio;

  QualidadePlantio(this.qualidadeVelocidade,this.qualidadeProfundidade, this.qualidadePopulacao, this.qualidadeCov, this.idVariavelPlantio);

  QualidadePlantio.map(dynamic obj) {  
    this.qualidadeVelocidade   = obj['qualidadeVelocidade'];
    this.qualidadeProfundidade = obj['qualidadeProfundidade'];
    this.id                    = obj['id'];
    this.qualidadeCov          = obj['qualidadeCov'];
    this.qualidadePopulacao    = obj['qualidadePopulacao'];
    this.idVariavelPlantio     = obj['idVariavelPlantio'];
  } 

   @override
  String toString() {
    return 'QualidadePlantio{id: $id, qualidadeVelocidade: $qualidadeVelocidade, qualidadeProfundidade: $qualidadeProfundidade}, qualidadePopulacao: $qualidadePopulacao}, idVariavelPlantio: $idVariavelPlantio';
  }
   Map<String, dynamic> toMap() {

    var mapa = new Map<String, dynamic>();

    mapa["idVariavelPlantio"]     = idVariavelPlantio;
    mapa["qualidadePopulacao"]    = qualidadePopulacao;
    mapa["qualidadeProfundidade"] = qualidadeProfundidade;
    mapa["qualidadeCov"]          = qualidadeCov;
    mapa["qualidadeVelocidade"]   = qualidadeVelocidade;

    if (id != null){
      mapa["id"] = id;
    }
    return mapa;
 }

   QualidadePlantio.fromMap(Map<String, dynamic> mapa) {
    this.idVariavelPlantio     = mapa['idVariavelPlantio'];
    this.qualidadePopulacao    = mapa['qualidadePopulacao'];
    this.qualidadeProfundidade = mapa['qualidadeProfundidade'];
    this.qualidadeVelocidade   = mapa['qualidadeVelocidade'];
    this.qualidadeCov          = mapa['qualidadeCov'];
    this.id                    = mapa['id'];
  }

  QualidadePlantio.fromObject(dynamic obj) {
    this.idVariavelPlantio     = obj['idVariavelPlantio'];
    this.qualidadePopulacao    = obj['qualidadePopulacao'];
    this.qualidadeProfundidade = obj['qualidadeProfundidade'];
    this.qualidadeVelocidade   = obj['qualidadeVelocidade'];
    this.qualidadeCov          = obj['qualidadeCov'];
    this.id                    = obj['id'];
  }

  QualidadePlantio.gerarQualidadeColheita(Plantio plantio) {
    this.idVariavelPlantio     = plantio.id;
    this.qualidadePopulacao    = this.intervaloQualidade(plantio.populacao);
    this.qualidadeProfundidade = this.intervaloQualidade(plantio.profundidade);
    this.qualidadeVelocidade   = this.intervaloQualidade(plantio.velocidade);
    this.qualidadeCov          = this.intervaloQualidade(plantio.cov);
  }

  double intervaloQualidade(double valor) {

    var qualidade  = 100 * valor / 100;
    return qualidade;
  }
}