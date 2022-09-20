import 'package:bloc_login_clean/business_logic/blocs/login_bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../Widgets/login_btn.dart';
import '../Widgets/social_btn.dart';
import '../Widgets/text_form_field.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late FocusNode emailFocus;
  late FocusNode passwordFocus;
  late FocusNode loginBtnFocus;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    loginBtnFocus = FocusNode();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    loginBtnFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  'Digite um E-mail/Senha Válida',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          } else if (state is LoginLoadedState) {
            clearTextData();
            Navigator.of(context).pushNamed('/home', arguments: state.email);
          }
        },
        builder: (context, state) {
          if (state is LoginLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return _buildLoginScreen();
          }
        },
      ),
    );
  }

  Widget _buildLoginScreen() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/secure_login.json'),
              InputField(
                obscureText: false,
                focusNode: emailFocus,
                label: 'E-mail',
                icons: const Icon(Icons.person, color: Colors.blue),
                textController: emailController,
              ),
              const SizedBox(
                height: 20,
              ),
              InputField(
                obscureText: true,
                focusNode: passwordFocus,
                label: 'Senha',
                icons: const Icon(Icons.security, color: Colors.blue),
                textController: passwordController,
              ),
              const SizedBox(
                height: 20,
              ),
              LoginBtn(
                email: emailController,
                focusNode: loginBtnFocus,
                password: passwordController,
              ),
              const SizedBox(
                height: 55,
              ),
              const SocialSignIn(),
            ],
          ),
        ),
      ),
    );
  }

  clearTextData() {
    emailController.clear();
    passwordController.clear();
  }
}
