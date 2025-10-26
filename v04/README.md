# v04 #


## START ##
För att köra programmet från projektmappen v04 skriv något av dessa tre alternativ: 

dart run bin/main.dart. 
Utan argument kommer programmet inte arbeta med lagring som kan läsas in vid annan körning.

dart run bin/main.dart -f 
För att ange ett filnamn när programmet har startat som ska användas för att läsa/skriva hjältelista.

dart run bin/main.dart -t 
För att starta med fördefinierad hjältelista, använder mock som manager. 
Programmet kommer inte arbeta med lagring som kan läsas in vid annan körning.

----------------------------------------------------------------------------------------------------

## HUVUDMENY ##
1. Sök hjälte online
2. Skapa hjälte
3. Hantera hjätar (visa/ny/radera)
4. Sök hjäte
5. Avslut

----------------------------------------------------------------------------------------------------

### HUVUDMENY > 1. Sök hjälte online ###
Ange en del av ett namn.
Inmatning matchas mot namn på hjältar på superheroapi.com.
Lista med matchningar visas.

  #### 1. Undermeny ####
  1. Spara alla hjältar
  2. Välj vilka hjältar som ska sparas
  3. Gör ingenting

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
   Användare kan ta bort hjälte från listan.
   Man väljer dem en och en tills listan är tom eller man väljer "Avbryt".

   ##### 3.3 Ändra sortering #####
   Välj enligt vilka egenskaper sortering i listan ska ske.
   Genom att välja i menyn kan man ange AV/PÅ.
   Sortering kommer att göras enligt värden på de egenskaper som är angivna PÅ.
   Om flera är PÅ kommer sortering göras enligt den ordning som man valt att sätta dem till PÅ.
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