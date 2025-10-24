import 'package:uuid/uuid.dart';

String getUniqueId() {
  var uuid = Uuid();
  String uniqueId = uuid.v4(); 
  return uniqueId;
}