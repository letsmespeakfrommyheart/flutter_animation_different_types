import 'package:flutter/material.dart';
import 'package:animate_icons/animate_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:avatar_view/avatar_view.dart';
import 'package:flutter_animation_different_types01/animated_page_route.dart';
import 'package:flutter_animation_different_types01/hero_page.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late final AnimationController _avatarController;
  late final AnimationController _aroundController;
  late final AnimationController _dropDownController;
  late final AnimateIconController _iconController;
  bool dropDownRise = false;

  @override
  void initState() {
    super.initState();
    _avatarController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _dropDownController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _avatarController.forward();
    _iconController = AnimateIconController();
    _aroundController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _aroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Different types of Animation',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber.shade300,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RotationTransition(
                turns: _aroundController,
                child: Image.asset('assets/images/ball.png', height: 120),
              ),
              const SizedBox(height: 10),
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  height: 50,
                  width: double.infinity,
                  child: GestureDetector(
                    child: ListTile(
                      leading: const Icon(
                        Icons.emoji_events_outlined,
                        color: Colors.amber,
                      ),
                      title: Text(
                        "Jake Chambers",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                      trailing: AnimateIcons(
                        startIconColor: Colors.amber,
                        endIconColor: Colors.black,
                        startIcon: Icons.arrow_downward_outlined,
                        endIcon: Icons.arrow_upward_outlined,
                        controller: _iconController,
                        size: 20.0,
                        onStartIconPress: () {
                          dropDownRise = false;
                          _dropDownController.forward();
                          return true;
                        },
                        onEndIconPress: () {
                          dropDownRise = true;
                          _dropDownController.reverse();
                          return true;
                        },
                        duration: const Duration(milliseconds: 500),
                        clockwise: false,
                      ),
                    ),
                  )),
              const SizedBox(height: 10),
              SizeTransition(
                  sizeFactor: _dropDownController,
                  axis: Axis.vertical,
                  axisAlignment: -1,
                  child: ListTile(
                      contentPadding: const EdgeInsets.only(left: 30),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Club: Manchester United",
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(
                            'Position: Attacking midlefielder',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(
                            'Date of birth: 12 Aug 1987',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ))),
              const SizedBox(height: 10),
              Hero(
                tag: 'Avatar Jake',
                child: Card(
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FadeTransition(
                        opacity: CurvedAnimation(
                            parent: _avatarController, curve: Curves.linear),
                        child: AvatarView(
                          radius: 40,
                          borderColor: Colors.amber.shade300,
                          avatarType: AvatarType.CIRCLE,
                          backgroundColor: Colors.red,
                          imagePath: "assets/images/jake.png",
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            backgroundColor: MaterialStateProperty.all(
                                Colors.amber.shade300),
                            fixedSize:
                                MaterialStateProperty.all(const Size(150, 30)),
                            shadowColor: MaterialStateProperty.all(Colors.grey),
                          ),
                          child: const Text(
                            'Show main photo',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HeroPage(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            backgroundColor: MaterialStateProperty.all(
                                Colors.amber.shade300),
                            fixedSize:
                                MaterialStateProperty.all(const Size(150, 30)),
                            shadowColor: MaterialStateProperty.all(Colors.grey),
                          ),
                          child: const Text('Show gallery',
                              style: TextStyle(color: Colors.black)),
                          onPressed: () {
                            Navigator.of(context).push(PageTransition(
                                duration: const Duration(milliseconds: 800),
                                child: const AnimatedPage(),
                                type: PageTransitionType.fade));
                          },
                        ),
                      ],
                    ),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
