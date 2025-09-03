import 'package:recipe_app/View/all_libs.dart';

class ProfileSetupScreen extends StatelessWidget {
  String uid;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  ProfileSetupScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
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
                  child: Image.asset( BASE_IMG_PATH+ MICKEY_MOUSE_DP, errorBuilder:(ctx, o,st)=> const DefaultProfileImageWidget(),),
                ),
                Container(
                  decoration: BoxDecoration(color:  BUTTON_COLOR,borderRadius: BorderRadius.circular(20.0)),
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
                mySnackBar(_scaffoldKey.currentState!.context , provider.msg);
              }
              else{
                await  setUserId(uid);
                Navigator.pushReplacement(ctx, MaterialPageRoute(builder: (ctx)=>MainScreen(uid: uid)));
              }
      
            }, child: provider.loading? CustomProgressIndicator(): const Text('Set Profile'))
          ],
        ),
      ),
    );
  }
}