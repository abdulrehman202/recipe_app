import 'package:recipe_app/View/all_libs.dart';


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
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                    onPressed: ()async{
                      
                      Either<String, String> res = await provider.resetPassword(_emailController.text);
                      
                      res.fold(ifLeft: (msg)=>mySnackBar(context, msg),ifRight: (uid)
                       {
                         passwordResetDialogBox(context, 'We have sent a link to your email. Click on the link to reset your password');
                        
                        } );},
                    child: Text(
                      'Forgot Password?',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color:  YELLOW_LABEL_COLOR),
                    )),
              ),
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
          
                                await  setUserId(r);
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
                        .copyWith(color:  GREY_LABEL_COLOR),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                      child: IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                               BASE_IMG_PATH +  FB_ICON))),
                  const SizedBox(
                    width: 30,
                  ),
                  Card(
                      child: IconButton(
                          onPressed: () {},
                          icon: Image.asset( BASE_IMG_PATH +
                               GOOGLE_ICON)))
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
                              .copyWith(color:  YELLOW_LABEL_COLOR),
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
