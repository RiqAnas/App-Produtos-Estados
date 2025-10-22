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

//Single' ' State pois é apenas um e é em um componente stateful
class _AuthformState extends State<Authform>
    with SingleTickerProviderStateMixin {
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
        _aController?.forward();
      } else {
        _authMode = AuthMode.Login;
        _aController?.reverse();
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

  Size getDeviceSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  AnimationController? _aController;
  Animation<double>? _opacityAnimation;
  Animation<Offset>? _slideAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //consegue colocar this por conta do mixin adicionado no estado
    _aController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    //tween é uma animação entre(between) dois valores
    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _aController!, curve: Curves.linear));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1.5),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _aController!, curve: Curves.linear));

    // _heightAnimation?.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = getDeviceSize(context);
    // TODO: implement build
    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      curve: Curves.linear,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      //o comentado é no caso de realizar manualmente (sem usar o animatedContainer)
      height: /*_heightAnimation?.value.height ?? */ _isLogin()
          ? 500
          : (_emailError || _passwordError || _rPasswordError)
          ? 670
          : 600,
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
                    AnimatedContainer(
                      //define como será enquanto ela não aparecer(0) e quando ela aparecer
                      constraints: BoxConstraints(
                        minHeight: _isLogin() ? 0 : 60,
                        maxHeight: _isLogin() ? 0 : 120,
                      ),
                      //mais lenta para fazer com que de tempo da aba abaixar e depois a opacidade
                      //do campo aumentar
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear,
                      child: FadeTransition(
                        opacity: _opacityAnimation!,
                        child: SlideTransition(
                          position: _slideAnimation!,
                          child: Formfielddecoration(
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
                                      if (password !=
                                          _passwordController.text) {
                                        error = true;
                                        errormsg =
                                            'Senhas precisam ser iguais.';
                                      }
                                      setState(() {
                                        _rPasswordError = error;
                                      });
                                      return errormsg;
                                    },
                            ),
                          ),
                        ),
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
                    Align(
                      alignment: AlignmentGeometry.bottomCenter,
                      child: TextButton(
                        onPressed: _switchAuthMode,
                        child: Text(
                          _isLogin() ? "SE CADASTRE!" : "VOLTAR",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
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
    );
  }
}
