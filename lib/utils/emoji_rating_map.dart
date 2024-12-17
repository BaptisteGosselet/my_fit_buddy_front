class EmojiRatingMap {
  EmojiRatingMap._singleton();
  static final EmojiRatingMap instance = EmojiRatingMap._singleton();

  static const Map<String, int> _emojiRatingMap = {
    '🤷‍♂️': 0,
    '😐': 1,
    '👍': 2,
    '😎': 3,
  };

  Map<String, int> getMap() {
    return _emojiRatingMap;
  }

  String getKeyByValue(int value) {
    return _emojiRatingMap.keys.firstWhere(
      (key) => _emojiRatingMap[key] == value,
      orElse: () => '🤷‍♂️',
    );
  }
}
