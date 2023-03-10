import 'package:flutter/material.dart';
import 'package:hangman/components/constants.dart';
import 'package:hangman/utils.dart';
import 'dart:math';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:hangman/components/user_scores.dart';
import 'package:hangman/components/scores_database.dart' as scores_database;
import 'package:flutter/services.dart' show rootBundle;

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  initState() {
    readWord();
    super.initState();
  }
  final database = scores_database.openDB();
  int lives = 5;
  int status = 0;
  int score = 0;
  List<String> wordList=[];
  void readWord() async {
    String loadedString =
        await rootBundle.loadString('utilities/hangman_words.txt');
    List<String> wordText = loadedString.split('\n');
    setState(() {
      wordList = wordText;
    });
  }



  late String word = wordList[Random().nextInt(wordList.length)].toUpperCase();
  List guessedalpha = [];
  late List hintLetters = word.split('');

  bool button1Enabled = true;
  List selectedButtons = [];

  int hintLimit = 0;

  getHint() {
    for (int i = 0; i < guessedalpha.length; i++) {
      hintLetters
          .removeWhere((hintLetters) => hintLetters.contains(guessedalpha[i]));
    }
    String alph = hintLetters[Random().nextInt(hintLetters.length)];
    checkLetter(alph,true);
    hintLetters.remove(alph);
    selectedButtons.add(alph);
  }

  String handleText() {
    String displayword = '';
    for (int i = 0; i < word.length; i++) {
      String characters = word[i];
      if (guessedalpha.contains(characters)) {
        displayword += characters;
      } else {
        displayword += '_ ';
      }
    }
    return displayword;
  }

  gameOver() {
    lives = 5;
    guessedalpha.clear();
    status = 0;
    word = wordList[Random().nextInt(wordList.length)].toUpperCase();
    Navigator.popUntil(context, ModalRoute.withName('/'));
    selectedButtons.clear();
    hintLimit = 0;
  }

  youLost() {
    lives--;
    guessedalpha.clear();
    status = 0;
    word = wordList[Random().nextInt(wordList.length)].toUpperCase();
    selectedButtons.clear();
    hintLimit = 0;
  }

  void correctGuess() {
    setState(() {
      guessedalpha.clear();
      status = 0;
      score++;
      word = wordList[Random().nextInt(wordList.length)].toUpperCase();
      selectedButtons.clear();
      hintLimit = 0;
    });
  }

  void checkLetter(String alphabet,bool hint) {
    selectedButtons.add(alphabet);
    if (word.contains(alphabet)) {
      setState(() {
        guessedalpha.add(alphabet);
      });
    } else if (!word.contains(alphabet) && status != 6) {
      setState(() {
        if(!hint){
          status += 1;
        }
        if (status == 6) {
          if (lives < 1) {
            if (score > 0) {
              Scores scores = Scores(
                  id: 1,
                  scoreDate: DateTime.now().toString(),
                  userScore: score);
              scores_database.manipulateDatabase(scores, database);
            }
            Alert(
                context: context,
                title: 'Game Over',
                desc: word,
                style: kErrorAlertStyle,
                buttons: [
                  DialogButton(
                      width: 127,
                      color: const Color(0x00000000),
                      height: 52,
                      onPressed: () {
                        setState(() {
                          Navigator.pop(context);
                          gameOver();
                        });
                      },
                      child: const Icon(
                        Icons.home,
                        size: 30.0,
                      ),)
                ]).show();
          } else {
            Alert(
              context: context,
              title: 'Wrong Guess:',
              desc: word,
              type: AlertType.error,
              style: kErrorAlertStyle,
              buttons: [
                DialogButton(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                    children: const [
                        Text('Next Word',style: TextStyle(color: Colors.white,fontFamily: 'PatrickHand',fontSize: 30.0, ),),
                        SizedBox(width: 5.0,),
                        Icon(Icons.arrow_forward_rounded, color: Colors.white,size: 30.0),
                      ],
                    )
                 ,
                    onPressed: (){
                      setState(() {
                        Navigator.pop(context);
                        youLost();
                      });
                    }
                )
              ]

            ).show();
          }
        }
      });
    }

    bool isWon = true;
    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      if (!guessedalpha.contains(char)) {
        setState(() {
          isWon = false;
        });
      }
    }
    if (isWon) {
      setState(() {

        Alert(
            context: context,
            title: 'Correct Guess',
            desc: word,
            type: AlertType.success,
            style: kSuccessAlertStyle,
            buttons: [
              DialogButton(
                  color: Colors.transparent,
                  child:
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text('Next Word',style: TextStyle(color: Colors.white,fontFamily: 'PatrickHand',fontSize: 30.0, ),),
                      SizedBox(width: 5.0,),
                      Icon(Icons.arrow_forward_rounded, color: Colors.white,size: 30.0),
                    ],
                  )
                  ,
                  onPressed: (){
                    setState(() {
                      Navigator.pop(context);
                      correctGuess();
                    });
                  }
              )
            ]).show();
       });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: const EdgeInsetsDirectional.only(top: 25.0),
          color: const Color(0xff431a9b),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        const Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 40.0,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            lives.toString(),
                            style: const TextStyle(
                                color: Color(0xff431a9b),
                                fontSize: 26.0,
                                fontFamily: 'PatrickHand',
                                fontWeight: FontWeight.w900),
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    '$score',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 45.0,
                        fontFamily: 'PatrickHand'),
                  ),
                  IconButton(
                    onPressed: () {
                       if (hintLimit < 2 && hintLetters.length > 2) {
                        getHint();
                        hintLimit++;
                      }
                    },
                    icon: Icon(
                      Icons.lightbulb_outline,
                      size: 39.0,
                      color: hintLimit < 2 && hintLetters.length > 2
                          ? Colors.white
                          : Colors.grey,
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Image.asset(
                  'images/$status.png',
                  height: 250,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 15.0,bottom: 10.0),
                child: FittedBox(
                  child: Text(
                    handleText(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 45.0,
                        fontFamily: 'PatrickHand'),
                  ),
                ),
              ),
              GridView.count(
                crossAxisCount: 7,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
                children: letters.map((alphabet) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (!selectedButtons.contains(alphabet)) {
                          checkLetter(alphabet,false);
                        }

                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 3.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(4.0),
                        backgroundColor: selectedButtons.contains(alphabet)
                            ? Colors.grey
                            : const Color(0xff1189fe),
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 27,
                            fontFamily: 'PatrickHand'),
                      ),
                      child: Text(alphabet),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
