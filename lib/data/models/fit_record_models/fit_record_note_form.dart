class FitRecordNoteForm {
  final String text;
  final int rate;

  FitRecordNoteForm({required this.text, required this.rate});

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'rate': rate,
    };
  }
}
