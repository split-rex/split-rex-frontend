
// contoh
class SignUpModel {
  String name;
  String username;
  String email;
  String pass;
  String confPass;
  
  SignUpModel({
    this.name = "",
    this.username = "",
    this.email = "",
    this.pass = "",
    this.confPass = ""
  });
}

class SignInModel {
  String email;
  String pass;
  
  SignInModel({
    this.email = "",
    this.pass = "",
  });

  // factory SignInModel.fromJson(Map<String, dynamic> json){
  //   return SignUpModel(
  //     name: json['name'], 
  //     username: json['username'], 
  //     email: json['email'], 
  //     pass: json['pass'], 
  //     confPass: json['confPass']
  //   );
  // }
}
