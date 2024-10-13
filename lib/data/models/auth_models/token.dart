class Token {
  String? accessToken;
  String? refreshToken;
  int? expiresIn;

  Token({
    this.accessToken,
    this.refreshToken,
    this.expiresIn,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accessToken: json['accessToken']?.toString(),
      refreshToken: json['refreshToken']?.toString(),
      expiresIn: json['expiresIn'] is String
          ? int.tryParse(json['expiresIn'])
          : json['expiresIn'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'expiresIn': expiresIn,
    };
  }

  @override
  String toString() {
    return 'Token(accessToken: $accessToken, refreshToken: $refreshToken, expiresIn: $expiresIn)';
  }
}
