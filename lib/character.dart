import 'package:flutter/widgets.dart';

class Character {

  Image charactersTogether;
  Image firstCharacter;
  Image secondCharacter;
  Image firstWin;
  Image secondWin;

  Character(String characters) {
    this.charactersTogether = Image.asset('assets/images/${characters}_b.png', width: 50, height: 50,);
    this.firstCharacter = Image.asset('assets/images/${characters}_1.png', width: 200, height: 200,);
    this.secondCharacter = Image.asset('assets/images/${characters}_2.png', width: 200, height: 200,);
    this.firstWin = Image.asset('assets/images/${characters}_1_w.png', width: 200, height: 200,);
    this.secondWin = Image.asset('assets/images/${characters}_2_w.png', width: 200, height: 200,);
  }
}
