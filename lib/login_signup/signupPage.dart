import 'package:flutter/material.dart';
import 'package:golocal/login_signup/loginPage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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

      backgroundColor: Color.fromARGB(246, 255, 255, 250),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage(
                  "https://img.freepik.com/free-vector/hand-drawn-frog-cartoon-illustration_23-2151342213.jpg",
                ),
                height: 300,
                width: 300,
              ),

              SizedBox(height: 10),

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

                          label: Text("Email"),

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

                    SizedBox(height: 10),

                    Container(
                      height: 60,
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

                          label: Text("Username"),

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

                    SizedBox(height: 10),

                    Container(
                      height: 60,
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
                        "Sign up",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),

                    SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                            height: 1,
                            thickness: 1,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Or",
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ),

                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                            height: 1,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            color: const Color.fromARGB(255, 177, 177, 177),
                          ),
                        ),

                        minimumSize: Size(double.infinity, 60),
                      ),

                      onPressed: () {},

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "lib/welcome_page/google-logo.png",
                            height: 30,
                            width: 30,
                          ),

                          SizedBox(width: 10),

                          Text(
                            "Sign up with Google",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(fontSize: 16),
                        ),

                        SizedBox(width: 5),

                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Log in",
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
