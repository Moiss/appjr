import 'dart:convert';
import 'package:cobroregreso/models/model_http.dart';
import 'package:cobroregreso/pages/page_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class PageHome extends StatefulWidget {
  PageHome({Key key}) : super(key: key);

  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  GlobalKey<FormState> _formKey = GlobalKey();
  Login myLogin = Login();
  List<TipoEmpleados> tipoEmpleados;

  String _usuario, _contrasenia;

  bool _passwordVisible = true;
  TextEditingController controllerUsuario = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favor de registrarse"),
      ),
      body: _form(),
    );
  }

  Future<Null> _getLogin() async {
    _usuario = controllerUsuario.text;
    _contrasenia = controllerPassword.text;
    final response = await http
        .get("http://216.250.126.250/login/${_usuario}/${_contrasenia}/App");
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      setState(() {
        myLogin = Login.fromJson(result);
      });
      if (myLogin.status == "200") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DetailCobro()));
      } else {
        Toast.show("Usuario y contrseña no validos", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      }
    } else {
      Toast.show("Error al obtener datos del API", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    }
  }

  Widget _form() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: controllerUsuario,
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Usuario',
              ),
              validator: (value) => _validarRequeridos(value,
                  "El nombre de usuario es requerido o es menor a 5 caracteres"),
            ),
            Padding(padding: EdgeInsets.all(10)),
            TextFormField(
              obscureText: _passwordVisible,
              controller: controllerPassword,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Contraseña',
                suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    }),
              ),
              validator: (value) => _validarRequeridos(value,
                  "La contraseña es requerida o es menor a 5 caracteres"),
            ),
            Padding(padding: EdgeInsets.all(10)),
            SizedBox(
              width: double.infinity,
              child: RaisedButton.icon(
                color: Colors.blue,
                textColor: Colors.white,
                icon: Icon(Icons.login),
                label: Text("Iniciar Sesion"),
                onPressed: () {
                  _validateForm();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _validarRequeridos(String value, String messages) {
    return (value.length == 0 || value.length < 5) ? messages : null;
  }

  void _validateForm() {
    if (_formKey.currentState.validate()) {
      _getLogin();
      //Navigator.push(
      //  context, MaterialPageRoute(builder: (context) => DetailCobro()));
    }
  }
}
