import 'package:flutter/material.dart';
import 'package:ohdonto/signin_signup/presentation/widgets/defaul_button_widget.dart';

class SocialNetworkWidget extends StatefulWidget {
  const SocialNetworkWidget({Key? key}) : super(key: key);

  @override
  State<SocialNetworkWidget> createState() => _SocialNetworkWidgetState();
}

class _SocialNetworkWidgetState extends State<SocialNetworkWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDividerButton(),
        const SizedBox(
          height: 15,
        ),
        _buildSocialNetworkButtons(),
      ],
    );
  }

  Widget _buildDividerButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Flexible(
          flex: 1,
          child: Divider(
            height: 10,
          ),
        ),
        Flexible(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('Ou continuar com'),
            )),
        Flexible(
          flex: 1,
          child: Divider(
            height: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialNetworkButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: _buildSocialNetworkButton(
                "assets/images/google.png", "Google", () async {
          // controller.setSignUpStrategy(GoogleSignUpDataSource());
          // controller.googleSignUp();
        })),
        Expanded(
          child: _buildSocialNetworkButton(
              "assets/images/facebook.png", "Facebook", () {}),
        ),
      ],
    );
  }

  Widget _buildSocialNetworkButton(
      String logoPath, String name, Function()? callback) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: DefaultButton.socialNetwork(
        widget: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                logoPath,
                width: 20,
                height: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                name,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        callback: callback,
      ),
    );
  }
}