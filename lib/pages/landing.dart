import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/landing.png',
            height: 79,
            width: 79,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              Container(
                child:Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/chef.png',
                        width: 110,
                        height: 110,

                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text(
                          '100k+ Premium Recipe',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            fontFamily: 'Poppins',
                            color: Colors.white
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 170),
                  child: Column(
                    children: [
                      const Text(
                        textAlign: TextAlign.center,
                        'Get\n Cooking',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      const Text(
                        'Simple way to find Tasty Recipe',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                        child: SizedBox(
                          width: 243,
                          height: 54,
                          child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(18, 149, 117, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Start Cooking',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Color(0xFFFFFFFF)
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  Image.asset(
                                    'assets/icons/arrow-right.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                ],
                              ),
                          ),
                        ),
                      ),
                    ],

                  ),
                ),
              ),
            ],
          ),
        ],
      ),

    );
  }
}
