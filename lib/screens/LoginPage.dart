import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intgress/screens/RegisterPage.dart';
import 'package:intgress/utils/MySnackbar.dart';

import '../core/repository/UserRepository.dart';
import '../models/User.dart';
import '../services/authenticationService.dart';
import '../viewmodel/UserViewModel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late UserRepository userRepository;
  late UserViewModel userViewModel;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

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
                          TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              hintText: 'Nome',
                            ),
                          ),
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
                          TextField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Repetir senha',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            String name = _nameController.text;
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            print('Email: $email');
                            print('Password: $password');

                            // salvando o User em todos os banco de dados (local e remoto)



                            authenticationService
                                .registerUser(context: context,
                                    name: name,
                                    password: password,
                                    email: email)
                                .then((String? error) {
                              if (error != null) {
                                showSnackBar(context: context, text: error);
                              } else {
                                // deu certo
                                showSnackBar(
                                    context: context,
                                    text: "Cadastro efetuado com sucesso",
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
                          child:
                              // Image(image: AssetImage("assets/icon_google.jpg")),
                              Text('Continuar com google'),
                        ),
                        SizedBox(height: 40.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Já tem uma conta?"),
                            GestureDetector(
                              onTap: () {
                                // Navegar para a próxima tela ao clicar no texto
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()),
                                );
                              },
                              child: Text(
                                ' clique aqui!',
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
