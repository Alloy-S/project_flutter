import 'package:admins/const/const.dart';

Widget loadingIndicator({circleColor = purpleColor}) {
  
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(circleColor),
    ),
  );
}