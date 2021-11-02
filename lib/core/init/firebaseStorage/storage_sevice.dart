/*import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  static final FirebaseStorageService _instance = FirebaseStorageService._init();
  static FirebaseStorageService get instance => _instance;
  FirebaseStorageService._init();

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadImage(String userid, File file) async {
    var _puttingfile = _firebaseStorage.ref().child(userid).child('profile_photo').putFile(file);
    var _url = await (await _puttingfile).ref.getDownloadURL();
    return _url;
  }

  Future<void> removeImage(String userid) async {
    await _firebaseStorage.ref().child(userid).child('profile_photo').delete();
  }

  Future<String> uploadBannerImage(String userid, File file) async {
    var _puttingfile = _firebaseStorage.ref().child(userid).child('banner_photo').putFile(file);
    var _url = await (await _puttingfile).ref.getDownloadURL();
    return _url;
  }

  Future<void> removeBannerImage(String userid) async {
    await _firebaseStorage.ref().child(userid).child('banner_photo').delete();
  }
}
*/