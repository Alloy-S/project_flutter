import 'package:admins/const/const.dart';

Widget orderCourierDetails({title1, title2, d1, d2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "$title1".text.fontWeight(FontWeight.w600).make(),
            "$d1".text.make()
          ],
        ),
        SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "$title2".text.fontWeight(FontWeight.w600).make(),
              "$d2".text.make(),
            ],
          ),
        ),
      ],
    ),
  );
}
