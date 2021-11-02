import '../../init/database/db_service_base.dart';
import '../../init/database/db_service.dart';
import '../../init/database/firestore_sevice.dart';
import '../../init/locator.dart';

enum DbRepositoryEnums {
  firestore,
  db,
}

class DbRepository implements DbServiceBase {
  DbRepositoryEnums dbRepositoryEnums = DbRepositoryEnums.db;
  final _dbService = locator<DbService>();
  final _firestoreService = locator<FirestoreServices>();

  /*@override
  Future<String> deletePost(String postID) {
    if (dbRepositoryEnums == DbRepositoryEnums.db) {
      return _dbService.deletePost(postID);
    }
    return _firestoreService.deletePost(postID);
  }*/

}
