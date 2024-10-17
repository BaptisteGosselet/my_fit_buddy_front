class LoginForm {
  final String usernameOrEmail;
  final String password;

  LoginForm({
    required this.usernameOrEmail,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'usernameOrEmail': usernameOrEmail,
      'password': password,
    };
  }
}
