import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ohdonto/signin_signup_verify/verification_usecase.dart';
import 'package:ohdonto/signin_signup_verify/signup_verification_usecase.dart';
import 'package:ohdonto/signv2/widgets/defaul_button_widget.dart';

import 'form_based_signup_code_cerification_datasource.dart';
import 'signup_verification_controller.dart';

class SignUpVerifierPage extends StatefulWidget {
  const SignUpVerifierPage({Key? key, this.email}) : super(key: key);

  final String? email;

  @override
  State<SignUpVerifierPage> createState() => _SignUpVerifierPageState();
}

class _SignUpVerifierPageState extends State<SignUpVerifierPage> {
  late SignUpVerificationController controlador;
  late SignUpVerificationUsecase usecase;

  late FocusNode b1, b2, b3, b4;

  @override
  void dispose() {
    b1.dispose();
    b2.dispose();
    b3.dispose();
    b4.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controlador = SignUpVerificationController();
    controlador
        .setVerificationStrategy(FormBasedSignupCodeVerificationDatasource());
    controlador.setUseCase(FormBasedSignUpVerificationUsecase());
    b1 = FocusNode();
    b2 = FocusNode();
    b3 = FocusNode();
    b4 = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(17.0),
                child: Observer(
                    builder: (_) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFirstRow(),
                              const SizedBox(height: 24),
                              const Text('Verificar ',
                                  style: TextStyle(fontSize: 45)),
                              const Text('Código',
                                  style: TextStyle(fontSize: 45)),
                              const SizedBox(height: 24),
                              const Text('Um código foi enviado para'),
                              Text('${widget.email}'),
                              const SizedBox(height: 24),
                              _buildRowNumbersField(),
                              const SizedBox(height: 24),
                              Center(
                                  child: DefaultButton(
                                      widget: const Text(
                                        "Enviar código",
                                      ),
                                      color: Colors.blue,
                                      callback: controlador.isFullFilled
                                          ? () {}
                                          : null)),
                              const SizedBox(height: 24),
                              _buildBotaoEnviarCodigo()
                            ])))));
  }

  void fazNada() {
    debugPrint("faz nada");
  }

  Widget _buildBotaoEnviarCodigo() {
    return Container();
  }

  Widget _buildTextoReenviar() {
    return Center(
      child: RichText(
          text: const TextSpan(
              text: "Não recebi o código. ",
              children: [TextSpan(text: "Reenviar")])),
    );
  }

  Widget _buildFirstRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        const Text("Vamos criar uma conta ?", style: TextStyle(fontSize: 24))
      ],
    );
  }

  Widget _buildRowNumbersField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildNumberField((field) {
          controlador.setField1(field);
          b2.nextFocus();
        }, b1),
        const SizedBox(width: 12),
        _buildNumberField((field) {
          controlador.setField1(field);
          b3.nextFocus();
        }, b2),
        const SizedBox(width: 12),
        _buildNumberField((field) {
          controlador.setField1(field);
          b4.nextFocus();
        }, b3),
        const SizedBox(width: 12),
        _buildNumberField((field) {
          controlador.setField1(field);
        }, b4),
      ],
    );
  }

  Widget _buildNumberField(callback, focusNode) {
    return SizedBox(
      width: 40,
      child: TextFormField(
        maxLength: 1,
        keyboardType: TextInputType.number,
        onChanged: callback,
        focusNode: focusNode,
        decoration: const InputDecoration(
          hintText: "*",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}