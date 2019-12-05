import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TicTacToePage extends StatefulWidget {
  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToePage> {
  var tiles = List<int>.filled(9, 0, growable: false);
  var currentPlayer = 1;
  var step = 0;

  void _reload() {
    setState(() {
      step = 0;
      tiles = List<int>.filled(9, 0, growable: false);
    });
  }

  Future _showWinner(IconData icon, String text) async {
    await showDialog(
        context: context,
        child: SimpleDialog(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  size: MediaQuery.of(context).size.height / 4,
                ),
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
      await _showWinner(_icon(winner), "Wins");
      _reload();
    }
  }

  Future<void> checkNoMoves() async {
    if (step == 9) {
      await _showWinner(Icons.people_outline, "Draw");
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
  IconData _icon(int shape) {
    if (shape == 0) {
      return Icons.fullscreen;
    } else if (shape == 1) {
      return Icons.clear;
    }
    return Icons.panorama_fish_eye;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData _mediaQueryData = MediaQuery.of(context);
    var _size =
        min(_mediaQueryData.size.width, _mediaQueryData.size.height) / 3;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _reload();
          },
          child: Icon(Icons.refresh),
          // backgroundColor: Colors.green,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildTile(_icon(tiles[0]), _size, () => _markTile(0)),
                  buildTile(_icon(tiles[1]), _size, () => _markTile(1)),
                  buildTile(_icon(tiles[2]), _size, () => _markTile(2)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildTile(_icon(tiles[3]), _size, () => _markTile(3)),
                  buildTile(_icon(tiles[4]), _size, () => _markTile(4)),
                  buildTile(_icon(tiles[5]), _size, () => _markTile(5)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildTile(_icon(tiles[6]), _size, () => _markTile(6)),
                  buildTile(_icon(tiles[7]), _size, () => _markTile(7)),
                  buildTile(_icon(tiles[8]), _size, () => _markTile(8)),
                ],
              ),
            ],
          ),
        ));
  }
}

SizedBox buildTile(IconData icon, double size, Function f) {
  return SizedBox(
    height: size,
    width: size,
    child: IconButton(
        padding: EdgeInsets.all(0.0),
        icon: Icon(icon, size: size),
        onPressed: () => f()),
  );
}
