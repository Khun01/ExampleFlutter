import 'package:flutter/material.dart';
import 'package:help_isko/presentation/widgets/my_messsage_icon.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  int numberCounter = 0;

  void _incrementCounter() {
    setState(() {
      numberCounter++; // Increment the number when the button is pressed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    numberCounter = 0;
                  });
                },
                child: MyMesssageIcon(selectedIndex: 1),
              ),
              const SizedBox(height: 50),
              IconButton(
                onPressed: (){
                  setState(() {
                    numberCounter++;
                  });
                },
                icon: const Icon(
                  Icons.add,
                  size: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
