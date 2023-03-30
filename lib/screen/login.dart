import 'package:book_relax_flutter_app/api/auth.dart';
import 'package:book_relax_flutter_app/component/auto_rotating.dart';
import 'package:book_relax_flutter_app/component/can_back.dart';
import 'package:book_relax_flutter_app/state/auth.dart';
import 'package:book_relax_flutter_app/utils/debug.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillBack(
      canBack: false,
      child: Scaffold(
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/background.jpg'),
              ),
            ),
            child: SafeArea(
              child: Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(top: 50),
                child: SizedBox(
                  height: 260.0,
                  child: FractionallySizedBox(
                    widthFactor: 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          '欢迎使用书悠App',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        _LoginForm(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _passwordFocusNode = FocusNode();

  bool _isLoggingIn = false;

  AuthState get _authState => Get.find();

  Future<void> _login() async {
    setState(() {
      _isLoggingIn = true;
    });
    try {
      var resp = await AuthClient.login(
        _usernameController.text,
        _passwordController.text,
      );

      _authState.save(
        resp.userId,
        resp.nickname,
        resp.accessToken,
        resp.refreshToken,
        resp.expiration,
      );

      DebugUtil.dump('返回');

      _authState.backLastPage();
    } finally {
      setState(() {
        _isLoggingIn = false;
      });
    }
  }

  TextField _buildUsernameField() {
    return TextField(
      controller: _usernameController,
      keyboardType: TextInputType.name,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: '请输入用户名',
      ),
      onSubmitted: (value) {
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
    );
  }

  TextField _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: '请输入密码',
      ),
      onSubmitted: (value) => _login(),
    );
  }

  Widget _buildLoginButton() {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: MaterialButton(
        height: 60,
        shape: const CircleBorder(),
        onPressed: _isLoggingIn ? null : _login,
        color: Colors.blueGrey,
        disabledColor: Colors.blueGrey,
        child: _isLoggingIn
            ? AutoRotatingWidget(
                duration: const Duration(seconds: 1),
                child: Icon(
                  Icons.autorenew,
                  color: Colors.white.withOpacity(0.8),
                  size: 30,
                ),
              )
            : Icon(
                Icons.arrow_forward,
                color: Colors.white.withOpacity(0.8),
                size: 30,
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          _buildUsernameField(),
          _buildPasswordField(),
          const SizedBox(height: 20),
          _buildLoginButton(),
        ],
      ),
    );
  }
}
