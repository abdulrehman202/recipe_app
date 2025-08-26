import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Provider/sign_up_provider.dart';
import 'package:recipe_app/View/Custom%20Widgets/CustomProgressIndicator.dart';
import 'package:recipe_app/View/Custom%20Widgets/CustomSnackBar.dart';
import 'package:recipe_app/View/Custom%20Widgets/CustomTextField.dart';
import 'package:recipe_app/View/profile_setup_screen.dart';


class SignUpScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  SignUpScreen({super.key});

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SignUpProvider>(builder: (context, user,_) => _body(context, user)) ,
    );
  }

  Widget _body(BuildContext context, SignUpProvider provider) {
    return IgnorePointer(
      ignoring: provider.loading,
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
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
                CustomTextField(lbl: 'Email',textInputType: TextInputType.emailAddress,controller: _emailController,),
                CustomTextField(lbl: 'Password',textInputType: TextInputType.visiblePassword, controller: _passwordController,),
                CustomTextField(lbl: 'Confirm Password',textInputType: TextInputType.visiblePassword,controller: _confirmPasswordController,),
               Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                 child: Row(
                   children: [
                     Checkbox(value: provider.termsAndConditionAccepted, onChanged:(value)=> provider.toggleTermsAndCondition(value??false)),
                     Text('Accept terms & Condition', style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: Constants.YELLOW_LABEL_COLOR),)
                   ],
                 ),
               ),
                SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton(
                        onPressed: () async{
                          
                          if(provider.checkValues(_emailController.text,_passwordController.text,_confirmPasswordController.text)){
            
                          var res = await provider.registerUser(_emailController.text,_passwordController.text,_confirmPasswordController.text);
                          res.fold(ifLeft: (l)=>
                          mySnackBar(context, l.toString()),ifRight: (r){
                            _emailController.clear();
                            _passwordController.clear();
                            _confirmPasswordController.clear();
                            provider.toggleTermsAndCondition(false);
                            Navigator.push(context, MaterialPageRoute(builder: (builder)=> ProfileSetupScreen(uid: r,)));
                            
                            });}
                        else{
                          mySnackBar(context, provider.msg);
                        }
                        }, child: provider.loading?CustomProgressIndicator(): const Text('Sign Up'))),
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