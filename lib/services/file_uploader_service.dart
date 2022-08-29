import 'package:firebase_storage/firebase_storage.dart';

class FileUploaderService {
  static void uploadFile(pathName, selectedFile) {
    final path = pathName;
    FirebaseStorage.instance
        .refFromURL('gs://fintech-registration-app.appspot.com/')
        .child(path)
        .putBlob(selectedFile);
  }
}
