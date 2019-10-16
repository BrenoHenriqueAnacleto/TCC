const String serverUrl = 'http://192.168.0.108:3000';

Map<String, dynamic> environment() {

  var url = new Map<String, dynamic>();

  url["serverUrl"] = serverUrl;
  url["apiUrl"]    = serverUrl + '/api';
  return url;
}