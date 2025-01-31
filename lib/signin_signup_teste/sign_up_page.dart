import 'package:flutter/material.dart';
import 'package:ohdonto/shared/topbar_backbutton_widget.dart';
import 'package:ohdonto/signin_signup_teste/sign_in_sign_up_controller.dart';

import 'text_field_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late SignInSignUpController controller;

  @override
  void initState() {
    super.initState();
    controller = SignInSignUpController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopBarWidget(),
          _buildCreateAccountText(),
          _buildForm(),
        ],
      ),
    ));
  }

  Widget textTitle(String name) {
    return Text(
      name,
      style: const TextStyle(fontSize: 40),
    );
  }

  Widget _buildCreateAccountText() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [textTitle("Criar"), textTitle("Conta")]);
  }

  void voltar() {
    Navigator.pop(context);
  }

  Widget _buildTopBarWidget() {
    return Row(
      children: [
        TopbarBackButtonWidget(callback: voltar),
        const Text('Vamos criar uma conta?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
      ],
    );
  }

  Widget _buildForm() {
    return Column(children: [
      TextFieldWidget(
        text: 'Nome',
        hint: 'Digite seu nome',
        stream: controller.nameStream,
        callback: controller.addName,
        obscureText: false,
      ),
      TextFieldWidget(
          text: 'Email',
          hint: 'Digite seu Email',
          stream: controller.emailStream,
          callback: controller.addEmail,
          keyboardType: TextInputType.emailAddress),
      TextFieldWidget(
          text: 'Senha',
          hint: 'Digite sua senha',
          stream: controller.passStream,
          callback: controller.addPass,
          obscureText: false,
          icon: const Icon(Icons.visibility)),
      TextFieldWidget(
        text: 'Confirmação de Senha',
        hint: 'Digite novamente sua senha',
        stream: controller.repetedPassStream,
        callback: controller.addRepetedPass,
        obscureText: true,
      ),
      StreamBuilder(
          stream: controller.textStatusStream,
          builder: (context, snapshot) {
            if (snapshot.data == true) {
              return const Text("Senhas Diferentes");
            } else {
              return Container();
            }
          }),
      SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.05,
          child: StreamBuilder(
              stream: controller.buttonStream,
              builder: (context, snapshot) {
                return ElevatedButton(
                    onPressed: snapshot.data == true ? sendDataCallback : null,
                    child: const Text("Criar conta"));
              }))
    ]);
  }

  void sendDataCallback() {
    controller.sendData1();
  }
}
