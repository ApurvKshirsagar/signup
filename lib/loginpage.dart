import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signup/signuppage.dart';
import 'constant_variables.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var _email = '';
  var _password = '';
  var isPasswordHidden = true;

  void login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final url = Uri.parse('$address/login');

      final response = await http.post(
        url,
        headers: {'Content-type': 'application/json'},
        body: json.encode(
          {
            'user-id': _email,
            'password': _password,
          },
        ),
      );

      print(response.statusCode);
      print(json.decode(response.body));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 120),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF9867C5),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'logo',
                      style: GoogleFonts.laila(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 43),
                Text(
                  'Welcome Back',
                  style: GoogleFonts.laila(
                    fontWeight: FontWeight.w600, // Semibold
                    fontSize: 28,
                    color: Color(0xFF461B6A), // Purple color
                  ),
                ),
                Text(
                  "Hello there! Sign In to continue.",
                  style: GoogleFonts.laila(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(155, 122, 122, 108),
                  ),
                ),
                SizedBox(height: 30),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    style: GoogleFonts.laila(),
                    decoration: InputDecoration(
                      hintText: 'Smail Id',
                      hintStyle: GoogleFonts.laila(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          !EmailValidator.validate(value)) {
                        return 'Enter a valid email id.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          obscureText: isPasswordHidden,
                          style: GoogleFonts.laila(),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: GoogleFonts.laila(),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Enter your password';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            _password = value!;
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordHidden = !isPasswordHidden;
                          });
                        },
                        icon: (isPasswordHidden)
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 207),
                  child: TextButton(
                    onPressed: () {},
                    // style: TextButton.styleFrom(
                    //   padding: const EdgeInsets.all(0),
                    // ),
                    child: Text(
                      "Forgot Password?",
                      style: GoogleFonts.laila(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [Color(0xff9867c5), Color(0xffff8dc7)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      width: 300,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        'Get Started',
                        style: GoogleFonts.laila(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 13),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account? ",
                        style: GoogleFonts.laila(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => const SignupPage()),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                        ),
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.laila(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}