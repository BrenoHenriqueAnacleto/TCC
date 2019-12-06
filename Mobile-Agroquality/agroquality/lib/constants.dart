const String serverUrl    = 'https://sistema-agroquality.appspot.com';
const String idAplicativo = '5dc468d5b2bff804d4c7c7a9';

Map<String, dynamic> environment() {

  var url = new Map<String, dynamic>();

  url["serverUrl"] = serverUrl;
  url["apiUrl"]    = serverUrl + '/api';
  return url;
}