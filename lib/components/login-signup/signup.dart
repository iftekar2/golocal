import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:golocal/Components/Login-Signup/login.dart';
import 'package:golocal/components/login-signup/google/google-auth-database.dart';
import 'package:golocal/components/login-signup/google/google-auth.dart';
import 'package:golocal/components/login-signup/google/google-button.dart';
import 'package:golocal/mainPage.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _isPasswordVisible = false;
  String name = "";
  String email = "";
  String password = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  registration() async {
    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      try {
        print("Starting user registration...");
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        print("Firebase Auth successful");

        User? userDetail = userCredential.user;
        if (userDetail != null) {
          Map<String, dynamic> userInfoMap = {
            "email": userDetail.email,
            "name": nameController.text,
            "id": userDetail.uid,
          };
          print("Attempting to add user to database...");
          await Googleauthdatabase().addUser(userDetail.uid, userInfoMap);
          print("User added to database successfully");
        }

        print("Showing success message and navigating...");
        if (!context.mounted) {
          print("Context is not mounted, cannot proceed with navigation");
          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "User has been created Successfully",
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Mainpage()),
          (Route<dynamic> route) => false,
        );
      } on FirebaseAuthException catch (e) {
        String errorMessage = "";
        switch (e.code) {
          case "email-already-in-use":
            errorMessage = "Email already exists";
            break;
          case "weak-password":
            errorMessage = "Password should be at least 6 characters";
            break;
          case "invalid-email":
            errorMessage = "Invalid email address";
            break;
          default:
            errorMessage = "An error occurred during registration";
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orange,
            content: Text(errorMessage, style: TextStyle(fontSize: 20)),
          ),
        );
      } catch (e) {
        print("Unexpected error occurred: $e");
        if (!context.mounted) {
          print("Context not mounted in error handler");
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "An unexpected error occurred: ${e.toString()}",
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromRGBO(248, 247, 243, 1)),
      backgroundColor: const Color.fromRGBO(248, 247, 243, 1),
      body: Padding(
        padding: EdgeInsetsGeometry.only(left: 20, right: 20, top: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),

              SizedBox(height: 5),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Please enter login details below",
                  style: TextStyle(color: Color(0xff4d5152), fontSize: 18),
                ),
              ),

              SizedBox(height: 30),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text("Name", style: TextStyle(fontSize: 20)),
              ),

              SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your Name";
                  }
                  return null;
                },

                controller: nameController,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  // Use hintText and hintStyle
                  hintText: "Enter your name",
                  hintStyle: const TextStyle(
                    color: Color(0xff4d5152),
                    fontSize: 18,
                  ),

                  // Default border for all enabled states
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1.0, // A consistent border width
                    ),
                  ),

                  // Focused border
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 2.0, // A slightly thicker border when focused
                    ),
                  ),

                  // Error border
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.red, width: 1.0),
                  ),

                  // Focused error border
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.red, width: 2.0),
                  ),
                ),
              ),

              SizedBox(height: 30),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text("Email", style: TextStyle(fontSize: 20)),
              ),

              SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your Email";
                  }
                  // Add email format validation
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return "Please enter a valid email address";
                  }
                  return null;
                },

                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  hintStyle: TextStyle(color: Color(0xff4d5152), fontSize: 18),
                  // Set the default border color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.grey, // Default border color
                    ),
                  ),
                  // Set the border color when the text field is focused
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.grey, // Focused border color
                    ),
                  ),
                  // You can also add enabledBorder for consistency
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.grey, // Enabled border color
                    ),
                  ),
                ),

                style: TextStyle(fontSize: 20),
              ),

              SizedBox(height: 30),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text("Password", style: TextStyle(fontSize: 20)),
              ),

              SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your Password";
                  }
                  return null;
                },

                controller: passwordController,
                obscureText: !_isPasswordVisible,

                decoration: InputDecoration(
                  hintText: "Enter your password",
                  hintStyle: TextStyle(color: Color(0xff4d5152), fontSize: 18),

                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),

                style: TextStyle(fontSize: 20),
              ),

              SizedBox(height: 30),
              SizedBox(
                height: 60,
                width: 500,

                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        name = nameController.text;
                        email = emailController.text;
                        password = passwordController.text;
                      });
                      registration();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: const Color.fromARGB(255, 212, 212, 212),
                      thickness: 1,
                      indent: 20,
                    ),
                  ),

                  Text(
                    " Or ",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),

                  Expanded(
                    child: Divider(
                      color: const Color.fromARGB(255, 212, 212, 212),
                      thickness: 1,
                      endIndent: 20,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // This is using google button
              Googlebutton(
                onPressed: () {
                  GoogleAuth().signInWithGoogle(context);
                },
              ),

              SizedBox(height: 30),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(color: Colors.black, fontSize: 18),

                  children: <TextSpan>[
                    TextSpan(
                      text: "Log In",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),

                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigate to the SignUpPage when the text is tapped
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
