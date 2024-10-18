class Token {
  String? accessToken;
  String? refreshToken;
  int? accessExpiresIn;
  int? refreshExpiresIn;

  Token({
    this.accessToken,
    this.refreshToken,
    this.accessExpiresIn,
    this.refreshExpiresIn,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accessToken: json['accessToken']?.toString(),
      refreshToken: json['refreshToken']?.toString(),
      accessExpiresIn: json['accessExpiresIn'] is String
          ? int.tryParse(json['accessExpiresIn'])
          : json['accessExpiresIn'] as int?,
      refreshExpiresIn: json['refreshExpiresIn'] is String
          ? int.tryParse(json['refreshExpiresIn'])
          : json['refreshExpiresIn'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'accessExpiresIn': accessExpiresIn,
      'refreshExpiresIn': refreshExpiresIn,
    };
  }

  @override
  String toString() {
    return 'Token(accessToken: $accessToken, refreshToken: $refreshToken, accessExpiresIn: $accessExpiresIn, refreshExpiresIn: $refreshExpiresIn)';
  }
}
