class Token {
  String? accessToken;
  String? refreshToken;
  int? accessExpiresIn; // en millisecondes
  int? refreshExpiresIn; // en millisecondes
  DateTime? accessTokenCreatedAt;
  DateTime? refreshTokenCreatedAt;

  Token({
    this.accessToken,
    this.refreshToken,
    this.accessExpiresIn,
    this.refreshExpiresIn,
    this.accessTokenCreatedAt,
    this.refreshTokenCreatedAt,
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
      accessTokenCreatedAt: DateTime.now(), // moment où le token est créé
      refreshTokenCreatedAt: DateTime.now(),
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

  bool isAccessTokenValid() {
    if (accessExpiresIn == null || accessTokenCreatedAt == null) return false;
    final expirationTime =
        accessTokenCreatedAt!.add(Duration(milliseconds: accessExpiresIn!));
    return DateTime.now().isBefore(expirationTime);
  }

  bool isRefreshTokenValid() {
    if (refreshExpiresIn == null || refreshTokenCreatedAt == null) return false;
    final expirationTime =
        refreshTokenCreatedAt!.add(Duration(milliseconds: refreshExpiresIn!));
    return DateTime.now().isBefore(expirationTime);
  }

  @override
  String toString() {
    return 'Token(accessToken: $accessToken, refreshToken: $refreshToken, accessExpiresIn: $accessExpiresIn, refreshExpiresIn: $refreshExpiresIn)';
  }
}
