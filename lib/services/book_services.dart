import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:library_managment_system/functions/app_constants.dart';

class BookServices {
  final firebaseStorage = FirebaseStorage.instance;

  Future uploadImages(String path, String name) async {
    var bookUrl = null;

    final firebasePath =
        firebaseStorage.ref(AppConstants.firebaseStorageImgPath).child(name);
    UploadTask uploadTask = firebasePath.putFile(File(path));
    await uploadTask.whenComplete(() {});

    firebasePath.getDownloadURL().then((value) {
      bookUrl = value;

      print('BookServices.uploadImages-> ${bookUrl}');
      return value.toString();
    });
    // return bookUrl.toString();
  }
}
