import 'package:body_buddies/core/styles/styles.dart';
import 'package:flutter/cupertino.dart';

class UsefulMiniCardWidget extends StatelessWidget {

  final String assetImage;

  final String title;
  final String? subTitle;

  const UsefulMiniCardWidget(this.subTitle, {super.key, required this.assetImage, required this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          Image(image: AssetImage(assetImage),),
          Positioned(left: 22, top: 130, child: subTitle != null ? Column(children: [
            Text(title, style: Styles.workouts_containers_text_style,),
            Text(subTitle!),
          ],) : Text(title, style: Styles.advices_containers_text_style,))
        ],
      ),
    );
  }
}
