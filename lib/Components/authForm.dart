import 'package:appprodutosestados/Components/formFieldDecoration.dart';
import 'package:appprodutosestados/Models/auth.dart';
import 'package:appprodutosestados/exceptions/authException.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode { SignUp, Login }

class Authform extends StatefulWidget {
  @override
  State<Authform> createState() => _AuthformState();
}

class _AuthformState extends State<Authform> {
  AuthMode _authMode = AuthMode.Login;

  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //bools borders--------------
  bool _emailError = false;
  bool _passwordError = false;
  bool _rPasswordError = false;
  //---------------------------

  bool _isLoading = false;
  bool _isLogin() => _authMode == AuthMode.Login;
  bool _isSignUp() => _authMode == AuthMode.SignUp;

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Ocorreu um erro'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: Text(
              "Fechar",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.SignUp;
      } else {
        _authMode = AuthMode.Login;
      }
    });
  }

  Map<String, String> _authData = {'email': '', 'password': ''};

  //método para login ou cadastro
  Future<void> _submit() async {
    final _isValid = _formKey.currentState?.validate() ?? false;

    if (!_isValid) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _formKey.currentState?.save();

    Auth auth = Provider.of<Auth>(context, listen: false);

    try {
      if (_isLogin()) {
        await auth.login(_authData['email']!, _authData['password']!);
      } else {
        await auth.signUp(_authData['email']!, _authData['password']!);
      }
    } on Authexception catch (error) {
      _showErrorDialog(error.toString());
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      height: _isLogin() ? deviceSize.height * 0.7 : deviceSize.height * 0.80,
      width: deviceSize.width * 0.90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              //serve para girar um container específico
              /* transform: Matrix4.rotationZ(-8 * pi / 180)
                              ..translateByDouble(-1, -1, -1, -1),*/
              child: Text("Lojinha", style: TextStyle(fontSize: 45)),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              //-----------------------------------------------------------
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    //Email ------------------------------
                    Formfielddecoration(
                      error: _emailError,
                      child: TextFormField(
                        cursorColor: Colors.black,
                        cursorErrorColor: Colors.red,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Email",
                          labelStyle: TextStyle(
                            color: _emailError ? Colors.red : Colors.black,
                          ),
                          errorStyle: TextStyle(color: Colors.red),
                        ),
                        onSaved: (email) => _authData['email'] = email ?? '',
                        validator: (_email) {
                          final email = _email ?? '';
                          bool error = false;
                          String? errormsg;
                          if (_isSignUp()) {
                            if (email.trim().isEmpty || !email.contains('@')) {
                              error = true;
                              errormsg = 'Email inválido.';
                            }
                          }
                          setState(() {
                            _emailError = error;
                          });
                          return errormsg;
                        },
                      ),
                    ),

                    //Senha --------------------------------
                    Formfielddecoration(
                      error: _passwordError,
                      child: TextFormField(
                        cursorColor: Colors.black,
                        cursorErrorColor: Colors.red,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Senha",
                          labelStyle: TextStyle(
                            color: _passwordError ? Colors.red : Colors.black,
                          ),
                          errorStyle: TextStyle(color: Colors.red),
                        ),
                        onSaved: (password) =>
                            _authData['password'] = password ?? '',
                        controller: _passwordController,
                        validator: (_password) {
                          final password = _password ?? '';
                          bool error = false;
                          String? errormsg;
                          if (_isSignUp()) {
                            if (password.isEmpty && password.length < 5) {
                              error = true;
                              errormsg = 'Senha não pode ser vazia.';
                            } else if (password.length <= 5) {
                              error = true;
                              errormsg =
                                  'Senha precisa ser maior que 5 caracteres.';
                            }
                          }

                          setState(() {
                            _passwordError = error;
                          });
                          return errormsg;
                        },
                      ),
                    ),

                    //Confirmar Senha ------------------
                    if (_isSignUp())
                      Formfielddecoration(
                        error: _rPasswordError,
                        child: TextFormField(
                          cursorColor: Colors.black,
                          cursorErrorColor: Colors.red,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Confirmar senha",
                            labelStyle: TextStyle(
                              color: _rPasswordError
                                  ? Colors.red
                                  : Colors.black,
                            ),
                            errorStyle: TextStyle(color: Colors.red),
                          ),
                          validator: _isLogin()
                              ? null
                              : (_password) {
                                  final password = _password ?? '';
                                  bool error = false;
                                  String? errormsg;
                                  if (password != _passwordController.text) {
                                    error = true;
                                    errormsg = 'Senhas precisam ser iguais.';
                                  }
                                  setState(() {
                                    _rPasswordError = error;
                                  });
                                  return errormsg;
                                },
                        ),
                      ),
                    SizedBox(height: 15),
                    _isLoading
                        ? CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          )
                        : TextButton(
                            onPressed: _submit,
                            child: Text(
                              _isLogin() ? "Entrar" : "Cadastrar",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                    SizedBox(height: 45),
                    TextButton(
                      onPressed: _switchAuthMode,
                      child: Text(
                        _isLogin() ? "SE CADASTRE!" : "VOLTAR",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
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
