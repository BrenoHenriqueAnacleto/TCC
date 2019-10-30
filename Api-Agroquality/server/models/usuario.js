'use strict';

var path = require('path');
var app = require('../server');
var loopback = require('loopback');

var frontendUrl = 'http://localhost:4200';
var backEndUrl  = 'http://192.168.0.107:3000';

module.exports = function(Usuario) {

    Usuario.beforeRemote('findById',function(req,res,next){
        next();
    });
/*
    Usuario.beforeRemote('create',function(context,user,next){
        context.args.data.role = "owner";
        next();
    });

    Usuario.afterRemote('create',function(context,user,next){
        var verifyLink = backEndUrl + '/api/usuarios/confirm?uid=' + user.id + '&redirect=' + frontendUrl; 
        var options    = {
            type: 'email',
            to: user.email,
            from: 'sistema.agroquality@gmail.com',
            subject:'Obrigado por se cadastrar',
            host: '192.168.0.107',
            template: path.resolve(__dirname,'../boot/views/verify.ejs'),
            user:user,
            verifyHref: verifyLink
        }

        user.verify(options,function(err,response){
            if(err){
                Usuario.deleteById(user.id);
                return next(err);
            }

            Usuario.upsert(result,function(err,user){});
                
            next();
        });
    }); */

    Usuario.beforeRemote('login', function(req, res, next){
        req.args.filter = {"include":"usuario"};
        next();
    }); 

    function generateVerificationToken(user,callback){
        app.models.User.generateVerificationToken(user,{},function(err,res){
            if(err)
                return callback(err,null);
            callback(null,res);
            
        });
    }

    Usuario.on('resetPasswordRequest',function (email, cb) {
       Usuario.findById(email.user.id,function(err,result){
            generateVerificationToken(result,function (error,token) {
                result.verificationToken = token;
                Usuario.upsert(result,function (err, user) {
                    var encrypt_token = '' + user.verificationToken + '&uid=' + user.id;
                    var verifyHref = 'http://localhost:4200/resetPassword' + '?token=' + encrypt_token;
                    var redirectLink = 'http://localhost:4200/resetPassword';
                    var message = {
                        username: email.user.username,
                        verifyHref:verifyHref
                    };
                    var renderer = loopback.template(path.resolve(__dirname,'../boot/views/forgetPassword.ejs'));
                    var html = renderer(message);
                    if(email.user){
                        var options = {
                            type:'email',
                            to:email.email,
                            from: 'sistema.agroquality@gmail.com',
                            subject:'Redefinir senha',
                            redirect:redirectLink,
                            html:html
                        }

                        Usuario.app.models.Email.send(options, function(err, response){
                            if(err){
                                return err;
                            }
                        });
                    }
                })
            });
       });
    });

    Usuario.afterRemote('login',function(ctx,res,next){

        Usuario.findById(ctx.result.userId, function(err,result){
            if(err == null){
                var rJson = result.toJSON();
                res.responseCode = 200;
                if (rJson.emailVerified){
                    res.emailVerified = true;
                } else {
                    res.emailVerified = false;
                }
                res.role              = rJson.role;
                res.username          = rJson.username;
                res.verificationToken = rJson.verificationToken;
                if (typeof(rJson.role) !== 'undefined' && rJson.role == 'owner'){
                    res.role = rJson.role;
                }
                next();
            }
        });
    });

    /**
     * Administrador
     */

    Usuario.remoteMethod('administrador',{
        accepts:[{arg:'id', type:'string'}],
        returns:{arg:'resp',type:'object'},
        http:{path:'/administrador',verb:'get'}
    });

    Usuario.administrador = function (id,cb) {

        Usuario.findById(id,function (err,user) {
            if(err){
                cb(err,null);
            }
            if(user !== null && user !== undefined){
                cb(null,user);
            } else {
                cb(null,{message:"Administrador não encontrado",status: 404});
            }
        });
    }

    Usuario.remoteMethod('administradores',{
        returns:{arg:'resp',type:'object'},
        http:{path:'/administradores',verb:'get'}
    });

    Usuario.administradores = function (cb) {

        let where = {"administrador":true,"superUsuario":false,"excluido":false};

        Usuario.find({"where":where}, function(err, user){
            if(!err) {
                cb(null,user);
            } else {
                cb(err,null);
            }
        });
    }

    /**
     * Adiciona um novo usuario
     * @param {object} data São os dados do administrador
     * @param {Function(Error, string, any)} callback
     */

    Usuario.novoAdministrador = function(data, callback) {
        var msg, err;
        let administrador = data.req.body;
        if (administrador.administrador == true && administrador.superUsuario == true) {

            administrador.role = 'superUsuario';
        } else if(administrador.administrador == true && administrador.superUsuario == false) {

            administrador.role = 'administrador';
        } else {

            administrador.role = 'usuario';
        }

        if (administrador.id) {

            msg = 'Administrador editado com sucesso.'
        } else {

            msg = 'Administrador cadastrado com sucesso.'
        }
        
        Usuario.upsert(administrador, function(err, user){
            if(!err){
                callback(null, msg, err);
            } else {
                callback(null, 'Ocorreu um erro.', err);
            }
        });

    };
    
    /**
     * Realiza a exclusão lógica do admnistrador
     * @param {string} id Id do administrador
     * @param {Function(Error, string)} callback
     */

    Usuario.removerAdministrador = function(id, callback) {
        var msg;
        msg = 'Administrador excluido com sucesso.';
        Usuario.findById(id,function (err,administrador) {

            if (!err && administrador != null) {

                administrador.excluido = true;
                Usuario.upsert(administrador, function(err, user){
                    if (!err) {
                        callback(null, msg, err);
                    } else {
                        callback(null, 'Ocorreu um erro ao excluir o administrador.', err);
                    }
                });
            } else {
                callback(null, 'Administrador não encontrado.');
            }
        });
    };

    /**
     * SuperUsuario
     */Usuario.remoteMethod('superusuario',{
        accepts:[{arg:'id', type:'string'}],
        returns:{arg:'resp',type:'object'},
        http:{path:'/superusuario',verb:'get'}
    });

    Usuario.superusuario = function (id,cb) {

        Usuario.findById(id,function (err,user) {
            if(err){
                cb(err,null);
            }
            if(user !== null && user !== undefined){
                cb(null,user);
            } else {
                cb(null,{message:"Super usuario não encontrado",status: 404});
            }
        });
    }

    Usuario.remoteMethod('superusuarios',{
        returns:{arg:'resp',type:'object'},
        http:{path:'/superusuarios',verb:'get'}
    });

    Usuario.superusuarios = function (cb) {

        let where = {"administrador":true,"superUsuario":true,"excluido":false};

        Usuario.find({"where":where}, function(err, user){
            if(!err) {
                cb(null,user);
            } else {
                cb(err,null);
            }
        });
    }

    /**
     * Adiciona um novo usuario
     * @param {object} data São os dados do super usuario
     * @param {Function(Error, string, any)} callback
     */

    Usuario.novoSuperUsuario = function(data, callback) {
        var msg, err;
        let superUsuario = data.req.body;
        if (superUsuario.administrador == true && superUsuario.superUsuario == true) {

            superUsuario.role = 'superUsuario';
        } else if(superUsuario.administrador == true && superUsuario.superUsuario == false) {

            superUsuario.role = 'administrador';
        } else {

            superUsuario.role = 'usuario';
        }

        if (superUsuario.id) {

            msg = 'Super usuario editado com sucesso.'
        } else {

            msg = 'Super usuario cadastrado com sucesso.'
        }
        
        Usuario.upsert(superUsuario, function(err, user){
            if(!err){
                callback(null, msg, err);
            } else {
                callback(null, 'Ocorreu um erro.', err);
            }
        });

    };
    
    /**
     * Realiza a exclusão lógica do super usuario
     * @param {string} id Id do super usuario
     * @param {Function(Error, string)} callback
     */

    Usuario.removerSuperUsuario = function(id, callback) {
        var msg;
        msg = 'Super usuario excluido com sucesso.';
        Usuario.findById(id,function (err,superUsuario) {

            if (!err && superUsuario != null) {

                superUsuario.excluido = true;
                Usuario.upsert(superUsuario, function(err, user){
                    if (!err) {
                        callback(null, msg, err);
                    } else {
                        callback(null, 'Ocorreu um erro ao excluir o super usuario.', err);
                    }
                });
            } else {
                callback(null, 'Super usuario não encontrado.');
            }
        });
    };


    Usuario.remoteMethod('updateForgetPassword',{
        accepts:[{arg:'user', type:'object'}],
        returns:{arg:'resp',type:'object'},
        http:{path:'/updateForgetPassword',verb:'post'}
    });

    Usuario.updateForgetPassword = function (user, cb) {
        var uid      = user.data.id;
        var token    = user.data.token;
        var senha = user.data.senha;
        Usuario.confirm(uid, token).then(function(response){
            Usuario.findById(uid,function (err,user) {
                if(err){
                    cb(err,null);
                }
                if(user !== null && user !== undefined){
                    user.senha = senha;
                    user.save(function (err) {
                        if(err){
                            cb(err,null);
                        } else {
                            cb(null,{message:"Senha redefinida com sucesso", status: 200});
                        }
                    });
                } else {
                    cb(null,{message:"Usuario não encontrado",status: 404});
                }
            });
        },function(err){
            cb(err,null);
        });
    }

    Usuario.beforeRemote('confirm', function(ctx, res, next){
        var redirectLink = 'localhost:4200';
        Usuario.findById(ctx.args.uid,function(err,result){
            if (result.emailVerified) {
                ctx.res.send(
                    '<div align="center">' +
                    '<h1>Este e-mail já foi confirmado</h1>'+
                    '<a href="http://' + redirectLink+ '">Ir para o login</a>'+
                    '</div>'
                );
            } else {
                next();
            }
        });
    });

    Usuario.afterRemote('confirm', function(ctx, res, next){
        ctx.args.status = 'enabled';
        Usuario.findById(ctx.args.uid,function(err,result){
            result.status = 'enabled';
            Usuario.upsert(result,function (err,user) {
                next();
            })
        });
    });

    Usuario.remoteMethod('sendEmail',{
        accepts:[{args:'email',types:'string'}],
        returns: {args:'email',type:'string'},
        http: {path:'/sendEmail',verb:'post'}
    });

    Usuario.sendEmail = function(email,cb){
        Usuario.find({"where":{"email":email}}, function(err, user){
            if(user[0].verificationToken){
                var verifyLink = backEndUrl + '/api/usuarios/confirm?uid=' + user[0].id + '&redirect=' + frontendUrl; 
                var options    = {
                    type: 'email',
                    to: user[0].email,
                    from: 'sistema.agroquality@gmail.com',
                    subject:'Obrigado por se cadastrar',
                    host: 'localhost',
                    template: path.resolve(__dirname,'../boot/views/verify.ejs'),
                    user:user[0],
                    verifyHref: verifyLink
                }
                user[0].verify(options, function (err, response) {
                   if(err) {
                        Usuario.deleteById(user[0].id);
                        return next(err);
                   } 
                   cb(null, response);
                });
            }
        });
    }

    /**
     * Realiza o cadastro no aplicativo
     * @param {any} dados Os dados de cadastro do usuario
     * @param {string} usuarioId Caso o usuario altere os seus dados
     * @param {Function(Error, string)} callback
     */

    Usuario.remoteMethod('cadastroUsuario',{
        accepts:[{arg:'dados', type:'any'}],
        http:{path:'/cadastroUsuario',verb:'post'},
        http:{path:'/cadastroUsuario',verb:'put'}
    });

    Usuario.cadastroUsuario = function(dados, callback) {

        Usuario.upsert(dados.body, function(err, user){
            console.log(err);
            if(!err){
                return callback(null);
            } else {
                var error = new Error();
                error.status = 422;
                error.message = "Dados invalidos";
                return callback(error);
            }
        });
    };

};
