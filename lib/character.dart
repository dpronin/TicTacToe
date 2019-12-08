import 'package:flutter/widgets.dart';

class Character {

  Image charactersTogether;
  Image firstCharacter;
  Image secondCharacter;
  Image firstWin;
  Image secondWin;

  Character(String charactersTogether, String firstCharacter, String secondCharacter, String firstWin, String secondWin) {
    this.charactersTogether = Image.asset('assets/images/$charactersTogether', width: 50, height: 50,);
    this.firstCharacter = Image.asset('assets/images/$firstCharacter', width: 50, height: 50,);
    this.secondCharacter = Image.asset('assets/images/$secondCharacter', width: 50, height: 50,);
    this.firstWin = Image.asset('assets/images/$firstWin', width: 50, height: 50,);
    this.secondWin = Image.asset('assets/images/$secondWin', width: 50, height: 50,);
  }
}
