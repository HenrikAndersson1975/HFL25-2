import 'dart:io';
import 'dart:convert';

String? dialogEnterHeroName() {

  // Frågar användaren efter namn eller del av namn 
  stdout.write('Ange namn eller del av namn: ');
  String? partOfHeroName = stdin.readLineSync(encoding: utf8);  // encoding lades till för att kunna hantera åäö, med det fungerar ända inte i Windows Powershell trots (chcp 65001).

  return partOfHeroName;
}

