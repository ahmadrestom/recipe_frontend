import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Providers/UserProvider.dart';
import 'package:recipe_app/models/UserManagement/userAuthentication.dart';
import 'package:recipe_app/pages/NavPage.dart';
import 'package:recipe_app/services/UserServices/AuthService.dart';
import '../customerWidgets/SquareTile.dart';

class LoginPage extends StatefulWidget {
  final AuthService authService;
  const LoginPage({super.key, required this.authService});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {



  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _isLoading = false;
  final AuthService authService = AuthService();

  bool _isPasswordVisible = false;



  Future<void> _login() async{
    setState(() {
      _isLoading = true;
    });

    String? firebaseToken = await FirebaseMessaging.instance.getToken();
    UserAuthentication userAuth = UserAuthentication(
        email: _emailController.text, password: _password.text
    );

    try{
      widget.authService.login(userAuth);
    }finally{
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context){

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return KeyboardDismisser(
      gestures: const [GestureType.onPanUpdateAnyDirection, GestureType.onTap],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: _isLoading
            ? Lottie.asset(
            'assets/loader.json'
        )
            : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 94, left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 30
                      ),
                    ),
                    Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 20
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
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
                            borderSide: const BorderSide(color: Colors.grey, width: 1.5, style: BorderStyle.solid, strokeAlign: BorderSide.strokeAlignInside),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        hintText: "Enter email",
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
                padding: const EdgeInsets.only(left: 25, right: 25, top: 40),
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
                      obscureText: !_isPasswordVisible,
                      obscuringCharacter: '*',
                      controller: _password,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey, width: 1.5, style: BorderStyle.solid, strokeAlign: BorderSide.strokeAlignInside),
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
                          ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(35,30,0,0),
                child: Container(
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 156, 0, 1),
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight*0.05),
                child: Center(
                  child: SizedBox(
                    width: screenWidth*0.8,
                    height: screenHeight*0.06,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_emailController.text.isEmpty) {
                          CherryToast.error(
                            toastPosition: Position.bottom,
                            title: const Text("Enter your email"),
                            animationType: AnimationType.fromBottom,
                            animationDuration: const Duration(milliseconds: 500),
                            autoDismiss: true,
                          ).show(context);
                          return;
                        }
                        if (_password.text.isEmpty) {
                          CherryToast.error(
                            toastPosition: Position.bottom,
                            title: const Text("Enter your password"),
                            animationType: AnimationType.fromBottom,
                            animationDuration: const Duration(milliseconds: 500),
                            autoDismiss: true,
                          ).show(context);
                          return;
                        }
                        try {
                          final userProvider = Provider.of<UserProvider>(context, listen: false);
                          final userAuth = UserAuthentication(
                            email: _emailController.text,
                            password: _password.text,
                          );
                          final response = await userProvider.login(userAuth);
                          if (!response) {
                            CherryToast.error(
                              toastPosition: Position.bottom,
                              title: const Text("Invalid email or password"),
                              animationType: AnimationType.fromBottom,
                              animationDuration: const Duration(milliseconds: 500),
                              autoDismiss: true,
                            ).show(context);
                            return;
                          } else {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (userProvider.isAuthenticated) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const NavPage(),
                                  ),
                                );
                              } else {
                                _emailController.text = '';
                                _password.text = '';
                                CherryToast.error(
                                  toastPosition: Position.bottom,
                                  title: const Text("Unable to login"),
                                  animationType: AnimationType.fromBottom,
                                  animationDuration: const Duration(milliseconds: 500),
                                  autoDismiss: true,
                                ).show(context);
                              }
                            });
                          }
                        } catch (e) {
                          CherryToast.error(
                            toastPosition: Position.bottom,
                            title: const Text("An error occurred. Please try again."),
                            animationType: AnimationType.fromBottom,
                            animationDuration: const Duration(milliseconds: 500),
                            autoDismiss: true,
                          ).show(context);
                        }
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
                            'Sign In',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xFFFFFFFF)
                            ),
                          ),
                          SizedBox(width: screenWidth*0.03,),
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
              SizedBox(height: screenHeight*0.05,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth*0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                        child: Divider(
                          thickness: 2,color: Color.fromRGBO(200, 200, 200, 1),
                        ),
                    ),
                    //SizedBox(width: ,),
                    Text(
                        "    Or Sign in With    ",
                      style: TextStyle(
                        color: const Color.fromRGBO(200, 200, 200, 1),
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Poppins',
                        fontSize: screenWidth*0.03
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        thickness: 2,color: Color.fromRGBO(200, 200, 200, 1),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight*0.05,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(
                    imagePath: 'assets/icons/google.png',
                    onTap: (){
                      ///////////////////////////////////////
                    },
                  ),
                  SizedBox(width: screenWidth*0.1,),
                  SquareTile(
                    imagePath: 'assets/icons/facebook.png',
                    onTap: (){
                      ///////////////////////////////////////
                    },
                  ),
                ],
              ),
              SizedBox(height: screenHeight*0.04,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Dont have an account?",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text(
                        'Sign Up',
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
        ),
      ),
    );
  }
}
