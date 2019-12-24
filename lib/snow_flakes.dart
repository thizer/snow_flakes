import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations/rendering.dart';
import 'package:snow_flakes/model_flake.dart';

class SnowFlakes extends StatefulWidget {
  @override
  _SnowFlakesState createState() => _SnowFlakesState();
}

class _SnowFlakesState extends State<SnowFlakes> {
  final List<ModelFlake> flakes = [];

  @override
  void initState() {
    List.generate(500, (index) {
      flakes.add(ModelFlake());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    // 360 x 592
    // print(MediaQuery.of(context).size);

    return Rendering(
      startTime: Duration(seconds: 30),
      onTick: _simulateSnowFlakes,
      builder: (context, time) {
        List<Widget> items = [];

        flakes.forEach((item) {
          double progress = item.animationProgress.progress(time);
          final animation = item.tween.transform(progress);

          items.add(Positioned(
            top: animation["x"],
            left: animation["y"],
            child: Container(
              width: item.size,
              height: item.size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(item.size + 50),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 0),
                    blurRadius: 7,
                    spreadRadius: item.size,
                    color: Colors.white,
                  ),
                ],
                color: Colors.white.withOpacity(.2),
              ),
            ),
          ));
        });

        return Stack(children: items);
      },
    );
  }

  void _simulateSnowFlakes(Duration time) {
    flakes.forEach((flake) => flake.maintainRestart(time));
  }
}
