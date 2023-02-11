import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth.dart';
import '../../shared/loading.dart';

class Registration extends StatefulWidget {
  final Function toggleView;
  const Registration({super.key, required this.toggleView});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String name = '';
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: const Text(' '),
              centerTitle: true,
              actions: <Widget>[
                TextButton.icon(
                  icon: const Icon(Icons.login_outlined),
                  label: const Text('Log in'),
                  onPressed: () {
                    widget.toggleView();
                  },
                )
              ],
            ),
            body: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 100.0),
                    const Text('Registration to Diamond Chat'),
                    const SizedBox(height: 50.0),
                    TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          helperText: ' ',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(
                            Icons.person,
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Enter your name' : null,
                        onChanged: (value) {
                          setState(() => name = value);
                        }),
                    const SizedBox(height: 10.0),
                    TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          helperText: ' ',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(
                            Icons.email,
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Enter an email' : null,
                        onChanged: (value) {
                          setState(() => email = value);
                        }),
                    const SizedBox(height: 10.0),
                    TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          helperText: ' ',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(
                            Icons.password,
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
                    ElevatedButton.icon(
                        icon: const Icon(Icons.app_registration_rounded),
                        label: const Text(
                          'Registration',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            dynamic result =
                                await _auth.registerWithEmailAndPassword(
                                    name, email, password);
                            if (result == null) {
                              setState(() => error = 'enter valid email');
                              loading = false;
                            }
                          }
                        }),
                    const SizedBox(height: 12.0),
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
