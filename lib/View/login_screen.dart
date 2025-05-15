import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                                fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: 'Welcome Back!',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 75.0,
              ),
              txtFld('Email'),
              txtFld('Password'),
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
                      onPressed: () {}, child: const Text('Sign In'))),
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
                          icon: Image.asset(
                              Constants.BASE_IMG_PATH + Constants.GOOGLE_ICON)))
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    TextButton(
                        onPressed: () {},
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

  Widget txtFld(String lbl) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              lbl,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: lbl,
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              fillColor: Colors.white,
              focusColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
