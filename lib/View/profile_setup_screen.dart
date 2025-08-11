import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Provider/profile_setup_provider.dart';
import 'package:recipe_app/View/Custom%20Widgets/CustomProgressIndicator.dart';
import 'package:recipe_app/View/Custom%20Widgets/CustomTextField.dart';
import 'package:recipe_app/View/Custom%20Widgets/DefaultProfileImageWidget.dart';
import 'package:recipe_app/View/main_screen.dart';

class ProfileSetupScreen extends StatelessWidget {
  String uid;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  ProfileSetupScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProfileSetupProvider>(builder: (context, user,_) => _body(context, user)),
    );
  }

  Widget _body(BuildContext ctx, UserProfileSetupProvider provider, )
  {
    return IgnorePointer(
      ignoring: provider.loading,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                ClipOval(
                  child: Image.asset(Constants.BASE_IMG_PATH+Constants.MICKEY_MOUSE_DP, errorBuilder:(ctx, o,st)=> const DefaultProfileImageWidget(),),
                ),
                Container(
                  decoration: BoxDecoration(color: Constants.BUTTON_COLOR,borderRadius: BorderRadius.circular(20.0)),
                  margin: const EdgeInsets.only(right: 20.0, bottom: 40.0),
                  child: const Icon(Icons.add,color: Colors.white,),
                )
              ],
            ),
            CustomTextField(lbl: 'Full Name', controller: _nameController,),
            CustomTextField(lbl: 'Add bio', controller: _bioController,),
            FilledButton(onPressed: ()async
            {
              await provider.setUpUser(_nameController.text, _bioController.text, uid);
      
              if(!provider.success)
              {
                ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(provider.msg)));
              }
              else{
                await Constants.setUserId(uid);
                Navigator.pushReplacement(ctx, MaterialPageRoute(builder: (ctx)=>MainScreen(uid: uid)));
              }
      
            }, child: provider.loading? CustomProgressIndicator(): const Text('Set Profile'))
          ],
        ),
      ),
    );
  }
}