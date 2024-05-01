import 'package:flutter/material.dart';

import '../customerWidgets/SquareTile.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController = TextEditingController();

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: const [GestureType.onTap, GestureType.onPanUpdateAnyDirection],
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 30, top: 45),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create an account',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                      SizedBox(height: 8,),
                      Text(
                        'Let’s help you set up your account,\n it won’t take long.',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color.fromRGBO(18, 18, 18, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25, top: 13),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Name',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(18, 18, 18, 1),
                                fontSize: 14
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.grey, width: 1.5, style: BorderStyle.solid, strokeAlign: BorderSide.strokeAlignInside), // Customize border color and width
                                  borderRadius: BorderRadius.circular(10.0),
                                ),

                                hintText: "Enter name",
                                hintStyle: const TextStyle(
                                  color: Color.fromRGBO(200, 200, 200, 1),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                  fontSize: 14,

                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(color: Color.fromRGBO(200, 200, 200, 1)),
                                )
                            ),


                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25, top: 13),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Email',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(18, 18, 18, 1),
                                fontSize: 14
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey, width: 1.5, style: BorderStyle.solid, strokeAlign: BorderSide.strokeAlignInside), // Customize border color and width
                                    borderRadius: BorderRadius.circular(10.0),
                                ),
                                hintText: "Enter email",
                                hintStyle: const TextStyle(
                                  color: Color.fromRGBO(200, 200, 200, 1),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                  fontSize: 11,

                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(color: Color.fromRGBO(200, 200, 200, 1)),
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25, top: 13),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Password',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(18, 18, 18, 1),
                                fontSize: 14
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.grey, width: 1.5, style: BorderStyle.solid, strokeAlign: BorderSide.strokeAlignInside), // Customize border color and width
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                hintText: "Enter password",
                                hintStyle: const TextStyle(
                                  color: Color.fromRGBO(200, 200, 200, 1),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                  fontSize: 11,

                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(color: Color.fromRGBO(200, 200, 200, 1)),
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25, top: 13),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Confirm password',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(18, 18, 18, 1),
                                fontSize: 14
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          TextField(
                            controller: _confirmPasswordController,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.grey, width: 1.5, style: BorderStyle.solid, strokeAlign: BorderSide.strokeAlignInside), // Customize border color and width
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                hintText: "Retype password",
                                hintStyle: const TextStyle(
                                  color: Color.fromRGBO(200, 200, 200, 1),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                  fontSize: 11,

                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(color: Color.fromRGBO(200, 200, 200, 1)),
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Checkbox(
                            side: MaterialStateBorderSide.resolveWith(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return const BorderSide(color: Colors.transparent);
                                }
                                return const BorderSide(color:Color.fromRGBO(255, 156, 0, 1));
                              },
                            ),
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                            checkColor: Colors.green,
                            activeColor: Colors.transparent,
                            splashRadius: 1.0,
                          ),
                          const Text(
                            'Accept terms and conditions',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              color: Color.fromRGBO(255, 156, 0, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Center(
                        child: SizedBox(
                          width: 315,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              //////////////////////////////////
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
                                  'Sign Up',
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
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 90, right: 90, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 1,color: Color.fromRGBO(200, 200, 200, 1),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text(
                            "Or Sign up With",
                            style: TextStyle(
                                color: Color.fromRGBO(200, 200, 200, 1),
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                                fontSize: 11
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Divider(
                              thickness: 1,color: Color.fromRGBO(200, 200, 200, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SquareTile(
                          imagePath: 'assets/icons/google.png',
                          onTap: (){
                            ///////////////////////////////////////
                          },
                        ),
                        const SizedBox(width: 30,),
                        SquareTile(
                          imagePath: 'assets/icons/facebook.png',
                          onTap: (){
                            ///////////////////////////////////////
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already a member?",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          onPressed: (){
                            Navigator.pushNamed(context, '/login');
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Color.fromRGBO(255, 156, 0, 1),
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),


              ],
            ),
          ),
        )
      ),
    );
  }
}
