import 'dart:io';

import 'package:educa/widgets/misc/pick_user_image.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, String username,
      bool isLogin, File imageFile, BuildContext ctx) _submitData;

  final bool _isLoading;

  AuthForm(this._submitData, this._isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  //Variables
  final _formKey = GlobalKey<FormState>();
  Map<String, String> _formValues = {
    'email': '',
    'username': '',
    'password': '',
  };

  File _userImageFile;
  var _isLogin = true;

  //Functions

  void _storeUserImageFile(File image) {
    _userImageFile = image;
  }

  bool _isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  void _trySubmit(BuildContext ctx) {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (!isValid || (_userImageFile == null && !_isLogin)) {
      String errorMessageContent = _userImageFile == null && !_isLogin
          ? 'Nenhum imagem foi provida'
          : 'Credencias de usuário inválida';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessageContent),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    _formKey.currentState.save();
    widget._submitData(
        _formValues['email'].trim(),
        _formValues['password'].trim(),
        _formValues['username'].trim(),
        _isLogin,
        _userImageFile,
        ctx);
  }

  @override
  Widget build(BuildContext context) {
    Widget confirmButton = (widget._isLoading)
        ? CircularProgressIndicator()
        : Center(
            child: OutlinedButton(
                child: Text(_isLogin ? 'Entrar' : 'Inscrever-se'),
                onPressed: () => _trySubmit(context)));

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
      constraints: BoxConstraints(minHeight: _isLogin ? 360 : 530),
      height: _isLogin ? 360 : 530,
      child: Card(
        color: Colors.indigo[50],
        margin: const EdgeInsets.only(bottom: 15, left: 25, right: 25),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 16, right: 16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                if (_isLogin)
                  Text(
                    'Entrar',
                    style: Theme.of(context).textTheme.headline2,
                    textAlign: TextAlign.center,
                  ),
                if (!_isLogin) PickUserImage(_storeUserImageFile),
                TextFormField(
                  key: ValueKey('email'),
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  enableSuggestions: false,
                  initialValue: _formValues['email'],
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !_isValidEmail(value))
                      return 'Please enter a valid email address';
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _formValues['email'] = value;
                    });
                  },
                ),
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    textCapitalization: TextCapitalization.words,
                    enableSuggestions: false,
                    initialValue: _formValues['username'],
                    decoration: InputDecoration(labelText: 'Nome de usuário'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 4)
                        return 'O usuário precisa ter no mínimo 4 caractéres';
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _formValues['username'] = value;
                      });
                    },
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  initialValue: _formValues['password'],
                  decoration: InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty || value.length < 7)
                      return 'A senha deve ter no mínimo 7 caractéres';
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _formValues['password'] = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                confirmButton,
                const SizedBox(
                  height: 12,
                ),
                Center(
                  child: ElevatedButton(
                    child: Text(_isLogin ? 'Criar nova conta' : 'Logar'),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
