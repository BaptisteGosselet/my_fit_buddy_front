class FitRecordNoteForm {
  final String text;

  FitRecordNoteForm({required this.text});

  Map<String, dynamic> toJson() {
    return {'text': text};
  }
}
