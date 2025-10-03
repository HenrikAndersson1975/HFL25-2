import 'package:test/test.dart';
import 'package:v02/hero.dart';  

void main() {
  
// provar hur test fungerar

  test('testar att 5 är ett ogiltigt kön', () {
    bool isValid = isValidPropertyValue("5", "gender");
    expect(isValid, equals(false)); 
  });

  test('testar att kvinna är ett giltigt kön', () {
    bool isValid = isValidPropertyValue('kvinna', "gender");
    expect(isValid, equals(true)); 
  });

  test('testar att 2000 är en ogiltig styrka', () {
    bool isValid = isValidPropertyValue(2000, "strength");
    expect(isValid, equals(false)); 
  });
}