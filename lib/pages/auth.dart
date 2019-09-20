import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _email, _password;
  bool _acceptTerms = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.dstATop),
                fit: BoxFit.cover,
                image: AssetImage('assets/background.jpg'))),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                      labelText: 'E-Mail',
                      filled: true,
                      fillColor: Colors.white),
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                    decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.white),
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                    keyboardType: TextInputType.visiblePassword),
                SwitchListTile(
                  value: _acceptTerms,
                  onChanged: (bool value) {
                    setState(() {
                      _acceptTerms = value;
                    });
                  },
                  title: const Text('Accept Terms'),
                ),
                RaisedButton(
                  child: Text('Login'),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/products');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
