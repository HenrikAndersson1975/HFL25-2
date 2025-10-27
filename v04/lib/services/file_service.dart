import 'dart:io';
import 'dart:async';

class FileService {
  // Fil denna service hanterar
  File? _file;

  // För att kunna låsa fil
  bool _isLocked = false;  // anger om filen är låst 
  late Completer<void> _lockCompleter = Completer<void>();  // gör att man kan vänta på att en filoperation ska vara klar innan vi låser eller låser upp filen

  FileService(String filePath) {
    _file = File(filePath); 
  }

  Future<void> _waitForUnlock() async {

    // Om filen är låst, väntar på att _lockCompleter.future ska bli färdig, och fortsätter sedan exekvering
    if (_isLocked) {
      await _lockCompleter.future;
    }
  }

  Future<void> _lockFile() async {
    await _waitForUnlock(); // väntar till fil är olåst
    _isLocked = true; // anger att filen är låst
    _lockCompleter = Completer<void>(); // initierar completer för att kunna vänta på upplåsning vid en framtida tidpunkt
  }

  void _unlockFile() {
    _isLocked = false; // anger att fil är olåst
    _lockCompleter.complete(); // signalerar att filen är upplåst och exekvering kan fortsätta vid await _lockCompleter.future i _waitForUnlock();
  }

  Future<bool> write(String content) async {
    bool result;

    // Vänta tills fil är olåst och lås den sedan
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
      // Avslutar alltid med att låsa upp filen
      _unlockFile();
    }

    return result;
  }

  Future<String> read() async {
    String result;

    // Vänta tills fil är olåst och lås den sedan
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
      // Avslutar alltid med att låsa upp filen
      _unlockFile();
    }

    return result;
  }

  Future<bool> exists() async {
    return _file?.exists() ?? false;
  }
}