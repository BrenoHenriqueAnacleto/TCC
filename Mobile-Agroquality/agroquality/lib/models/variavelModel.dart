class Variavel {
  
  String title;
  String id;
  String placeholder;
  String valorDefault;
  String tipoDoCampo;
  String obrigatorio;
  List<dynamic> validacoes;
  String etapaId;

  Variavel();

   Map<String, dynamic> toMap() {

    var mapa = new Map<String, dynamic>();

    mapa["title"]        = title;
    mapa["placeholder"]  = placeholder;
    mapa["valorDefault"] = valorDefault;
    mapa["obrigatorio"]  = obrigatorio;
    mapa["etapaId"]      = etapaId;
    mapa["validacoes"]   = validacoes;

    if (id != null){ 
      mapa["id"] = id;
    }
    return mapa;
  }

  Variavel fromMap(Map<String, dynamic> mapa) {
    
    Variavel etapa = new Variavel();

    etapa.title        = mapa['title'];
    etapa.id           = mapa['id'];
    etapa.placeholder  = mapa["placeholder"];
    etapa.valorDefault = mapa["valorDefault"];
    etapa.obrigatorio  = mapa["obrigatorio"];
    etapa.etapaId      = mapa["etapaId"];
    etapa.validacoes   = mapa["validacoes"];
    return etapa;
  }
}