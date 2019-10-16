class Talhao {

  int id;
  String identificadorDoTalhao;
  String cultura;
  double tamanhoDoTalhao;
  int fazendaId;

  Talhao(this.identificadorDoTalhao,this.cultura, this.tamanhoDoTalhao, this.fazendaId);

  Talhao.map(dynamic obj) {  
    this.identificadorDoTalhao = obj['identificadorDoTalhao'];
    this.cultura               = obj['cultura'];
    this.id                    = obj['id'];
    this.tamanhoDoTalhao       = obj['tamanhoDoTalhao'];
    this.fazendaId             = obj['fazendaId'];
  } 

   @override
  String toString() {
    return 'Talhao{id: $id, identificadorDoTalhao: $identificadorDoTalhao, cultura: $cultura}, tamanhoDoTalhao: $tamanhoDoTalhao}, fazendaId: $fazendaId';
  }
   Map<String, dynamic> toMap() {

    var mapa = new Map<String, dynamic>();

    mapa["fazendaId"]             = fazendaId;
    mapa["tamanhoDoTalhao"]       = tamanhoDoTalhao;
    mapa["cultura"]               = cultura;
    mapa["identificadorDoTalhao"] = identificadorDoTalhao;

    if (id != null){
      mapa["id"] = id;
    }
    return mapa;
 }

   Talhao.fromMap(Map<String, dynamic> mapa) {
    this.fazendaId             = mapa['fazendaId'];
    this.tamanhoDoTalhao       = mapa['tamanhoDoTalhao'];
    this.cultura               = mapa['cultura'];
    this.identificadorDoTalhao = mapa['identificadorDoTalhao'];
    this.id                    = mapa['id'];
  }

  Talhao.fromObject(dynamic obj) {
    this.fazendaId             = obj['fazendaId'];
    this.tamanhoDoTalhao       = obj['tamanhoDoTalhao'];
    this.cultura               = obj['cultura'];
    this.identificadorDoTalhao = obj['identificadorDoTalhao'];
    this.id                    = obj['id'];
  }

}