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
    print(
        "accessToken : ${json['accessToken']?.toString()} - refreshToken: ${json['refreshToken']?.toString()} - accessExpirationDate : ${json['accessExpirationDate']} - refreshExpirationDate: ${json['refreshExpirationDate']}");
    
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
    print(toString());

    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'accessExpirationDate': accessExpirationDate?.toIso8601String(),
      'refreshExpirationDate': refreshExpirationDate?.toIso8601String(),
    };
  }

  bool isAccessTokenValid() {
    if (accessExpirationDate == null) return false;
    return DateTime.now().isBefore(accessExpirationDate!);
  }

  bool isRefreshTokenValid() {
    if (refreshExpirationDate == null) return false;
    return DateTime.now().isBefore(refreshExpirationDate!);
  }

  @override
  String toString() {
    return 'Token(accessToken: $accessToken, refreshToken: $refreshToken, accessExpirationDate: $accessExpirationDate, refreshExpirationDate: $refreshExpirationDate)';
  }

  DateTime? getAccessEndDate() {
    return accessExpirationDate;
  }
}
