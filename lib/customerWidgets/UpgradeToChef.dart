import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class UserProfilePage extends StatefulWidget {
  final String? email; // Email passed to the widget

  UserProfilePage({required this.email}); // Constructor to accept email

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with SingleTickerProviderStateMixin {
  bool isLocked = true; // Initial state of the lock
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
                    borderRadius: BorderRadius.circular(_borderRadiusAnimation.value),
                    child: Container(
                      decoration: BoxDecoration(
                        color: _colorAnimation.value,
                        borderRadius: BorderRadius.circular(_borderRadiusAnimation.value),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      width: screenWidth * 0.9,
                      height: 500,
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
                                child: ElevatedButton(
                                  onPressed: isLocked
                                      ? null
                                      : () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Form submitted!'),
                                      ),
                                    );
                                  },
                                  style: ButtonStyle(
                                    padding: WidgetStateProperty.all(
                                      const EdgeInsets.symmetric(vertical: 16.0, horizontal: 50.0), // Horizontal padding for balance
                                    ),
                                    shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30), // Slightly rounded corners
                                      ),
                                    ),
                                    backgroundColor: WidgetStateProperty.all(
                                      const Color.fromRGBO(18, 149, 117, 1), // Soft green background
                                    ),
                                    shadowColor: WidgetStateProperty.all(Colors.greenAccent.withAlpha(1)), // Subtle shadow
                                    elevation: WidgetStateProperty.all(5), // Elevation for a floating effect
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
                      transitionBuilder: (child, animation) => ScaleTransition(
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
          border: InputBorder.none, // Remove the border
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildTextField('Location'),
            const SizedBox(height: 16),
            _buildPhoneNumberField(),
            const SizedBox(height: 16),
            _buildTextField('Years of Experience', keyboardType: TextInputType.number),
            const SizedBox(height: 16),
            _buildTextField('Bio', maxLines: 3),
          ],
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
        inputDecoration: InputDecoration(
          labelText: 'Phone Number',
          border: InputBorder.none, // Remove the border
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        keyboardType: TextInputType.phone,
      ),
    );
  }

  Widget _buildTextField(String label, {TextInputType? keyboardType, int maxLines = 1}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none, // Remove the border
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
      ),
    );
  }
}
