import 'package:recipe_app/View/all_libs.dart';

class ProfileSetupScreen extends StatelessWidget {
  String uid;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  AsyncMemoizer _memoizer = AsyncMemoizer();
  String? city;
  String? country;
  ProfileSetupScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          ),
      key: _scaffoldKey,
      body: Consumer<UserProfileSetupProvider>(
          builder: (context, user, _) => _body(context, user)),
    );
  }

  Widget myLocation() {
    return Center(
      child: FutureBuilder(
          future: _memoizer.runOnce(()async{await updateLocation();}),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return const Text('Fetching location...');
            } else {
              return locationBody();
            }
          }),
    );
  }

  Widget locationBody() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.location_pin),
        Text('${city ?? 'Unknown'}, ${country ?? 'Unknown'}'),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () {
            
            _cityController.text = city??'Unknown';
            _countryController.text = country??'Unknown';
          },
          child: const Text(
            'Use this location',
            style: TextStyle(
                color: BUTTON_COLOR, decoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }

  Future<void> updateLocation() async {
    bool permitted = await locationPermissionGranted(_scaffoldKey.currentState!.context);
    if(permitted){
    Position position = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    city = placemarks[0].locality;
    country = placemarks[0].country;
    }
    else{
      mySnackBar(_scaffoldKey.currentState!.context, 'Not permitted');
    }
  }

  Widget _body(
    BuildContext ctx,
    UserProfileSetupProvider provider,
  ) {
    double picSize = 175;
    return IgnorePointer(
      ignoring: provider.loading,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ClipOval(
                    child: SizedBox(
                height: picSize,
                width: picSize,
                      child: Image.asset(
                        BASE_IMG_PATH + PROFILE_IMAGE_ICON,
                        errorBuilder: (ctx, o, st) =>
                            const DefaultProfileImageWidget(),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: BUTTON_COLOR,
                        borderRadius: BorderRadius.circular(20.0)),
                    margin: const EdgeInsets.only(bottom: 20.0,right: 20),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            myLocation(),
            CustomTextField(
              lbl: 'Full Name',
              controller: _nameController,
            ),
            CustomTextField(
              lbl: 'Add bio',
              controller: _bioController,
            ),
            CustomTextField(
              lbl: 'City',
              controller: _cityController,
            ),
            CustomTextField(
              lbl: 'Country',
              controller: _countryController,
            ),
            FilledButton(
                onPressed: () async {
                  await provider.setUpUser(
                      _nameController.text, _bioController.text, uid);

                  if (!provider.success && ctx.mounted) {
                    mySnackBar(
                        ctx, provider.msg);
                  } else {
                    await setUserId(uid);
                    Navigator.pushReplacement(
                        ctx,
                        MaterialPageRoute(
                            builder: (ctx) => MainScreen(uid: uid)));
                  }
                },
                child: provider.loading
                    ? CustomProgressIndicator()
                    : const Text('Set Profile')),
                   
          ],
        ),
      ),
    );
  }
}
