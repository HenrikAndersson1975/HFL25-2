import 'package:v02/menu.dart';
import 'package:v02/enumerations.dart';

void main(List<String> arguments) {
  

  // menyrubrik
  String menuHeader = '=== MENY ===';

  // menyalternativ
  List<MenuOption> menuOptions = [
    MenuOption(Action.addHero, 'Lägg till hjälte'),
    MenuOption(Action.showHeroes, 'Visa hjältar'),
    MenuOption(Action.searchHero, 'Sök hjälte'),
    MenuOption(Action.exit, 'Avsluta')
  ];

  // uppmaning till användaren
  String menuPrompt = 'Välj ett alternativ: ';


  bool isRunning = true;  // sätts till false för att avsluta programmet

  while (isRunning) {
    
    Action action = selectActionFromMenu(menuHeader, menuOptions, menuPrompt);

    switch (action) {
      case Action.addHero:
        print('Lägger till hjälte...');

      case Action.showHeroes:
        print('Visar hjältar...');

      case Action.searchHero:
        print('Söker hjälte...');

      case Action.exit:
        print('Programmet avslutat.');
        isRunning = false;
    }
  }
}