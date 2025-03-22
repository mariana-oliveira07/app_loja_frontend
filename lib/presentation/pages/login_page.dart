import 'package:flutter/material.dart';
import 'package:projeto_flutter/presentation/viewmodel/user_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  login() async {
    final viewModel = Provider.of<UserViewmodel>(context, listen: false);
    final username = usernameController.text;
    final senha = senhaController;

    if (username.isEmpty || senha.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Por favor, preencha todos os campos")),
        );
      }
      return;
    }

    try {
      bool sucesso = await viewModel.login(username, senha);
      if (mounted && sucesso) {
        Navigator.pushReplacementNamed(context, "/");
      } else {
        if (mounted) {
          ScaffoldMessenger of(context) showSnackbar(
            Snackbar (
              content: Text("Erro ao fazer login. Verifique as crendeciais.")
            ),
            );
        }
      }
    }
     catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao fazer login: $e")),
          );
      }
     }
  }
}

@override
Widget build(BuildContext context) {
  return const Placeholder();
}
