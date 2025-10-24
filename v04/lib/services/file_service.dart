import 'dart:io';
import 'dart:async';


class FileService {
  // Fil denna service hanterar
  File? _file;

  // För att kunna låsa fil
  bool _isLocked = false;
  late Completer<void> _lockCompleter = Completer<void>();

  FileService(String filePath) {
    _file = File(filePath); // Nu instansieras varje FileService med en filväg
  }

  Future<void> _waitForUnlock() async {
    if (_isLocked) {
      await _lockCompleter.future;
    }
  }

  Future<void> _lockFile() async {
    await _waitForUnlock();
    _isLocked = true;
    _lockCompleter = Completer<void>();
  }

  void _unlockFile() {
    _isLocked = false;
    _lockCompleter.complete();
  }

  Future<bool> write(String content) async {
    bool result;

    await _lockFile();

    try {
      if (_file == null) {
        throw Exception('Fil finns inte.');
      }
      await _file!.writeAsString(content, mode: FileMode.writeOnly);
      result = true;
    } catch (e) {
      print('Fel vid skrivning till fil: $e');
      result = false;
    } finally {
      _unlockFile();
    }

    return result;
  }

  Future<String> read() async {
    String result;

    await _lockFile();

    try {
      if (_file == null) {
        throw Exception('Fil finns inte.');
      }

      result = await _file!.readAsString();
    } catch (e) {
      print('Fel vid läsning från fil: $e');
      result = '';
    } finally {
      _unlockFile();
    }

    return result;
  }

  Future<bool> exists() async {
    return _file?.exists() ?? false;
  }
}
