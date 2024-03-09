import 'package:flutter/material.dart';
import 'package:intgress/utils/MySnackbar.dart';

import '../core/repository/UserRepository.dart';
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
                    Column(
                      children: [
                        Text("Bem vindo!"),
                        Text(
                            "Apenas a um passo de sua experiencia com o Anota AI")
                      ],
                    ),
                    Column(
                      children: [
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: 'Nome',
                          ),
                        ),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Senha',
                          ),
                        ),
                        TextField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Repetir senha',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            String name = _nameController.text;
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            print('Email: $email');
                            print('Password: $password');

                            authenticationService
                                .registerUser(name:name,password: password, email: email)
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
                            // Cor de fundo personalizada
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
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
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Aqui você pode acessar os valores dos campos de texto
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            // Faça algo com os valores, como validar ou enviar para autenticação
                            print('Email: $email');
                            print('Password: $password');
                          },
                          child: Text('Continuar com google'),
                        ),
                        Text("Já tem uma conta? clique aqui!")
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
