import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:today/presentation/neumorphism_widget.dart';
import 'package:today/presentation/sign/auth_viewmodel.dart';


const distance = 16.0;

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _idCont = TextEditingController();
  final TextEditingController _passwordCont = TextEditingController();
  bool _isShowEmailDelete = false;
  bool _isShowPasswordDelete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: boxDecoration,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 28.0, horizontal: 14.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 14.0,
                  ),
                  Text(
                    'Photo Diary',
                    style: GoogleFonts.getFont(
                      'Nanum Gothic',
                      fontSize: 28.0,
                    ),
                  ),
                  const SizedBox(
                    height: 14.0,
                  ),
                  TextField(
                    controller: _idCont,
                    onChanged: (email) {
                      setState(() {
                        _isShowEmailDelete = email.isNotEmpty;
                      });
                    },
                    decoration: InputDecoration(
                      label: const Text('e-mail'),
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.email_outlined),
                      suffix: _isShowEmailDelete
                          ? GestureDetector(
                              child: const Icon(Icons.cancel),
                              onTap: () {
                                _idCont.clear();
                              },
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(
                    height: 14.0,
                  ),
                  TextField(
                    controller: _passwordCont,
                    obscureText: true,
                    onChanged: (password) {
                      setState(() {
                        _isShowPasswordDelete = password.isNotEmpty;
                      });
                    },
                    decoration: InputDecoration(
                      label: const Text('password'),
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.password),
                      suffix: _isShowPasswordDelete
                          ? GestureDetector(
                              child: const Icon(Icons.cancel),
                              onTap: () {
                                _passwordCont.clear();
                              },
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(
                    height: 14.0,
                  ),
                  GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 48.0,
                      decoration: btnBoxDecoration,
                      child: const Center(
                        child: Text('Login'),
                      ),
                    ),
                    onTap: () {
                      context.read<AuthViewModel>().onSignIn(_idCont.text, _passwordCont.text);
                    },
                  ),
                  const SizedBox(
                    height: 14.0,
                  ),
                  GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 48.0,
                      decoration: btnBoxDecoration,
                      child: const Center(
                        child: Text('SignUp'),
                      ),
                    ),
                    onTap: () {
                      context.read<AuthViewModel>().onSignUp(_idCont.text, _passwordCont.text);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
