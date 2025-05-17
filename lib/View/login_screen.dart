import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/View/Custom%20Widgets/CustomTextField.dart';
import 'package:recipe_app/View/home_screen.dart';
import 'package:recipe_app/View/main_screen.dart';
import 'package:recipe_app/View/sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
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
              CustomTextField(lbl: 'Email',textInputType: TextInputType.emailAddress,),
              CustomTextField(lbl: 'Password',textInputType: TextInputType.visiblePassword,),
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
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>MainScreen()));
                      }, child: const Text('Sign In'))),
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
                        onPressed: () 
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (builder)=>SignUpScreen()));
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
