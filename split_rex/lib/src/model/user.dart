class User {
  String userId;
  String name;
  String username;
  // String email;
  int color;
  
  User({
    this.userId = "",
    this.name = "",
    this.username = "",
    // this.email = "",
    this.color = 0
  });
}

class UserUpdate {
  int color;
  String name;
  
  UserUpdate({
    this.color = 1,
    this.name = "",
  });
}

class UserUpdatePass {
  String oldPass;
  String newPass;
  String confNewPass;
  
  UserUpdatePass({
    this.oldPass = "",
    this.newPass = "",
    this.confNewPass = "",
  });
}