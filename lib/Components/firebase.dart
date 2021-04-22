import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStore {
  CollectionReference reference = FirebaseFirestore.instance.collection('Apps');

  //send Data
  Future<void> addApp(String appName, String appCategory, String appDescription,
      String appLink,String imageUrl) {
    return reference.add({
      'AppName': appName,
      'AppCategory': appCategory,
      'AppDescription': appDescription,
      'AppLink': appLink,
      'ImageUrl' : imageUrl,
    }).catchError((error) => print('Failed to add User'));
  }

  Future<void> updateApp(DocumentSnapshot docToEdit, String appName,
      String appCategory, String appDescription, String appLink) {
    return docToEdit.reference
        .update({
      'AppName': appName,
      'AppCategory': appCategory,
      'AppDescription': appDescription,
      'AppLink': appLink,
    })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> deleteApp(DocumentSnapshot docToEdit) {
    return docToEdit.reference.delete();
  }
}

class FireStorage {
  final _storage = FirebaseStorage.instance;

  // ignore: missing_return
  addImage(var fileToUpload, String appName) async {
    if (fileToUpload != null) {
      var snapshotImage = await _storage
          .ref()
          .child('LoanGuides/' + appName)
          .putFile(fileToUpload);
      var downloadUrl = await snapshotImage.ref.getDownloadURL();
      return downloadUrl;
    } else {
      print('no image path Selected');
    }
  }

  Future<void> deleteImage(String imageUrl) async {
    await _storage.ref(imageUrl).delete();

  }
}
