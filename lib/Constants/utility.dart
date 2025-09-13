import 'package:pdf/widgets.dart' as pw;
import 'package:recipe_app/View/all_libs.dart';
import 'package:shared_preferences/shared_preferences.dart';

 Future<String> getUserId() async
{
 final SharedPreferences prefs = await SharedPreferences.getInstance();
  String uid =  prefs.getString('uid')??'';
  return uid;
}

 setUserId(String uid) async
{
   final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('uid', uid);
}

 double getNetRating(int r, int t)
{
    return t==0?0:r/t;
}


  extension EmailValidation on String {
  bool isValidEmail() {
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegex.hasMatch(this);
  }
}

extension TimeFormat on DateTime {
  String get12hrsTime() {
    DateTime dtime = this;
    String time = '';
    String unit = 'am';
    String min = dtime.minute.toString(), hour = dtime.hour.toString();
    
    if(dtime.hour>12)
    {
      hour = (dtime.hour-12).toString();
      unit = 'pm';
    }

    time = '$hour:${min.padLeft(2,'0')} $unit';
    return time;
  }
}

Future<XFile?> selectImage() async {
    final picker = ImagePicker();
    XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
      maxHeight: 300,
    );
    return file;
  }

extension MonthName on int {
  String getMonthName() {
    switch(this)
    {
      case 1:
      return 'January';

      case 2:
      return 'February';

      case 3:
      return 'March';

      case 4:
      return 'April';

      case 5:
      return 'May';

      case 6:
      return 'June';

      case 7:
      return 'July';

      case 8:
      return 'August';

      case 9:
      return 'September';

      case 10:
      return 'October';

      case 11:
      return 'November';

      case 12:
      return 'December';

      default:
      return '';
    }
  }
}

Future<File> generatePDF(Recipe recipe) async {
  try{
    final pdf = pw.Document(
    title: recipe.name
  );

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Center(
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(recipe.name),
            pw.Text('Ingredients'),
            pw.ListView.builder(
              itemCount: recipe.ingredients.length,
              itemBuilder: (context, index) => pw.Text('${index+1} ${recipe.ingredients[index].name}'),
              
            ),

            pw.Text('Procedure'),
            pw.ListView.builder(
              itemCount: recipe.procedure.length,
              itemBuilder: (context, index) => pw.Text('${index+1} ${recipe.procedure[index].procedure}'),
            ),
          ]

        ),
      ),
    ),
  );
  
  String path  =  await getFilePath();
  
  final file = File('$path/${recipe.id}.pdf');
  await file.writeAsBytes(await pdf.save());
  return file;}
  catch(e){rethrow;}
}

Future<String> getFilePath()async
{
  try{

Directory newDir = await Directory('/storage/emulated/0/Download/Recipe App').create(recursive: true)
// The created directory is returned as a Future.
    ;
    return newDir.path;}
    catch(e){rethrow;}
}

Future<bool> locationPermissionGranted(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;
  
  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if(!context.mounted){
    return false;
  }
  
  if (!serviceEnabled && context.mounted) {
    mySnackBar(context, 'Location services are disabled. Please enable the services');
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied ) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied  && context.mounted) {
      mySnackBar(context, 'Location permissions are denied');
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever  && context.mounted) {
    mySnackBar(context, 'Location permissions are permanently denied, we cannot request permissions.');
    return false;
  }
  return true;
}