import 'colheitaModel.dart';

class QualidadeColheita {

  int id;
  double qualidadeVelocidade;
  double qualidadePerdaDeGraos;
  double qualidadeImpurezaDeGraos;
  double qualidadeProdutividade;
  double qualidadeUmidadeDeGraos;
  double qualidadeTamanhoDaPlataforma;
  int idVariavelColheita;

  QualidadeColheita(this.qualidadeVelocidade,this.qualidadePerdaDeGraos, this.qualidadeImpurezaDeGraos,this.qualidadeProdutividade,this.qualidadeUmidadeDeGraos, this.qualidadeTamanhoDaPlataforma, this.idVariavelColheita);

  QualidadeColheita.map(dynamic obj) {  
    this.qualidadeVelocidade          = obj['qualidadeVelocidade'];
    this.qualidadePerdaDeGraos        = obj['qualidadePerdaDeGraos'];
    this.id                           = obj['id'];
    this.qualidadeProdutividade       = obj['qualidadeProdutividade'];
    this.qualidadeImpurezaDeGraos     = obj['qualidadeImpurezaDeGraos'];
    this.qualidadeUmidadeDeGraos      = obj['qualidadeUmidadeDeGraos'];
    this.qualidadeTamanhoDaPlataforma = obj['qualidadeTamanhoDaPlataforma'];
    this.idVariavelColheita           = obj['idVariavelColheita'];
  } 

   @override
  String toString() {
    return 'QualidadeColheita{id: $id, qualidadeVelocidade: $qualidadeVelocidade, qualidadePerdaDeGraos: $qualidadePerdaDeGraos}, qualidadeImpurezaDeGraos: $qualidadeImpurezaDeGraos}, idVariavelColheita: $idVariavelColheita';
  }
   Map<String, dynamic> toMap() {

    var mapa = new Map<String, dynamic>();

    mapa["idVariavelColheita"]           = idVariavelColheita;
    mapa["qualidadeImpurezaDeGraos"]     = qualidadeImpurezaDeGraos;
    mapa["qualidadePerdaDeGraos"]        = qualidadePerdaDeGraos;
    mapa["qualidadeProdutividade"]       = qualidadeProdutividade;
    mapa["qualidadeVelocidade"]          = qualidadeVelocidade;
    mapa["qualidadeUmidadeDeGraos"]      = qualidadeUmidadeDeGraos;
    mapa["qualidadeTamanhoDaPlataforma"] = qualidadeTamanhoDaPlataforma;

    if (id != null){
      mapa["id"] = id;
    }
    return mapa;
 }

   QualidadeColheita.fromMap(Map<String, dynamic> mapa) {
    this.idVariavelColheita            = mapa['idVariavelColheita'];
    this.qualidadeImpurezaDeGraos      = mapa['qualidadeImpurezaDeGraos'];
    this.qualidadePerdaDeGraos         = mapa['qualidadePerdaDeGraos'];
    this.qualidadeVelocidade           = mapa['qualidadeVelocidade'];
    this.qualidadeProdutividade        = mapa['qualidadeProdutividade'];
    this.qualidadeTamanhoDaPlataforma  = mapa['qualidadeTamanhoDaPlataforma'];
    this.qualidadeUmidadeDeGraos       = mapa['qualidadeUmidadeDeGraos'];
    this.id                            = mapa['id'];
  }

  QualidadeColheita.fromObject(dynamic obj) {
    this.idVariavelColheita           = obj['idVariavelColheita'];
    this.qualidadeImpurezaDeGraos     = obj['qualidadeImpurezaDeGraos'];
    this.qualidadePerdaDeGraos        = obj['qualidadePerdaDeGraos'];
    this.qualidadeVelocidade          = obj['qualidadeVelocidade'];
    this.qualidadeProdutividade       = obj['qualidadeProdutividade'];
    this.qualidadeUmidadeDeGraos      = obj['qualidadeUmidadeDeGraos'];
    this.qualidadeTamanhoDaPlataforma = obj['qualidadeTamanhoDaPlataforma'];
    this.id                           = obj['id'];
  }

  QualidadeColheita.gerarQualidadeColheita(Colheita colheita) {
    this.idVariavelColheita           = colheita.id;
    this.qualidadeImpurezaDeGraos     = this.intervaloQualidade(colheita.impurezaDeGraos);
    this.qualidadePerdaDeGraos        = this.intervaloQualidade(colheita.perdaDeGraos);
    this.qualidadeTamanhoDaPlataforma = this.intervaloQualidade(colheita.tamanhoDaPlataforma);
    this.qualidadeUmidadeDeGraos      = this.intervaloQualidade(colheita.umidadeDeGraos);
    this.qualidadeVelocidade          = this.intervaloQualidade(colheita.velocidade);
  }

  double intervaloQualidade(double valor) {

    var qualidade  = 100 * valor / 100;
    return qualidade;
  }

}