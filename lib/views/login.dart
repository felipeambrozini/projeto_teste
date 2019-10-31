import 'package:flutter/material.dart';
import 'package:projeto_teste/services/auth.dart';
import 'package:projeto_teste/views/cadastro.dart';
import 'package:projeto_teste/views/menu.dart';

class Login extends StatefulWidget {
static const String routeName = '/login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();
  bool _obscurePassword = true;


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _showEmailTextField(),
              _showPasswordTextField(),
              _showSignInButton(),
              _showSignUpButton(),
            ],
          ),
        ),
      ),
    );
  }

Widget _showEmailTextField() {
    return TextField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration:
          InputDecoration(hintText: 'Email', prefixIcon: Icon(Icons.email)),
    );
  }

  void _toggleObscurePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

 Widget _showPasswordTextField() {
    return TextField(
      controller: _passwordController,
      keyboardType: TextInputType.text,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        hintText: 'Senha',
        prefixIcon: Icon(Icons.vpn_key),
        suffixIcon: IconButton(
          icon:
              Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
          onPressed: _toggleObscurePassword,
        ),
      ),
    );
  }

  Future _signIn() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    await Auth.signIn(email, password).then(_onResultSignInSuccess);
  }

  void _onResultSignInSuccess(String userId) {
    print('SignIn: $userId');
    Navigator.of(context).pushReplacementNamed(Menu.routeName);
  }

  Widget _showSignInButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: RaisedButton(child: Text('Login'), onPressed: _signIn),
    );
  }

  void _signUp() {
    Navigator.of(context).pushReplacementNamed(Cadastro.routeName);
  }

  Widget _showSignUpButton() {
    return FlatButton(child: Text('Registrar-se'), onPressed: _signUp);
  }

}
