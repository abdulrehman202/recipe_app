import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Provider/login_provider.dart';
import 'package:recipe_app/View/Custom%20Widgets/CustomProgressIndicator.dart';
import 'package:recipe_app/View/Custom%20Widgets/CustomSnackBar.dart';
import 'package:recipe_app/View/Custom%20Widgets/CustomTextField.dart';
import 'package:recipe_app/View/main_screen.dart';
import 'package:recipe_app/View/sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginProvider>(
          builder: (context, user, _) => _body(context, user)),
    );
  }

  Widget _body(BuildContext context, LoginProvider provider) {
    return IgnorePointer(
      ignoring: provider.loading,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: 'Hello\n',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30)),
                    TextSpan(
                      text: 'Welcome Back!',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
              ),
              CustomTextField(
                lbl: 'Email',
                textInputType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              CustomTextField(
                lbl: 'Password',
                textInputType: TextInputType.visiblePassword,
                controller: _passwordController,
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: Constants.YELLOW_LABEL_COLOR),
                  )),
              SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                      onPressed: () async {
                        if (provider.checkValues(_emailController.text)) {
                          var res = await provider.login(
                            _emailController.text,
                            _passwordController.text,
                          );
                          res.fold(
                              ifLeft: (l) => mySnackBar(context, l.toString()),
                              ifRight: (r) async {
                                _emailController.clear();
                                _passwordController.clear();
          
                                await Constants.setUserId(r);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => MainScreen(
                                              uid: r,
                                            )));
                              });
                        } else {
                          mySnackBar(context, provider.msg);
                        }
                      },
                      child: provider.loading
                          ? CustomProgressIndicator()
                          : const Text('Sign In'))),
              Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(20),
                  child: Text(
                    'Or sign in with',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: Constants.GREY_LABEL_COLOR),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                      child: IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                              Constants.BASE_IMG_PATH + Constants.FB_ICON))),
                  const SizedBox(
                    width: 30,
                  ),
                  Card(
                      child: IconButton(
                          onPressed: () {},
                          icon: Image.asset(Constants.BASE_IMG_PATH +
                              Constants.GOOGLE_ICON)))
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => SignUpScreen()));
                        },
                        child: Text(
                          'Sign Up',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: Constants.YELLOW_LABEL_COLOR),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
