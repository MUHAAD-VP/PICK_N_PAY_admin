import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 86, 121),
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                stops: [
                  0.0,
                  0.6,
                ],
                end: Alignment.bottomCenter,
                colors: [Color.fromARGB(255, 0, 86, 121), Colors.white],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade500,
                  blurRadius: 2.0,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.all(10.0),
              width: 400.0,
              height: 500.0,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  stops: [
                    0.0,
                    0.6,
                  ],
                  end: Alignment.bottomCenter,
                  colors: [Color.fromARGB(184, 120, 186, 212), Colors.white],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    blurRadius: 2.0,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image(
                          height: 200,
                          width: 200,
                          image: NetworkImage(
                            'images/p&plogo.png',
                          )
                          // Add your logo image path

                          ),
                    ),
                    Center(
                      child: const SizedBox(height: 15.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 40, top: 0, right: 40, bottom: 7),
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Email",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: const Color.fromARGB(255, 0, 0, 0)),
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
                      ),
                    ),
                    Center(
                      child: const SizedBox(height: 15.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 40, top: 7, right: 40, bottom: 7),
                      child: TextField(
                        obscureText: isObscure,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              isObscure = !isObscure;
                              setState(() {});
                            },
                            icon: Icon(isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: const Color.fromARGB(255, 0, 0, 0)),
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 100, right: 100),
                      child: ElevatedButton(
                          child: const Text('Login'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 0, 86, 121),
                              foregroundColor: Colors.white,
                              minimumSize: Size(350, 50),
                              textStyle: const TextStyle(
                                  fontSize: 20, fontStyle: FontStyle.normal)),
                          onPressed: () {}),
                    ),
                    Center(
                        child: TextButton(
                      onPressed: () {},
                      child: const Text('Forget Password?'),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
