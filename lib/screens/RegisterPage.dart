import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intgress/screens/LoginPage.dart';
import 'package:intgress/utils/MySnackbar.dart';

import '../core/repository/UserRepository.dart';
import '../services/authenticationService.dart';
import '../viewmodel/UserViewModel.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late UserRepository userRepository;
  late UserViewModel userViewModel;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  AuthenticationService authenticationService = AuthenticationService();

  @override
  void initState() {
    super.initState();

    userRepository = UserRepository();
    userViewModel = UserViewModel(userRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    SizedBox(
                      // Limitando a largura da coluna interna
                      width: 200.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // Centralização interna
                        children: [
                          Text(
                            "Bem vindo!",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          Text(
                            "Apenas a um passo de sua experiencia com o Anota AI",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 10.0),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                            ),
                          ),
                          SizedBox(height: 10.0),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Senha',
                            ),
                          ),
                          SizedBox(height: 10.0),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            String email = _emailController.text;
                            String password = _passwordController.text;

                            authenticationService
                                .loginUser(
                                email: email,
                                password: password,)
                                .then((String? error) {
                              if (error != null) {
                                showSnackBar(context: context, text: error);
                              } else {
                                // deu certo
                                showSnackBar(
                                    context: context,
                                    text: "Login efetuado com sucesso",
                                    isError: false);
                              }
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            minimumSize: MaterialStateProperty.all(Size(
                                MediaQuery.of(context).size.width *
                                    0.8, // 40% da largura da tela
                                40.0)),
                            textStyle: MaterialStateProperty.all(
                                TextStyle(fontSize: 16.0)),
                            // Cor de fundo personalizada
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                // Borda arredondada
                                side: BorderSide(
                                    color: Colors.blue), // Cor da borda
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              // Icon(Icons.login),
                              // Ícone ao lado do texto
                              SizedBox(width: 8.0),
                              // Espaçamento entre o ícone e o texto
                              Text(
                                'Entrar',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(Size(
                                MediaQuery.of(context).size.width *
                                    0.8, // 40% da largura da tela
                                40.0)),
                            textStyle: MaterialStateProperty.all(
                                TextStyle(fontSize: 16.0)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            //Login com google

                            AuthenticationService().signInWithGoogle(context);
                          },
                          child: Text('Continuar com google'),
                        ),
                        SizedBox(height: 40.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Não tem uma conta?"),
                            GestureDetector(
                              onTap: () {
                                // Navegar para a próxima tela ao clicar no texto
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                );
                              },
                              child: Text(
                                ' crie aqui!',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

// vamos mudar para um form para ficar mais performatico e validar
}
