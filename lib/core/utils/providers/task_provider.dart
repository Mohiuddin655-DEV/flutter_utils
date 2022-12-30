import 'package:firebase_storage/firebase_storage.dart';

class TaskProvider {
  const TaskProvider._();

  static bool isComplete(int initial, int progress) => initial == progress;

  static double getProgress(TaskSnapshot snapshot) {
    final transferred = snapshot.bytesTransferred;
    final total = snapshot.totalBytes;
    final progress = 100.0 * (transferred / total);
    return progress;
  }
}
