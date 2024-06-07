import 'package:admins/const/const.dart';
import 'package:admins/views/widgets/text_style.dart';

Widget customTextField({label, hint, controller}) {
  return TextFormField(
    decoration: InputDecoration(
      isDense: true,
      label: normalText(text: label),
      // enabledBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(12),
      //   borderSide: BorderSide(
      //     color: white,
      //   ),
      // ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: white,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: white,
        ),
      ),
      hintText: hint,
      hintStyle: TextStyle(color: lightGrey),
    ),
  );
}
