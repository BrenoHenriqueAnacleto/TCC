class QualidadePulverizacao {

  int id;
  String qualidadeTipoDeBicoAplicado;
  double qualidadeVelocidade;
  double qualidadeVazao;
  int idVariavelPulverizacao;

  QualidadePulverizacao(this.qualidadeVelocidade,this.qualidadeTipoDeBicoAplicado, this.qualidadeVazao, this.idVariavelPulverizacao);

  QualidadePulverizacao.map(dynamic obj) {  
    this.qualidadeVelocidade         = obj['qualidadeVelocidade'];
    this.qualidadeTipoDeBicoAplicado = obj['qualidadeTipoDeBicoAplicado'];
    this.id                          = obj['id'];
    this.qualidadeVazao              = obj['qualidadeVazao'];
    this.idVariavelPulverizacao      = obj['idVariavelPulverizacao'];
  } 

   @override
  String toString() {
    return 'QualidadePulverizacao{id: $id, qualidadeVelocidade: $qualidadeVelocidade, qualidadeTipoDeBicoAplicado: $qualidadeTipoDeBicoAplicado, idVariavelPulverizacao: $idVariavelPulverizacao}';
  }
   Map<String, dynamic> toMap() {

    var mapa = new Map<String, dynamic>();

    mapa["idVariavelPulverizacao"]      = idVariavelPulverizacao;
    mapa["qualidadeTipoDeBicoAplicado"] = qualidadeTipoDeBicoAplicado;
    mapa["qualidadeVazao"]              = qualidadeVazao;
    mapa["qualidadeVelocidade"]         = qualidadeVelocidade;

    if (id != null){
      mapa["id"] = id;
    }
    return mapa;
 }

   QualidadePulverizacao.fromMap(Map<String, dynamic> mapa) {
    this.idVariavelPulverizacao      = mapa['idVariavelPulverizacao'];
    this.qualidadeTipoDeBicoAplicado = mapa['qualidadeTipoDeBicoAplicado'];
    this.qualidadeVelocidade         = mapa['qualidadeVelocidade'];
    this.qualidadeVazao              = mapa['qualidadeVazao'];
    this.id                          = mapa['id'];
  }

  QualidadePulverizacao.fromObject(dynamic obj) {
    this.idVariavelPulverizacao      = obj['idVariavelPulverizacao'];
    this.qualidadeTipoDeBicoAplicado = obj['qualidadeTipoDeBicoAplicado'];
    this.qualidadeVelocidade         = obj['qualidadeVelocidade'];
    this.qualidadeVazao              = obj['qualidadeVazao'];
    this.id                          = obj['id'];
  }

}