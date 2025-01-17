import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
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



  Future<void> _login() async{
    setState(() {
      _isLoading = true;
    });

    UserAuthentication userAuth = UserAuthentication(
        email: _emailController.text, password: _password.text
    );

    try{
      widget.authService.login(userAuth);
      print('Login successful');
    }catch(e){
      print('error: $e');
    }finally{
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return KeyboardDismisser(
      gestures: const [GestureType.onPanUpdateAnyDirection, GestureType.onTap],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: _isLoading
            ? const CircularProgressIndicator()
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
                            borderSide: const BorderSide(color: Colors.grey, width: 1.5, style: BorderStyle.solid, strokeAlign: BorderSide.strokeAlignInside), // Customize border color and width
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
                      obscureText: true,
                      obscuringCharacter: '*',
                      controller: _password,
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
                padding: const EdgeInsets.only(top: 38.0),
                child: Center(
                  child: SizedBox(
                    width: 315,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async{
                        final userProvider = Provider.of<UserProvider>(context, listen: false);
                        final userAuth = UserAuthentication(
                            email: _emailController.text,
                            password: _password.text
                        );
                        await userProvider.login(userAuth);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (userProvider.isAuthenticated){
                        print("XXX");
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NavPage(),
                          ),
                        );
                      } else {
                        print("CCC");
                        _emailController.text = '';
                        _password.text = '';
                        showToast('This is normal toast with animation',
                          context: context,
                          animation: StyledToastAnimation.scale,
                        );

                      }
                        });
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
              const SizedBox(height: 20,),
              const Padding(
                padding: EdgeInsets.only(left: 90, right: 90),
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
                        "Or Sign in With",
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
              const SizedBox(height: 20,),
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
