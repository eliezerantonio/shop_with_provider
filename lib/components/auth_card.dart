import 'package:flutter/material.dart';
import 'package:gerencimento_estado/providers/auth.dart';
import 'package:provider/provider.dart';

enum AuthMode { Singup, Login }

class AuthCard extends StatefulWidget {
  AuthCard({Key key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.Login;
  final _passwordControler = TextEditingController();

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

    if (_authMode == AuthMode.Login) {
//Login
      await auth.login(_authData["email"], _authData["password"]);
    } else {
//>Registro
      await auth.signup(_authData["email"], _authData["password"]);
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
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _passwordControler.dispose();
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
        height: _authMode == AuthMode.Login ? 329 : 400,
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
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                  child: Text(
                      _authMode == AuthMode.Login ? "Entrar" : "Registrar"),
                  onPressed: _submit,
                ),
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
