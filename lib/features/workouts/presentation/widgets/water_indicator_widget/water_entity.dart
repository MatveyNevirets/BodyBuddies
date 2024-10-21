import 'package:body_buddies/features/workouts/presentation/widgets/water_indicator_widget/water_indicator_widget.dart';
import 'package:flutter/cupertino.dart';

class WaterEntity extends StatefulWidget {

  bool isDone = false;
  int index;

  WaterEntity(this.index);

  @override
  State<WaterEntity> createState() => _WaterEntityState();
}

class _WaterEntityState extends State<WaterEntity> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void changeNewState() {
    setState(() {
      widget.isDone = !widget.isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: changeNewState,
      child: Stack(children: [
        Image.network("https://w7.pngwing.com/pngs/55/817/png-transparent-clear-glass-cup-with-water-cup-glass-drinking-water-champagne-glass-glass-tumbler-drinking-thumbnail.png", height: 50, width: 50,),
        doneIcon(),
      ], alignment: Alignment.bottomRight,),
    );
  }

  Widget doneIcon() {
    if(widget.isDone) {
      return Image.network("https://cdn-icons-png.flaticon.com/512/2550/2550322.png", height: 10, width: 10,);
    } else {
      return SizedBox();
    }
  }
}