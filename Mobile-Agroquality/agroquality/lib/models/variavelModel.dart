class Variavel {
  
  String nome;
  String id;

  Variavel();

   Map<String, dynamic> toMap() {

    var mapa = new Map<String, dynamic>();

    mapa["nome"] = nome;

    if (id != null){ 
      mapa["id"] = id;
    }
    return mapa;
  }

  Variavel fromMap(Map<String, dynamic> mapa) {
    
    Variavel etapa = new Variavel();

    etapa.nome          = mapa['nome'];
    etapa.id            = mapa['id'];
    return etapa;
  }
}