import 'package:flutter/material.dart';
import 'package:hangman/components/constants.dart';
import 'loading screen.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xff431a9b) ,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                    margin: const EdgeInsets.fromLTRB(8.0, 1.0, 8.0, 8.0),
                    child: kHomeScreenTitle),
              ),
              Center(
                child: Container(

                  padding: const EdgeInsets.all(20.0),
                  child: const Image(
                    image: AssetImage('images/gallow.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Center(
                child: Container(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/game');
                    },
                    style: kHomeScreenButtons,
                    child: const Text('Start'),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoadingScreen(),
                      ),
                    );
                  },
                  style: kHomeScreenButtons,
                  child: const Text('High Scores'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

