import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth.dart';

import '../../shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: const Text(''),
              actions: <Widget>[
                TextButton.icon(
                  icon: const Icon(Icons.app_registration),
                  label: const Text('Registration'),
                  onPressed: () {
                    widget.toggleView();
                  },
                )
              ],
            ),
            body: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 50.0),
                    const Text(
                      "Diamond Chat",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      "Log in to communicate",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 80.0),
                    TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          helperText: ' ',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Enter an email' : null,
                        onChanged: (value) {
                          setState(() => email = value);
                        }),
                    const SizedBox(height: 9.0),
                    TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          helperText: ' ',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.key,
                          ),
                        ),
                        obscureText: true,
                        validator: (value) => value!.length < 6
                            ? "Enter a password 6+ chars long"
                            : null,
                        onChanged: (value) {
                          setState(() => password = value);
                        }),
                    const SizedBox(height: 20.0),
                    OutlinedButton.icon(
                        label: const Text("Sign in"),
                        icon: const Icon(Icons.login),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() => error = 'sign in error');
                              loading = false;
                            }
                          }
                        }),
                    const SizedBox(height: 10.0),
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    const SizedBox(height: 15.0),
                    /*ElevatedButton.icon(
                      icon: Icon(Icons.person),
                      label: const Text('Sign in anon'),
                      onPressed: () async {
                        setState(() => loading = true);
                        dynamic result = await _auth.signInAnon();
                        if (result == null) {
                          print('error signing in');
                          loading = false;
                        } else {
                          print('signed in');
                          print(result.uid);
                          loading = false;
                        }
                      },
                    ),*/
                  ],
                ),
              ),
            ),
          );
  }
}
