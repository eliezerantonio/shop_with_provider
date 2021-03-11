import 'package:flutter/material.dart';
import 'package:gerencimento_estado/exceptions/auth_exception.dart';
import 'package:gerencimento_estado/providers/auth.dart';
import 'package:provider/provider.dart';

enum AuthMode { Singup, Login }

class AuthCard extends StatefulWidget {
  AuthCard({Key key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.Login;
  final _passwordControler = TextEditingController();
  AnimationController _controller;

  Animation<Size> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _heightAnimation = Tween<Size>(
            begin: Size(double.infinity, 329), end: Size(double.infinity, 400))
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

    _heightAnimation.addListener(() => setState(() {}));
  }

  Map<String, String> _authData = {'email': '', 'password': ''};

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    Auth auth = Provider.of(context, listen: false);
    _formKey.currentState.save();
    try {
      if (_authMode == AuthMode.Login) {
//Login
        await auth.login(_authData["email"], _authData["password"]);
      } else {
//>Registro
        await auth.signup(_authData["email"], _authData["password"]);
      }
    } on AuthException catch (e) {
      _showErrorDialog(e.toString());
    } catch (error) {
      _showErrorDialog('erro inesperado');
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Singup;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Ocorreu um erro!"),
              content: Text(msg),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Fechar"),
                )
              ],
            ));
  }

  @override
  void dispose() {
    super.dispose();
    _passwordControler.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16),
        //  height: _authMode == AuthMode.Login ? 329 : 400,
        height: _heightAnimation.value.height,
        constraints: BoxConstraints(minHeight: _heightAnimation.value.height),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "E-mail",
                  labelStyle: TextStyle(fontSize: 22),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.trim().isEmpty || !value.contains("@")) {
                    return 'Informe um e-mail valido';
                  }
                  return null;
                },
                onSaved: (value) => _authData["email"] = value,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: true,
                controller: _passwordControler,
                decoration: InputDecoration(
                  labelText: "Senha",
                  labelStyle: TextStyle(fontSize: 22),
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.trim().isEmpty || value.length < 6) {
                    return 'Informe um a senha';
                  }
                  return null;
                },
                onSaved: (value) => _authData["password"] = value,
              ),
              if (_authMode == AuthMode.Singup)
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Confirmar senha",
                    labelStyle: TextStyle(fontSize: 22),
                  ),
                  keyboardType: TextInputType.text,
                  validator: _authMode == AuthMode.Singup
                      ? (value) {
                          if (value != _passwordControler.text) {
                            return 'Senha nao confere';
                          }
                          return null;
                        }
                      : null,
                ),
              Spacer(),
              if (_isLoading)
                CircularProgressIndicator()
              else
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).primaryTextTheme.button.color,
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                  child: Text(
                      _authMode == AuthMode.Login ? "Entrar" : "Registrar"),
                  onPressed: _submit,
                ),
              Spacer(),
              FlatButton(
                onPressed: _switchAuthMode,
                child: Text(
                  "Alternar p/${_authMode == AuthMode.Login ? "Registrar" : "Entrar"}"
                      .toUpperCase(),
                  style: TextStyle(fontSize: 16),
                ),
                textColor: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
