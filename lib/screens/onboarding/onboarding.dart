import 'package:flutter/material.dart';
import 'package:twenty_four_game/screens/onboarding/components/onboard_page.dart';
import 'package:twenty_four_game/screens/onboarding/data/onboard_page_data.dart';
import 'package:provider/provider.dart';
import 'package:twenty_four_game/providers/color_provider.dart';

class Onboarding extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.width;

    ColorProvider colorProvider = Provider.of<ColorProvider>(context);
    return Stack(
      children: <Widget>[
        PageView.builder(
          itemCount: 4,
          onPageChanged: (int index) {
            colorProvider.color = onboardData[index].secondColor;
          },
          itemBuilder: (context, index) {
            return OnboardPage(
              pageModel: onboardData[index],
            );
          },
        ),
        Container(
          width: double.infinity,
          height: _height/5,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Tutorial',
                    style: Theme.of(context).textTheme.headline4.copyWith(
                      color: colorProvider.color,
                    ),),
                ),
                Spacer(flex: 7),
                GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(context, '/home'),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Skip', style: Theme.of(context).textTheme.headline1.copyWith(
                      color: colorProvider.color,
                    ),),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
