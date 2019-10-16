class Fazenda {
  String nome;
  double areaDaFazenda;
  int id;

  Fazenda(this.nome, this.areaDaFazenda);

  Fazenda.map(dynamic obj) {  
    this.nome          = obj['nome'];
    this.areaDaFazenda = obj['areaDaFazenda'];
    this.id            = obj['id'];
  } 

  @override
  String toString() {
    return 'Fazenda{id: $id, nome: $nome, areaDaFazenda: $areaDaFazenda}';
  }
   Map<String, dynamic> toMap() {

    var mapa = new Map<String, dynamic>();

    mapa["nome"] = nome;
    mapa["areaDaFazenda"] = areaDaFazenda;

    if (id != null){
      mapa["id"] = id;
    }
    return mapa;
 }

   Fazenda.fromMap(Map<String, dynamic> mapa) {
    this.nome          = mapa['nome'];
    this.id            = mapa['id'];
    this.areaDaFazenda = mapa['areaDaFazenda'];
  }

  Fazenda.fromObject(dynamic obj) {
    this.id            = obj["id"];
    this.nome          = obj["nome"];
    this.areaDaFazenda = obj["areaDaFazenda"];
  }
}