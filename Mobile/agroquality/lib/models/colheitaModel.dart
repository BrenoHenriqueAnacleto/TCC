class Colheita {

  int id;
  double velocidade;
  double perdaDeGraos;
  double impurezaDeGraos;
  double produtividade;
  double umidadeDeGraos;
  double tamanhoDaPlataforma;
  int talhaoId;

  Colheita(this.velocidade,this.perdaDeGraos, this.impurezaDeGraos,this.produtividade,this.umidadeDeGraos, this.tamanhoDaPlataforma, this.talhaoId);

  Colheita.map(dynamic obj) {  
    this.velocidade          = obj['velocidade'];
    this.perdaDeGraos        = obj['perdaDeGraos'];
    this.id                  = obj['id'];
    this.produtividade       = obj['produtividade'];
    this.impurezaDeGraos     = obj['impurezaDeGraos'];
    this.umidadeDeGraos      = obj['umidadeDeGraos'];
    this.tamanhoDaPlataforma = obj['tamanhoDaPlataforma'];
    this.talhaoId            = obj['talhaoId'];
  } 

   @override
  String toString() {
    return 'Colheita{id: $id, velocidade: $velocidade, perdaDeGraos: $perdaDeGraos}, impurezaDeGraos: $impurezaDeGraos}, talhaoId: $talhaoId';
  }
   Map<String, dynamic> toMap() {

    var mapa = new Map<String, dynamic>();

    mapa["talhaoId"]            = talhaoId;
    mapa["impurezaDeGraos"]     = impurezaDeGraos;
    mapa["perdaDeGraos"]        = perdaDeGraos;
    mapa["produtividade"]       = produtividade;
    mapa["velocidade"]          = velocidade;
    mapa["umidadeDeGraos"]      = umidadeDeGraos;
    mapa["tamanhoDaPlataforma"] = tamanhoDaPlataforma;

    if (id != null){
      mapa["id"] = id;
    }
    return mapa;
 }

   Colheita.fromMap(Map<String, dynamic> mapa) {
    this.talhaoId             = mapa['talhaoId'];
    this.impurezaDeGraos      = mapa['impurezaDeGraos'];
    this.perdaDeGraos         = mapa['perdaDeGraos'];
    this.velocidade           = mapa['velocidade'];
    this.produtividade        = mapa['produtividade'];
    this.tamanhoDaPlataforma  = mapa['tamanhoDaPlataforma'];
    this.umidadeDeGraos       = mapa['umidadeDeGraos'];
    this.id                   = mapa['id'];
  }

  Colheita.fromObject(dynamic obj) {
    this.talhaoId            = obj['talhaoId'];
    this.impurezaDeGraos     = obj['impurezaDeGraos'];
    this.perdaDeGraos        = obj['perdaDeGraos'];
    this.velocidade          = obj['velocidade'];
    this.produtividade       = obj['produtividade'];
    this.umidadeDeGraos      = obj['umidadeDeGraos'];
    this.tamanhoDaPlataforma = obj['tamanhoDaPlataforma'];
    this.id                  = obj['id'];
  }

}