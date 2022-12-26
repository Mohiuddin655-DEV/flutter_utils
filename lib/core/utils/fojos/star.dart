class Star {
  final int timeMills;
  final String uid;
  final String documentId;

  const Star({
    required this.timeMills,
    required this.uid,
    required this.documentId,
  });

  factory Star.from(Map<String, dynamic> map) {
    final timeMills = map["time_mills"];
    final uid = map["user_id"];
    final documentId = map["document_id"];
    return Star(
      timeMills: timeMills,
      uid: uid,
      documentId: documentId,
    );
  }

  Map<String, dynamic> get map => {
        "time_mills": timeMills,
        "user_id": uid,
        "document_id": documentId,
      };

  Star modify({
    int? timeMills,
    String? uid,
    String? documentId,
  }) {
    return Star(
      timeMills: timeMills ?? this.timeMills,
      uid: uid ?? this.uid,
      documentId: documentId ?? this.documentId,
    );
  }
}
