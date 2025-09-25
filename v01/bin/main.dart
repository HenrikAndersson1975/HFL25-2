import 'package:v01/inputs.dart';
import 'package:v01/tokens.dart';

void main() {

  bool isRunning = true;

  while(isRunning) {

    // Inmatning från användaren
    NumberToken a = getIntegerFromUser('Ange första heltalet: '); 
    NumberToken b = getIntegerFromUser('Ange andra heltalet: ');
    OperatorToken op = getOperatorFromUser('Vilken operation vill du göra? (+ eller -): ', ['+', '-']);

    try {
      // Beräkna resultatet
      int result = compute(a, op, b);

      // Skriv ut resultatet
      print('Resultatet är: $result');
    }
    catch (e) {
      print('Fel vid beräkning: $e');        
    }    

    // Fråga användaren om den vill göra en ny beräkning
    isRunning = acceptOrDecline('Vill du göra en ny beräkning? (j/n) ', 'j', 'n');
  }   
}


/// Beräknar resultatet av en operation mellan två tal.
int compute(NumberToken a, OperatorToken op, NumberToken b) {
  switch (op.operator) {
    case '+':
      return a.value + b.value;
    case '-':
      return a.value - b.value;    
    default:
      throw ArgumentError('Okänd operator: ${op.operator}');
  }
}