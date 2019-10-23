class Valor {
  
  String periodo;
  String id;
  String userId;
  List<dynamic> valores;
  String etapaId;
  bool excluido;

  Valor();

   Map<String, dynamic> toMap() {

    var mapa = new Map<String, dynamic>();

    mapa["valores"]  = valores;
    mapa["userId"]   = userId;
    mapa["etapaId"]  = etapaId;
    mapa["periodo"]  = periodo;
    mapa["excluido"] = excluido;

    if (id != null){ 
      mapa["id"] = id;
    }
    return mapa;
  }

  Valor fromMap(Map<String, dynamic> mapa) {
    
    Valor valor = new Valor();

    valor.valores  = mapa['valores'];
    valor.id       = mapa['id'];
    valor.userId   = mapa["userId"];
    valor.periodo  = mapa["periodo"];
    valor.etapaId  = mapa["etapaId"];
    valor.excluido = mapa["excluido"];
    return valor;
  }
}