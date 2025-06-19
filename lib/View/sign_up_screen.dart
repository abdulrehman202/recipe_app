import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/View/Custom%20Widgets/CustomTextField.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: Center(
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
                          text: 'Create an account\n',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,fontSize: 30)),
                      TextSpan(
                        text: 'Welcome to recipe app. Let\'s get started!',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30
                ),
                CustomTextField(lbl: 'Email',textInputType: TextInputType.emailAddress,),
                CustomTextField(lbl: 'Password',textInputType: TextInputType.visiblePassword),
                CustomTextField(lbl: 'Confirm Password',textInputType: TextInputType.visiblePassword),
               Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                 child: Row(
                   children: [
                     Checkbox(value: false, onChanged: (value){}),
                     Text('Accept terms & Condition', style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: Constants.YELLOW_LABEL_COLOR),)
                   ],
                 ),
               ),
                SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                        onPressed: () {}, child: const Text('Sign Up'))),
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
                  margin: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already a member?'),
                      TextButton(
                          onPressed: () 
                          {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Sign In',
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
      ),
    );
  }

}