'use strict';

module.exports = function(Valoresvariaveisusuario) {

/**
 * Retorna todos os valores de acordo com o id do usuario e o id da etapa
 * @param {string} usuarioId O id do usuario que fez a requisição
 * @param {string} etapaId A etapa que será utilizada na listagem
 * @param {Function(Error, array)} callback
 */
Valoresvariaveisusuario.remoteMethod('listagemValoresEtapaUsuario',{
    returns:{arg:'resp',type:'object'},
    http:{path:'/listagemValoresEtapaUsuario',verb:'get'}
});
 
Valoresvariaveisusuario.listagemValoresEtapaUsuario = function(usuarioId, etapaId, callback) {

        let where = {"etapaId":etapaId,"usuarioId":usuarioId,"excluido":false};

        Valoresvariaveisusuario.find({"where":where}, function(err, valores){

            if(!err) {
                callback(null,valores);
            } else {
                callback(err,null);
            }
        });
  };

    /**
     * Exclusão logica do valor
     * @param {string} idValor O id do valor que será "excluido"
     * @param {Function(Error, string)} callback
     */
    Valoresvariaveisusuario.remoteMethod('exclusaoValor',{
        returns:{arg:'resp',type:'object'},
        http:{path:'/exclusaoValor',verb:'delete'}
    });

    Valoresvariaveisusuario.exclusaoValor = function(idValor, callback) {
        var msg;
        msg = 'Valor excluído com sucesso.';
        Valoresvariaveisusuario.findById(idValor,function (err,valor) {

            if (!err && valor != null) {

                valor.excluido = true;
                Valoresvariaveisusuario.upsert(valor, function(err, user){
                    if (!err) {
                        callback(null, msg, err);
                    } else {
                        callback(null, 'Ocorreu um erro ao excluir o valor.', err);
                    }
                });
            } else {
                callback(null, 'Valor não encontrado.');
            }
        });
      };
     
};
