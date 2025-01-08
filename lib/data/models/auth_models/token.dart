class Token {
  String? accessToken;
  String? refreshToken;
  DateTime? accessExpirationDate;
  DateTime? refreshExpirationDate;

  Token({
    this.accessToken,
    this.refreshToken,
    this.accessExpirationDate,
    this.refreshExpirationDate,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accessToken: json['accessToken']?.toString(),
      refreshToken: json['refreshToken']?.toString(),
      accessExpirationDate: json['accessExpirationDate'] != null
          ? DateTime.parse(json['accessExpirationDate'])
          : null,
      refreshExpirationDate: json['refreshExpirationDate'] != null
          ? DateTime.parse(json['refreshExpirationDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'accessExpirationDate': accessExpirationDate?.toIso8601String(),
      'refreshExpirationDate': refreshExpirationDate?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Token(accessToken: $accessToken, refreshToken: $refreshToken, accessExpirationDate: $accessExpirationDate, refreshExpirationDate: $refreshExpirationDate)';
  }

  DateTime? getAccessEndDate() {
    return accessExpirationDate;
  }
}
