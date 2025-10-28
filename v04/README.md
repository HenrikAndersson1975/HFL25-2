# v04 #


## START ##
För att köra programmet från projektmappen v04 skriv något av dessa tre alternativ: 

dart run bin/main.dart
Utan argument kommer programmet att fråga om man vill använda en fil för att lagra hjältar till annan körning.

dart run bin/main.dart -f 
Programmet frågar vilken fil man vill använda för att lagra hjältelista. Filnamn kan anges som argument efter -f, i så fall föreslås den. 

dart run bin/main.dart -t 
Startar med fördefinierad hjältelista, använder mock som manager. 
Programmet kommer inte arbeta med lagring som kan läsas in vid annan körning.

----------------------------------------------------------------------------------------------------

## HUVUDMENY ##
1. Sök hjälte online
2. Skapa hjälte
3. Hantera hjätar (visa/ny/radera)
4. Sök hjälte
5. Avslut

----------------------------------------------------------------------------------------------------

### HUVUDMENY > 1. Sök hjälte online ###
Ange en del av ett namn.
Inmatning matchas mot namn på hjältar på superheroapi.com.
Lista med matchningar visas.

  #### 1. Undermeny ####
  Lista med hittade hjältar.
  På varje rad med hjälte kan man växla mellan Ja/Nej. Hjältar på de rader som har Ja kommer att sparas.
  v, växlar alla Ja till Nej och alla Nej till Ja.
  s, Sparar de hjältar som har Ja
  x, Återgår till lista 

  ##### 1.1 Spara alla hjältar #####
  Alla hittade hjältar sparas till lista.

  ##### 1.2 Välj vilka hjältar som ska sparas #####
  Lista med hittade hjältar visas, där man kan välja vilka hjältar som ska sparas till lista. 
  Man väljer dem en och en tills listan är tom eller man väljer "Avbryt".

----------------------------------------------------------------------------------------------------
  
### HUVUDMENY > 2. Skapa hjälte ###
Fyll i egenskaper för hjälte. Hjälte sparas till lista.

----------------------------------------------------------------------------------------------------

### HUVUDMENY > 3. Hantera hjätar (visa/ny/radera) ###
Lista med hjälte visas enligt den sortering och den filtrering som är vald.

   #### 3. Undermeny ####
   1. Lägg till hjälte
   2. Ta bort hjälte
   3. Ändra sortering
   4. Ändra filtrering
   5. Återställ sortering och filtrering
   6. Tillbaka

   ##### 3.1 Lägg till hjälte #####
   Fyll i egenskaper för hjälte. Hjälte sparas till lista.

   ##### 3.2 Ta bort hjälte #####
   Lista med hjältar.
   På varje rad med hjälte kan man växla mellan Ja/Nej. Hjältar på rader som har Ja kommer att tas bort.
   v, växlar alla Ja till Nej och alla Nej till Ja.
   s, Sparar de hjältar som har Ja
   x, Återgår till lista 


   Användare kan ta bort hjälte från listan.
   Man väljer dem en och en tills listan är tom eller man väljer "Avbryt".

   ##### 3.3 Ändra sortering #####
   Välj enligt vilka egenskaper sortering i listan ska ske.
   Genom att välja i menyn kan man ange AV/PÅ.
   Sortering kommer att göras enligt värden på de egenskaper som är angivna PÅ.
   Om flera är PÅ kommer sortering göras enligt den ordning som man valt att sätta dem till PÅ. Alltså har sist valda högst prioritet.
   Ange alternativ för 'Visa lista' för att återgå till listan.

   ##### 3.4 Ändra filtrering #####
   Välj filter för listan. 
   Genom att välja i menyn kan man ange VISA/DÖLJ.
   Hjälte måste ha värde som matchar med värde vid VISA för att synas i listan. Annars döljs den.
   Ange alternativ för 'Visa lista' för att återgå till listan.

   ##### 3.5 Återställ sortering och filtrering #####
   Ställer in defaultinställning för sortering och filtrering.

   ##### 3.6 Tillbaka #####
   Återgår till huvudmenyn.

----------------------------------------------------------------------------------------------------

### HUVUDMENY > 4. Sök hjälte ###
Ange en del av ett namn.
Inmatning matchas mot namn på hjältar i lokal lista.
Lista med matchningar visas.

----------------------------------------------------------------------------------------------------

### HUVUDMENY > 5. Avsluta ###
Du får fråga om du vill avsluta programmet.


----------------------------------------------------------------------------------------------------


## PROGRAMSTRUKTUR ##


### lib/dialogs ###
Innehåller metoder där användaren interagerar med programmet.
Första nivån är menu_option_* som sedan använder dialog_* för att hämta information från användaren.

### lib/interfaces ###
Abstrakta klasser.

### lib/managers ###
Hanterar hjältar i lokal lista, i fil, online.

### lib/models ###
Klasser som representerar hjälte och hjältes egenskaper.

### lib/services ###
Lite mer allmäna tjänster.