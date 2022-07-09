import 'package:opnot/logic/dropbox/dropbox_auth.dart';
import 'package:opnot/logic/dropbox/dropbox_file_manager.dart';

class DropboxHandler {
  static DropboxHandler? _instance;
  late DropboxFileManager fileManager;
  late DropboxAuth auth;

  static DropboxHandler getInstance() {
    _instance ??= DropboxHandler(19246);
    return _instance!;
  }

  static DropboxAuth getAuth() {
    return DropboxHandler.getInstance().auth;
  }

  static DropboxFileManager getFileManager() {
    return DropboxHandler.getInstance().fileManager;
  }

  DropboxHandler(int code) {
    if (code != 19246) return;
    auth = DropboxAuth();
    fileManager = DropboxFileManager(auth.getToken());
  }
}
