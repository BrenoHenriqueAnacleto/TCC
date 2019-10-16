import 'package:flutter/material.dart';
import 'package:agroquality/models/usuarioModel.dart';

class UsuarioForm extends StatefulWidget {

  final Usuario usuario;
  UsuarioForm(this.usuario);

  @override
  State<StatefulWidget> createState() => UsuarioFormState(usuario);
}

class UsuarioFormState extends State {

  Usuario usuario;

  TextEditingController nomeController     = TextEditingController();
  TextEditingController senhaController    = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController emailController    = TextEditingController();

  UsuarioFormState(Usuario usuario) {
    this.usuario  = usuario;
  }

  @override
  Widget build(BuildContext context) {
   
      nomeController.text     =  (usuario.nome?.isEmpty ?? true) ? "" : usuario.nome.toString();
      senhaController.text    =  (usuario.senha?.isEmpty ?? true) ? "" : usuario.senha.toString();
      telefoneController.text =  (usuario.telefone?.isEmpty ?? true) ? "" : usuario.telefone.toString();
      emailController.text    = (usuario.email?.isEmpty ?? true) ? "" : usuario.email.toString();


      return Scaffold(
          appBar: AppBar(
            title: Text('Cadastro'),
            leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              semanticLabel: 'voltar',
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          ),
          body:  Padding(
            padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                   Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 15.0),
                    child:TextField(
                      controller: nomeController,
                      onChanged: (value) => this.updateNome(),
                      decoration: InputDecoration(
                          labelText: "Nome",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      )
                    ),
                   Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 15.0),
                    child:TextField(
                      controller: emailController,
                      onChanged: (value) => this.updateEmail(),
                      decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    )
                   ),
                   Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 15.0),
                    child:TextField(
                      controller: telefoneController,
                      onChanged: (value) => this.updateTelefone(),
                      decoration: InputDecoration(
                          labelText: "Telefone",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    )
                   ),
                  Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 15.0),
                    child:TextField(
                      controller: senhaController,
                      onChanged: (value) => this.updateSenha(),
                      decoration: InputDecoration(
                        labelText: "Senha",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                        obscureText: true,
                    )
                    ),  
                    Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                            this.save();
                      },
                      child: Text('Salvar'),
                      ),
                    ),
                  ],
                )
              ],
            )
          )
        );
  }

  void save() {

    Navigator.pop(context, true);
  }

  void updateNome() {
    usuario.nome = nomeController.text;
  }

  void updateEmail() {
    usuario.email = emailController.text;
  }

  void updateTelefone() {
    usuario.telefone = telefoneController.text;
  }

  void updateSenha() {
    usuario.senha = senhaController.text;
  }
}