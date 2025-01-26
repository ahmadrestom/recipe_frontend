import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Providers/UserProvider.dart';
import 'package:recipe_app/services/UserServices/AuthService.dart';

import '../pages/ThankYouPage.dart';

class UserProfilePage extends StatefulWidget {
  final String? email; // Email passed to the widget

  const UserProfilePage({super.key, required this.email}); // Constructor to accept email

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  bool isLocked = true;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _borderRadiusAnimation;

  // To store phone number and country code
  String phoneNumber = '';
  PhoneNumber? number = PhoneNumber(isoCode: 'US'); // Default country is US

  @override
  void initState() {

    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _colorAnimation = ColorTween(
      begin: Colors.grey[300],
      end: Colors.white,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _borderRadiusAnimation = Tween<double>(begin: 16, end: 32).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _locationController.dispose();
    _experienceController.dispose();
    _bioController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void toggleLock() {
    setState(() {
      isLocked = !isLocked;
      if (isLocked) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Stack(
              children: [
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        _borderRadiusAnimation.value),
                    child: Container(
                      decoration: BoxDecoration(
                        color: _colorAnimation.value,
                        borderRadius: BorderRadius.circular(
                            _borderRadiusAnimation.value),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.8,
                      child: AbsorbPointer(
                        absorbing: isLocked,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Email field
                              _buildEmailField(),
                              const SizedBox(height: 16),

                              // Title Section
                              _buildTitleSection(),

                              const SizedBox(height: 16),

                              // Registration Form
                              _buildFormFields(),

                              const SizedBox(height: 20),
                              Center(
                                child: _buildSubmitButton(),
                              )


                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: toggleLock,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) =>
                          ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                      child: Container(
                        key: ValueKey(isLocked),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isLocked
                              ? Colors.red
                              : const Color.fromRGBO(18, 149, 117, 1),
                          boxShadow: [
                            BoxShadow(
                              color: isLocked
                                  ? Colors.redAccent.withOpacity(0.6)
                                  : Colors.greenAccent.withOpacity(0.6),
                              blurRadius: 10,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          isLocked ? Icons.lock : Icons.lock_open,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        initialValue: widget.email,
        readOnly: true, // Make it read-only
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: widget.email,
          border: InputBorder.none,
          // Remove the border
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Chef Registration',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(18, 149, 117, 1),
          ),
        ),
        AnimatedOpacity(
          opacity: isLocked ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: const Icon(
            Icons.lock,
            color: Colors.red,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildFormFields() {
    return Expanded(
      child: Form(
        key: _formKey, // Associate form with the key
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextField(controller: _locationController,'Location', validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Location is required';
                }
                return null;
              }),
              const SizedBox(height: 16),
              _buildPhoneNumberField(),
              const SizedBox(height: 16),
              _buildTextField(controller: _experienceController,'Years of Experience',
                  keyboardType: TextInputType.number, validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Years of experience are required';
                    }
                    return null;
                  }),
              const SizedBox(height: 16),
              _buildTextField(controller: _bioController,'Bio', maxLines: 5, validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Bio is required';
                }
                return null;
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: InternationalPhoneNumberInput(
        onInputChanged: (PhoneNumber number) {
          setState(() {
            this.number = number;
            phoneNumber = number.phoneNumber ?? '';
          });
        },
        initialValue: number,
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.DIALOG,
          showFlags: true,
        ),
        inputDecoration: const InputDecoration(
          labelText: 'Phone Number',
          border: InputBorder.none, // Remove the border
          filled: true,
          contentPadding: EdgeInsets.symmetric(
              horizontal: 20, vertical: 16),
        ),
        keyboardType: TextInputType.phone,
      ),
    );
  }

  Widget _buildTextField(String label,
      {required TextEditingController controller,TextInputType? keyboardType, int maxLines = 1, String? Function(String?)? validator}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          filled: true,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator, // Add validator here
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: isLocked
            ? null
            : () async{
          if (_formKey.currentState?.validate() ?? false) {
            final userProvider = Provider.of<UserProvider>(context,listen:false);
            final success = await userProvider.upGradeToChef(
              _locationController.value.text,
              phoneNumber,
              int.parse(_experienceController.value.text),
              _bioController.value.text
            );
            if(mounted){
              if(success){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Form submitted!'),
                  ),
                );
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ThankYouPage(),
                  ),
                );
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('An error occurred during the upgrade'),
                  ),
                );
              }
            }
          } else {
            CherryToast.warning(
              description:  const Text("Please fill all the fields", style: TextStyle(color: Colors.black)),
              animationType:  AnimationType.fromBottom,
              animationDuration:  const Duration(milliseconds:  1000),
              autoDismiss:  true,
              toastPosition: Position.bottom,
            ).show(context);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isLocked ? Colors.red : const Color(0xFF129575),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 50.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(
          'Submit',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}