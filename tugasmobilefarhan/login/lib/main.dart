import 'dart:convert';
import 'package:flutter/material.dart';
import 'page_home.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PageLogin(),
    );
  }
}

class PageLogin extends StatelessWidget {
  final myUsernameController = TextEditingController();
  final myPasswordController = TextEditingController();
  String nUsername, nPassword;

  //tambahkan form
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Login'),
        backgroundColor: Colors.orange,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              //cek data field nya kosong
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Input Username';
                }
                return null;
              },

              controller: myUsernameController,
              decoration: InputDecoration(
                hintText: 'Input Username',
              ),
            ),
            TextFormField(
              //cek data field nya kosong
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Input Username';
                }
                return null;
              },
              maxLength: 16,
              maxLengthEnforced: true,
              controller: myPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Input Password',
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            MaterialButton(
              minWidth: 85.0,
              height: 50.0,
              color: Colors.green,
              textColor: Colors.white,
              onPressed: () {
                //cek apakah username = rizki
                //cek password < 5 : gak bisa login, >5 bisa login

                //ngambil value dari widget textfield
                nUsername = myUsernameController.text;
                nPassword = myPasswordController.text;

                if (_formKey.currentState.validate()) {
                  if (nUsername != 'farhan') {
                    print("username salah");
                  } else if (nPassword.length <= 5) {
                    print("password harus lebih dari 5 ");
                  } else {
                    login() async {
                      // SERVER LOGIN API URL
                      var s = 'http://192.168.43.164/flutter/login.php';
                      var url = s;
                      // POST KE SISTEM
                      var response = await http
                          .post(url, body: {'pengguna': nama, 'sandi': sandi});

                      // Getting Server response into variable.
                      var message = jsonDecode(response.body);
                      if (message == ' selamat login berhasil') {
                        return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(" Yey Horee Berhasil"),
                            );
                          },
                        );
                      } else if (message == "login gagal mohon coba lagi") {
                        return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text("Maaf Anda Tidak Diizinkan Masuk"),
                            );
                          },
                        );
                      } else {
                        return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text("Response Yang Aneh"),
                            );
                          },
                        );
                      }
                    }

                    //aksi pindah
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PageHome(
                                  nama: nUsername,
                                  password:
                                      nPassword, // variable yang di pass ke page home
                                )));
                  }
                }
              },
              child: Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
