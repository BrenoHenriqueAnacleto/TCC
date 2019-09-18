'use strict';
var path = require('path');
var app = require('../server');
var loopback = require('loopback');
module.exports = function(Etapa) {

    Etapa.remoteMethod('etapas',{
        returns:{arg:'resp',type:'object'},
        http:{path:'/etapas',verb:'get'}
    });

    Etapa.etapas = function (cb) {

        let where = {"excluido":false};

        Etapa.find({"where":where}, function(err, user){
            if(!err) {
                cb(null,user);
            } else {
                cb(err,null);
            }
        });
    }
};
