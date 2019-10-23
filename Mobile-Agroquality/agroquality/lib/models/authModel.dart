class Auth {
  String username;
  String role;
  String userId;
  String id;

  Auth();

  map(dynamic obj) {  
    this.username = obj['username'];
    this.userId   = obj['userId'];
    this.role     = obj['role'];
    this.id       = obj['id'];
  } 

  @override
  String toString() {
    return 'Auth{id: $id, username: $username, userId: $userId, role: $role}';
  }

  Map<String, dynamic> toMap() {

    var mapa = new Map<String, dynamic>();

    mapa["username"] = username;
    mapa["userId"]   = userId;
    mapa["role"]     = role;

    if (id != null){
      mapa["id"] = id;
    }
    return mapa;
  }

  fromMap(Map<String, dynamic> mapa) {
    this.username = mapa['username'];
    this.id       = mapa['id'];
    this.userId   = mapa['userId'];
    this.role     = mapa['role'];
  }

  fromObject(dynamic obj) {
    this.id       = obj["id"];
    this.username = obj["username"];
    this.userId   = obj["userId"];
    this.role     = obj["role"];
  }

   Auth novo(Map<String, dynamic> mapa) {

    Auth auth = new Auth();

      auth.username = mapa['username'];
      auth.id       = mapa['id'];
      auth.userId   = mapa['userId'];
      auth.role     = mapa['role'];
    return auth;
  }
}