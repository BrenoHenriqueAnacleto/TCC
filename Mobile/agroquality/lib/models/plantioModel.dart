class Plantio {

  int id;
  double velocidade;
  double profundidade;
  double populacao;
  double cov;
  int talhaoId;

  Plantio(this.velocidade,this.profundidade, this.populacao, this.cov, this.talhaoId);

  Plantio.map(dynamic obj) {  
    this.velocidade   = obj['velocidade'];
    this.profundidade = obj['profundidade'];
    this.id           = obj['id'];
    this.cov          = obj['cov'];
    this.populacao    = obj['populacao'];
    this.talhaoId     = obj['talhaoId'];
  } 

   @override
  String toString() {
    return 'Plantio{id: $id, velocidade: $velocidade, profundidade: $profundidade}, populacao: $populacao}, talhaoId: $talhaoId';
  }
   Map<String, dynamic> toMap() {

    var mapa = new Map<String, dynamic>();

    mapa["talhaoId"]     = talhaoId;
    mapa["populacao"]    = populacao;
    mapa["profundidade"] = profundidade;
    mapa["cov"]          = cov;
    mapa["velocidade"]   = velocidade;

    if (id != null){
      mapa["id"] = id;
    }
    return mapa;
 }

   Plantio.fromMap(Map<String, dynamic> mapa) {
    this.talhaoId     = mapa['talhaoId'];
    this.populacao    = mapa['populacao'];
    this.profundidade = mapa['profundidade'];
    this.velocidade   = mapa['velocidade'];
    this.cov          = mapa['cov'];
    this.id           = mapa['id'];
  }

  Plantio.fromObject(dynamic obj) {
    this.talhaoId     = obj['talhaoId'];
    this.populacao    = obj['populacao'];
    this.profundidade = obj['profundidade'];
    this.velocidade   = obj['velocidade'];
    this.cov          = obj['cov'];
    this.id           = obj['id'];
  }

}