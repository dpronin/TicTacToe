import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttt/character.dart';

import 'characters.dart';

class TicTacToePage extends StatefulWidget {
  @override
  _TicTacToeState createState() => _TicTacToeState();
}

final blank = Image.asset('assets/images/blank.png');
final charactersToPlay = buildCharacters();

class _TicTacToeState extends State<TicTacToePage> {
  var tiles = List<int>.filled(9, 0, growable: false);
  var currentPlayer = 1;

  var currentCharacters = charactersToPlay[0];
  var step = 0;

  void _reload() {
    setState(() {
      step = 0;
      tiles = List<int>.filled(9, 0, growable: false);
    });
  }

  Future _showWinner(Image image, String text) async {
    await showDialog(
        context: context,
        child: SimpleDialog(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                image,
                Text(text, style: Theme.of(context).textTheme.display3)
              ],
            ),
          ],
        ));
  }

  Future<void> checkWinner() async {
    var winner = 0;
    if ((tiles[0] + tiles[1] + tiles[2]).abs() == 3) {
      winner = tiles[0];
    }
    if ((tiles[3] + tiles[4] + tiles[5]).abs() == 3) {
      winner = tiles[3];
    }
    if ((tiles[6] + tiles[7] + tiles[8]).abs() == 3) {
      winner = tiles[6];
    }
    if ((tiles[0] + tiles[3] + tiles[6]).abs() == 3) {
      winner = tiles[0];
    }
    if ((tiles[1] + tiles[4] + tiles[7]).abs() == 3) {
      winner = tiles[1];
    }
    if ((tiles[2] + tiles[5] + tiles[8]).abs() == 3) {
      winner = tiles[2];
    }
    if ((tiles[0] + tiles[4] + tiles[8]).abs() == 3) {
      winner = tiles[0];
    }
    if ((tiles[2] + tiles[4] + tiles[6]).abs() == 3) {
      winner = tiles[2];
    }
    if (winner != 0) {
      await _showWinner(
          winner == 1
              ? currentCharacters.firstWin
              : currentCharacters.secondWin,
          "Wins");
      _reload();
    }
  }

  Future<void> checkNoMoves() async {
    if (step == 9) {
      await _showWinner(blank, "Draw");
      _reload();
    }
  }

  Future<void> _markTile(int position) async {
    if (tiles[position] != 0) return;
    setState(() {
      step++;
      tiles[position] = currentPlayer;
    });
    await checkWinner();
    await checkNoMoves();
    currentPlayer *= -1;
  }

  // shape x = 1. 0 = -1;
  Image _icon(int position) {
    if (tiles[position] == 1) {
      return currentCharacters.firstCharacter;
    } else if (tiles[position] == -1) {
      return currentCharacters.secondCharacter;
    }
    return blank;
  }

  BoxDecoration gridDecoration(tile) {
    switch (tile) {
      case 0:
        return BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0)),
          border: Border(
            top: BorderSide(width: 1.0, color: Colors.grey),
            left: BorderSide(width: 1.0, color: Colors.grey),
            right: BorderSide(width: 1.0, color: Colors.grey),
            bottom: BorderSide(width: 1.0, color: Colors.grey),
          ),
        );
      case 1:
        return BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0, color: Colors.grey),
            bottom: BorderSide(width: 1.0, color: Colors.grey),
          ),
        );
      case 2:
        return BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(10.0)),
          border: Border(
            top: BorderSide(width: 1.0, color: Colors.grey),
            left: BorderSide(width: 1.0, color: Colors.grey),
            right: BorderSide(width: 1.0, color: Colors.grey),
            bottom: BorderSide(width: 1.0, color: Colors.grey),
          ),
        );
      case 3:
        return BoxDecoration(
          border: Border(
            left: BorderSide(width: 1.0, color: Colors.grey),
            right: BorderSide(width: 1.0, color: Colors.grey),
          ),
        );
      case 4:
        return BoxDecoration();
      case 5:
        return BoxDecoration(
          border: Border(
            left: BorderSide(width: 1.0, color: Colors.grey),
            right: BorderSide(width: 1.0, color: Colors.grey),
          ),
        );
      case 6:
        return BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0)),
          border: Border(
            top: BorderSide(width: 1.0, color: Colors.grey),
            left: BorderSide(width: 1.0, color: Colors.grey),
            right: BorderSide(width: 1.0, color: Colors.grey),
            bottom: BorderSide(width: 1.0, color: Colors.grey),
          ),
        );
      case 7:
        return BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0, color: Colors.grey),
            bottom: BorderSide(width: 1.0, color: Colors.grey),
          ),
        );
      case 8:
        return BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.0)),
          border: Border(
            top: BorderSide(width: 1.0, color: Colors.grey),
            left: BorderSide(width: 1.0, color: Colors.grey),
            right: BorderSide(width: 1.0, color: Colors.grey),
            bottom: BorderSide(width: 1.0, color: Colors.grey),
          ),
        );
    }
  }

  Container _buildTile(int tile, double size) {
    return Container(
        height: size,
        width: size,
        child: InkWell(
          onTap: () => _markTile(tile),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: _icon(tile),
          ),
        ),
        decoration: gridDecoration(tile));
  }

  Widget _buildCharacterToPlay(int i) {
    return InkWell(
      onTap: () {
        currentCharacters = charactersToPlay[i];
        _reload();
      },
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: charactersToPlay[i].charactersTogether,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var _size =
        min(_mediaQueryData.size.width, _mediaQueryData.size.height) / 3 - 10;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _reload();
        },
        child: Icon(Icons.refresh),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: <Widget>[
                  _buildCharacterToPlay(0),
                  _buildCharacterToPlay(1),
                ])),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildTile(0, _size),
                _buildTile(1, _size),
                _buildTile(2, _size),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildTile(3, _size),
                _buildTile(4, _size),
                _buildTile(5, _size),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildTile(6, _size),
                _buildTile(7, _size),
                _buildTile(8, _size),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
