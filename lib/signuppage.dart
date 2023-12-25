// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signup/verification_code.dart';
import 'constant_variables.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  var _username = '';
  var _email = '';
  var _password = '';
  var isPasswordHidden = true;

  void register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final url = Uri.parse('$address/register');

      final response = await http.post(
        url,
        headers: {'Content-type': 'application/json'},
        body: json.encode(
          {
            'username': _username,
            'email': _email,
            'password': _password,
          },
        ),
      );

      print(response.statusCode);
      print(json.decode(response.body));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerificationCode(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: 320,
                height: 427,
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 43),
                      Text(
                        "Sign Up",
                        style: GoogleFonts.laila(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 43),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.purple),
                        ),
                        surfaceTintColor: Colors.white,
                        child: TextFormField(
                          style: GoogleFonts.laila(),
                          decoration: InputDecoration(
                            hintText: 'Username',
                            hintStyle: GoogleFonts.laila(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Enter a valid username.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _username = value!;
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.purple),
                        ),
                        surfaceTintColor: Colors.white,
                        child: TextFormField(
                          style: GoogleFonts.laila(),
                          decoration: InputDecoration(
                            hintText: 'Smail Id',
                            hintStyle: GoogleFonts.laila(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            border: InputBorder.none,
                          ),
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
                      const SizedBox(height: 12),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.purple),
                        ),
                        surfaceTintColor: Colors.white,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                obscureText: isPasswordHidden,
                                style: GoogleFonts.laila(),
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: GoogleFonts.laila(),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.length < 7) {
                                    return 'Your password must have more than 7 characters.';
                                  }
                                  return null;
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
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: register,
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
                            width: 220,
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                              'Verify',
                              style: GoogleFonts.laila(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
