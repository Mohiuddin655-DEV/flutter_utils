import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class PathProvider {
  const PathProvider._();

  static String generatePath(
    String collectionId,
    String documentId, [
    String? parent,
    FirebaseApp? firebaseApp,
  ]) {
    final instance = firebaseApp != null
        ? FirebaseFirestore.instanceFor(app: firebaseApp)
        : FirebaseFirestore.instance;

    if (parent != null) {
      return instance.collection(collectionId).doc(documentId).path;
    } else {
      return '$parent/$collectionId/$documentId';
    }
  }
}
