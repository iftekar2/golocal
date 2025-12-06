import 'package:flutter/material.dart';
import 'package:golocal/login_signup/forgotPasswordPage.dart';
import 'package:golocal/login_signup/signupPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color.fromARGB(246, 255, 255, 250)],
            ),
          ),
        ),
      ),

      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: NetworkImage(
                  "https://img.freepik.com/free-vector/hand-drawn-retro-cartoon-coloring-illustration_52683-159886.jpg",
                ),
                height: 300,
                width: 300,
              ),

              SizedBox(height: 20),
              Container(
                child: Column(
                  children: [
                    SizedBox(height: 10),

                    Container(
                      height: 60,
                      child: TextField(
                        maxLines: null,
                        expands: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 169, 169, 169),
                              width: 2.0,
                            ),
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 169, 169, 169),
                              width: 2.0,
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 169, 169, 169),
                              width: 2.0,
                            ),
                          ),

                          label: Text("Email or Username"),

                          labelStyle: TextStyle(
                            fontSize: 20,
                            color: const Color.fromARGB(255, 119, 119, 119),
                            fontWeight: FontWeight.w500,
                          ),

                          floatingLabelStyle: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        style: TextStyle(fontSize: 20),
                      ),
                    ),

                    SizedBox(height: 20),

                    Container(
                      height: 70,
                      child: TextField(
                        obscureText: !_passwordVisible,
                        maxLines: 1,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 169, 169, 169),
                              width: 2.0,
                            ),
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 169, 169, 169),
                              width: 2.0,
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 169, 169, 169),
                              width: 2.0,
                            ),
                          ),

                          label: Text("Password"),

                          labelStyle: TextStyle(
                            fontSize: 20,
                            color: const Color.fromARGB(255, 119, 119, 119),
                            fontWeight: FontWeight.w500,
                          ),

                          floatingLabelStyle: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),

                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),

                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),

                        style: TextStyle(fontSize: 20),
                      ),
                    ),

                    SizedBox(height: 10),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage(),
                          ),
                        );
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        minimumSize: Size(double.infinity, 60),
                      ),

                      onPressed: () {},
                      child: Text(
                        "Log in",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),

                    SizedBox(height: 50),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(fontSize: 16),
                        ),

                        SizedBox(width: 5),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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
