class EditUserForm {
  final String username;
  final String email;

  EditUserForm({
    required this.username,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
    };
  }
}
