class Pulverizacao {

  int id;
  String tipoDeBicoAplicado;
  double velocidade;
  double vazao;
  int talhaoId;

  Pulverizacao(this.velocidade,this.tipoDeBicoAplicado, this.vazao, this.talhaoId);

  Pulverizacao.map(dynamic obj) {  
    this.velocidade         = obj['velocidade'];
    this.tipoDeBicoAplicado = obj['tipoDeBicoAplicado'];
    this.id                 = obj['id'];
    this.vazao              = obj['vazao'];
    this.talhaoId           = obj['talhaoId'];
  } 

   @override
  String toString() {
    return 'Pulverizacao{id: $id, velocidade: $velocidade, tipoDeBicoAplicado: $tipoDeBicoAplicado, talhaoId: $talhaoId}';
  }
   Map<String, dynamic> toMap() {

    var mapa = new Map<String, dynamic>();

    mapa["talhaoId"]           = talhaoId;
    mapa["tipoDeBicoAplicado"] = tipoDeBicoAplicado;
    mapa["vazao"]              = vazao;
    mapa["velocidade"]         = velocidade;

    if (id != null){
      mapa["id"] = id;
    }
    return mapa;
 }

   Pulverizacao.fromMap(Map<String, dynamic> mapa) {
    this.talhaoId           = mapa['talhaoId'];
    this.tipoDeBicoAplicado = mapa['tipoDeBicoAplicado'];
    this.velocidade         = mapa['velocidade'];
    this.vazao              = mapa['vazao'];
    this.id                 = mapa['id'];
  }

  Pulverizacao.fromObject(dynamic obj) {
    this.talhaoId           = obj['talhaoId'];
    this.tipoDeBicoAplicado = obj['tipoDeBicoAplicado'];
    this.velocidade         = obj['velocidade'];
    this.vazao              = obj['vazao'];
    this.id                 = obj['id'];
  }

}