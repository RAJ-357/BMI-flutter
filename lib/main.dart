// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF1B1C1E)),
      home: const HomePage(),
    );
  }
}

double bmi = 0;
String bmi_state = "";
String bmi_color = "";
String bmi_msg = "";

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}
class RadioButton extends StatefulWidget {
  const RadioButton({Key? key}) : super(key: key);
  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  int value = 1;
  Widget CustomRadioButton(String text, int index) {
    return SizedBox(
        height: 150,
        width: 155,
        child: TextButton(
          onPressed: () {
          setState(() {
          value = index;
        });
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF282828),),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: (value == index) ? Colors.green : const Color(0xFF111427)),
              )
          )
      ),
      child:
        Column(
          children: [
            if(text == "MALE") (const Icon(Icons.male_outlined, size: 100.0)),
            if(text == "FEMALE") (const Icon(Icons.female_outlined, size: 100.0,)),
            Text(
            text,
            style: TextStyle(
              color: (value == index) ? Colors.green : Colors.grey,fontSize: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomRadioButton("MALE", 1),
        const SizedBox(width: 30),
        CustomRadioButton("FEMALE", 2),
      ],
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _HomePageState extends State<HomePage> {

  double height=180;
  int weight=60;
  int age=20;


  void increase_weight() {
    setState(() {
      weight++;
    });
  }

  void decrease_weight() {
    setState(() {
      weight--;
    });
  }

  void increase_age() {
    setState(() {
      age++;
    });
  }

  void decrease_age() {
    setState(() {
      age--;
    });
  }

  void calculate() {
    setState(() {
      bmi = (weight)/(pow((height*0.01),2));
      bmi = num.parse(bmi.toStringAsFixed(2)) as double;
    });
  }

  void state() {
    setState(() {
      if(bmi<18)
        {
          bmi_state = "UNDERWEIGHT";
          bmi_color = 'FFD700';
          bmi_msg = "You are Underweight.\nTry to increase the intake of Calories in your Diet !";
        }
      else if(bmi>=18 && bmi <25)
        {
          bmi_state = "NORMAL";
          bmi_color = '00FF00';
          bmi_msg = "You have a normal body weight.\nGood job !";
        }
      else if(bmi>=25 && bmi <30)
      {
        bmi_state = "OVERWEIGHT";
        bmi_color = 'FF8C00';
        bmi_msg = "You are Overweight.\nTry to reduce the intake of Calories in your Diet !";
      }
      else
      {
        bmi_state = "OBESE";
        bmi_color = 'FF0000';
        bmi_msg = "You are Obese.\nConsult a doctor and prepare a diet plan to critically monitor your food intake !";
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor : const Color(0xFFD83457),
        title: const Text("BMI CALCULATOR",style: TextStyle(fontSize: 25)),
      ),

      bottomNavigationBar: Material(
        color: const Color(0xFFD83457),
        child: InkWell(
          onTap: () {
            calculate();
            state();
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SecondPage()),
            );
          },
          child: const SizedBox(
            height: 60,
            width: double.infinity,
            child: Center(
              child: Text(
                'CALCULATE',
                  style: TextStyle(fontSize: 30,color: Colors.white),
              ),
            ),
          ),
        ),
      ),

      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const RadioButton(),

            Container(
              decoration: const BoxDecoration(
                  color: Color(0xFF282828),
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              height: 150,
              width: 350,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    //padding: const EdgeInsets.all(10.0),
                    child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text("HEIGHT",textAlign: TextAlign.center,style: TextStyle(color: Colors.cyanAccent,fontSize: 15)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text("$height",textAlign: TextAlign.center,style: const TextStyle(color: Colors.orange,fontWeight: FontWeight.bold,fontSize: 45)),
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child :Text(" cm",style: TextStyle(color: Colors.grey,fontSize: 15)),
                          ),
                    ],
                  ),
                ],
              ),
              ),
                  Slider(
                    activeColor: Colors.white, // The color to use for the portion of the slider track that is active.
                    inactiveColor: const Color(0xFF8C8D95), // The color for the inactive portion of the slider track.
                    thumbColor: const Color(0xFFD83457),
                    value: height,
                    max: 300,
                    min: 50,
                    onChanged: (newValue) {
                      setState(() {
                        height = newValue.round() as double;
                      });
                    },
                  )
                ],
              ),
            ),

            //const SizedBox(height: 150),

            SizedBox(
              height: 150,
              width: 350,

              //color: const Color(0xFF1D1E32),

                child : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFF282828),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    width: 160,
                    child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  const Text("WEIGHT",textAlign: TextAlign.center,style: TextStyle(color: Colors.cyanAccent,fontSize: 15)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("$weight",textAlign: TextAlign.center,style: const TextStyle(color: Colors.orange,fontWeight: FontWeight.bold,fontSize: 45)),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Row(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    TextButton(
                                      style: ButtonStyle(
                                          foregroundColor: MaterialStateProperty.all<Color>(Colors.lightGreenAccent),
                                          backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF4D4F5C)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(18.0),
                                                  //side: const BorderSide(color: Color(0xFF4D4F5C)),
                                              )
                                          )
                                      ),
                                      onPressed: () => {
                                        increase_weight()
                                      },
                                      child: const Text('+',style: TextStyle(fontSize: 30)),
                                    ),
                                  ],
                                ),

                                Column(
                                  children: [
                                    TextButton(
                                      style: ButtonStyle(
                                        foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                          backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF4D4F5C)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(18.0),
                                                //side: const BorderSide(color: Color(0xFF4D4F5C)),
                                              )
                                          )
                                      ),
                                      onPressed: () => {
                                        decrease_weight()
                                      },
                                      child: const Text('-',style: TextStyle(fontSize: 30)),
                                    )
                                  ],
                                ),
                              ],
                            ),
                              ],
                            ),
                      ),

                      const SizedBox(width: 30),

              Container(
                decoration: const BoxDecoration(
                    color: Color(0xFF282828),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                width: 160,
                child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                const Text("AGE",textAlign: TextAlign.center,style: TextStyle(color: Colors.cyanAccent,fontSize: 15)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("$age",textAlign: TextAlign.center,style: const TextStyle(color: Colors.orange,fontWeight: FontWeight.bold,fontSize: 45)),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          Row(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  TextButton(
                                    style: ButtonStyle(
                                        foregroundColor: MaterialStateProperty.all<Color>(Colors.lightGreenAccent),
                                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF4D4F5C)),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(18.0),
                                              //side: const BorderSide(color: Color(0xFF4D4F5C)),
                                            )
                                        )
                                    ),
                                    onPressed: () => {
                                      increase_age()
                                    },
                                    child: const Text('+',style: TextStyle(fontSize: 30)),
                                  ),
                                ],
                              ),

                              Column(
                                children: [
                                  TextButton(
                                    style: ButtonStyle(
                                        foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF4D4F5C)),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(18.0),
                                              //side: const BorderSide(color: Color(0xFF4D4F5C)),
                                            )
                                        )
                                    ),
                                    onPressed: () => {
                                      decrease_age()
                                    },
                                    child: const Text('-',style: TextStyle(fontSize: 30)),
                                  )
                                ],
                              ),
                            ],
                          ),
                          ],
                        ),
                      ),
                    ],
                  ),
            ),

          ],
        ),
      ),
    );
  }
}

class _SecondPageState extends State<SecondPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor : const Color(0xFFD83457),
        title: const Text("BMI CALCULATOR",style: TextStyle(fontSize: 25)),
      ),
      bottomNavigationBar: Material(
        color: const Color(0xFFD83457),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const SizedBox(
            height: 60,
            width: double.infinity,
            child: Center(
              child: Text(
                'RE-CALCULATE',
                style: TextStyle(fontSize: 30,color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //const SizedBox(height: 20),
            const SizedBox(
             width: 350,
              child: Text("Your Result",textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40,color: Colors.cyanAccent)),
                ),
            //const SizedBox(height: 20),
            Container(
              color: const Color(0xFF282828),
              height: 500,
              width: 360,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Text(bmi_state,textAlign: TextAlign.center,style : TextStyle(fontWeight: FontWeight.bold,fontSize: 35,color: bmi_color.toColor())),
                  ),
                  SizedBox(
                  child: Text("$bmi",textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 70,color: Colors.white)),
                      ),
                  SizedBox(
                    width : 330,
                    child: Text(bmi_msg,textAlign: TextAlign.center,style : const TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.grey)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}