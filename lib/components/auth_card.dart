import 'package:flutter/material.dart';

enum AuthMode { Singup, Login }

class AuthCard extends StatefulWidget {
  AuthCard({Key key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  AuthMode _authMode = AuthMode.Login;
  final _passwordControler = TextEditingController();

  Map<String, String> _authData = {'email': '', 'password': ''};
  void _submit() {}
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
        height: 320,
        child: Form(
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
                  onSaved: (value) => _authData["password"] = value,
                ),
              SizedBox(height: 20),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).primaryTextTheme.button.color,
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                child:
                    Text(_authMode == AuthMode.Login ? "Entrar" : "Registrar"),
                onPressed: _submit,
              )
            ],
          ),
        ),
      ),
    );
  }
}
