# v03 #

## START ##
För att köra programmet från projektmappen v03 skriv: dart run bin/main.dart.  
Man kan ange argument:  
-t = för att starta med fördefinierad hjältelista, använder mock som manager.  
-f = för att ange ett filnamn när programmet har startat som ska användas för att läsa/skriva hjältelista  
-f filnamn = fil som innehåller hjältelista  

## OM FILERNA ##  

### bin/main.dart ###
Filen innehåller programmet entry-point och huvudloop.

### dialogs ###
Interaktion med användaren.

### interfaces ###
Interfaces. I detta fall implementeras de av klasserna i managers.

### managers ###
Klasser som hanterar listan med hjältar och hur listan sparas mellan körningar.

### models ###
Klasser för att hantera hjälte och egenskaper hos hjälte.

### services ###
För att ge programmet åtkomst till manager.