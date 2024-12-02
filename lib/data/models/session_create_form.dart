class SessionCreateForm {
  final String name;

  SessionCreateForm({
    required this.name,
  });

   Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
