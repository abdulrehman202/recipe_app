import 'package:recipe_app/View/all_libs.dart';

class CustomImageWidget extends StatelessWidget {
  String imgUrl;
  BoxFit cBoxFit;
  CustomImageWidget({super.key,required this.imgUrl, this.cBoxFit = BoxFit.fill});

  @override
  Widget build(BuildContext context) {
    return imgUrl == ''? errorImage(): Image.network(
                imgUrl,
                errorBuilder: (context, error, stackTrace)=> errorImage(),
                fit: cBoxFit,
              );
  }

  Image errorImage()
  {
    return Image.asset( BASE_IMG_PATH+ MICKEY_MOUSE_DP, fit: BoxFit.fill,);
  }
}