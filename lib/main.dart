import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'X/O Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IntroPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class IntroPage extends StatelessWidget {
  static var Sensei_font = GoogleFonts.overlock(
      color: Color(0xFF16161E), letterSpacing: 3, fontSize: 30);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF16161E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50.0),
            Text(
              'Wellcome To X - O Game',
              style: _HomepageState.Sensei_font,
            ),
            Text(
              'By: Mostafa Sensei',
              style: _HomepageState.Sensei_font,
            ),
            SizedBox(height: 50.0),
            Icon(
              Icons.dashboard,
              color: Color(0xff7aa2f7),
              size: 140,
            ),
            SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage()),
                );
              },
              child: Text(
                'Play X - O Match',
                style: Sensei_font,
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                textStyle: TextStyle(fontSize: 20),
                backgroundColor: Color(0xff7aa2f7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static var Sensei_font = GoogleFonts.overlock(
    color: Color(0xff7aa2f7),
    letterSpacing: 3,
    fontSize: 30,
  );

  bool check_tap = true;
  List<String> TapToShow_X_or_O = [
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
  ];

  int X_Score = 0;
  int O_Score = 0;

  int no_win = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF16161E),
      body: Column(
        children: <Widget>[
          // Player scores
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildPlayerScore(
                  'Player X',
                  X_Score,
                ),
                _buildPlayerScore('Player O', O_Score),
              ],
            ),
          ),
          // Game grid
          Expanded(
            flex: 5,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext context, int cont_box_index) {
                return GestureDetector(
                  onTap: () {
                    tap(cont_box_index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: Color(0xffe0af68)),
                    ),
                    child: Center(
                      child: Text(
                        TapToShow_X_or_O[cont_box_index],
                        style: Sensei_font,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Footer
          Expanded(
            child: Center(
              child: Column(
                children: <Widget>[
                  Text('X - O Game', style: Sensei_font),
                  SizedBox(height: 10),
                  GestureDetector(
                    child: Text('©Mostafa Mahmoud', style: Sensei_font),
                    // onTap: ,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

// Function to build player score widget
  Widget _buildPlayerScore(String playerName, int score) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            playerName,
            style: Sensei_font,
          ),
          Text(
            score.toString(),
            style: Sensei_font,
          ),
        ],
      ),
    );
  }

  void tap(int contBoxIndex) {
    setState(() {
      if (check_tap && TapToShow_X_or_O[contBoxIndex] == ' ') {
        TapToShow_X_or_O[contBoxIndex] = 'X';
        no_win += 1;
      } else if (!check_tap && TapToShow_X_or_O[contBoxIndex] == ' ') {
        TapToShow_X_or_O[contBoxIndex] = 'O';
        no_win += 1;
      }
      check_tap = !check_tap;
      who_winer();
    });
  }

  void clean_game() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        TapToShow_X_or_O[i] = ' ';
      }
    });
    no_win = 0;
  }

  void no_win_fun() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Draw, no one win'),
          actions: <Widget>[
            TextButton(
              child: Text('New Game'),
              onPressed: () {
                clean_game();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void Show_winer(String winer_name) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('The player ' + winer_name + ' Wins'),
          actions: <Widget>[
            TextButton(
              child: Text('New Game'),
              onPressed: () {
                clean_game();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    if (winer_name == 'X') {
      X_Score += 1;
    } else if (winer_name == 'O') {
      O_Score += 1;
    }
  }

  void who_winer() {
    // Check rows
    for (int i = 0; i < 9; i += 3) {
      if (TapToShow_X_or_O[i] == TapToShow_X_or_O[i + 1] &&
          TapToShow_X_or_O[i] == TapToShow_X_or_O[i + 2] &&
          TapToShow_X_or_O[i] != ' ') {
        Show_winer(TapToShow_X_or_O[i]);
        return;
      }
    }

    // Check columns
    for (int i = 0; i < 3; ++i) {
      if (TapToShow_X_or_O[i] == TapToShow_X_or_O[i + 3] &&
          TapToShow_X_or_O[i] == TapToShow_X_or_O[i + 6] &&
          TapToShow_X_or_O[i] != ' ') {
        Show_winer(TapToShow_X_or_O[i]);
        return;
      }
    }

    // Check diagonals
    if (TapToShow_X_or_O[0] == TapToShow_X_or_O[4] &&
        TapToShow_X_or_O[0] == TapToShow_X_or_O[8] &&
        TapToShow_X_or_O[0] != ' ') {
      Show_winer(TapToShow_X_or_O[0]);
      return;
    }

    if (TapToShow_X_or_O[2] == TapToShow_X_or_O[4] &&
        TapToShow_X_or_O[2] == TapToShow_X_or_O[6] &&
        TapToShow_X_or_O[2] != ' ') {
      Show_winer(TapToShow_X_or_O[2]);
      return;
    }

    // Check draw
    if (no_win == 9) {
      no_win_fun();
    }
  }
}
