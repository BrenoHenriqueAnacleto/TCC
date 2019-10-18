class Etapa {
  
  String nome;
  String id;

  Etapa();

   Map<String, dynamic> toMap() {

    var mapa = new Map<String, dynamic>();

    mapa["nome"] = nome;

    if (id != null){
      mapa["id"] = id;
    }
    return mapa;
  }

  Etapa fromMap(Map<String, dynamic> mapa) {
    
    Etapa etapa = new Etapa();

    etapa.nome          = mapa['nome'];
    etapa.id            = mapa['id'];
    return etapa;
  }
}