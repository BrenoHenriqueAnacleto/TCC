class Usuario {

  String senha;
  String id;
  String nome;
  String email;
  String telefone;
  String aplicativoId;
  String confirmarSenha;
  bool administrador;
  bool superUsuario;
  bool excluido;

  Usuario();

  Usuario.map(dynamic obj) {  
    this.nome     = obj['nome'];
    this.telefone = obj['telefone'];
    this.senha    = obj['senha'];
    this.email    = obj['email'];
    this.id       = obj['id'];
  } 

  @override
  String toString() {
    return 'Usuario{id: $id, nome: $nome, telefone: $telefone, senha: $senha, email:$email}';
  }

  Map<String, dynamic> toMap() {

    var mapa = new Map<String, dynamic>();

    mapa["nome"]     = nome;
    mapa["telefone"] = telefone;
    mapa["senha"]    = senha;
    mapa["email"]    = email;

    if (id != null){
      mapa["id"] = id;
    }
    return mapa;
  }

   Usuario.fromMap(Map<String, dynamic> mapa) {
    this.nome     = mapa['nome'];
    this.id       = mapa['id'];
    this.telefone = mapa['telefone'];
    this.email    = mapa['email'];
    this.senha    = mapa['senha'];
  }

  Usuario.fromObject(dynamic obj) {
    this.id       = obj["id"];
    this.nome     = obj["nome"];
    this.telefone = obj["telefone"];
    this.email    = obj["email"];
    this.senha    = obj["senha"];
  }

   Usuario novo(Map<String, dynamic> mapa) {

    Usuario usuario = new Usuario();

      usuario.nome           = mapa['nome'];
      usuario.id             = mapa['id'];
      usuario.confirmarSenha = mapa['confirmarSenha'];
      usuario.email          = mapa['email'];
      usuario.senha          = mapa['senha'];
      usuario.telefone       = mapa['telefone'];
      usuario.aplicativoId   = mapa['aplicativoId'];
      usuario.administrador  = mapa['administrador'];
      usuario.superUsuario   = mapa['superUsuario'];
      usuario.excluido       = mapa['excluido'];

    return usuario;
  }
}