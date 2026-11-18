import 'package:flutter/material.dart';
import 'package:twenty_four_game/screens/onboarding/models/onboard_page_model.dart';

class OnboardPage extends StatefulWidget {
  final OnboardPageModel pageModel;

  const OnboardPage({super.key, required this.pageModel});

  @override
  State<StatefulWidget> createState() {
    return _OnboardPageState();
  }
}

class _OnboardPageState extends State<OnboardPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height,
      color: widget.pageModel.primeColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: height/9, left: (widget.pageModel.secondPath != '') ? 15.0: 0),
                child: SizedBox(
                  height: (widget.pageModel.thirdPath == '') ? height / 3 : height/6,
                  width: (widget.pageModel.secondPath == '') ? width*.8 : (width-30)/2,
                  child: FittedBox(
                    child: Image.asset(widget.pageModel.imagePath,
                    ),
                  ),
                ),
              ),
              (widget.pageModel.secondPath != '') ? Padding(
                padding: EdgeInsets.only(top: height/9, right: 15.0),
                child: SizedBox(
                  height: (widget.pageModel.thirdPath == '') ? height / 3 : height/6,
                  width: (width - 30)/2,
                  child: FittedBox(
                    child: Image.asset(widget.pageModel.secondPath,
                    ),
                  ),
                ),
              ) : Container(),
            ],
          ),
          (widget.pageModel.thirdPath != '') ? SizedBox(
            height: height/6,
            width: width,
            child: FittedBox(
              child: Image.asset(widget.pageModel.thirdPath,
              ),
            ),
          ): Container(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.pageModel.caption,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: widget.pageModel.secondColor.withValues(alpha: .8),
                    fontSize: 28,
                      ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height/60, bottom: height/120),
                  child: Text(
                    widget.pageModel.message,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 36,
                      color: widget.pageModel.secondColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height/50),
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            fontSize: 18,
                        color: widget.pageModel.secondColor.withValues(alpha: .9),

                      ),
                      children: [
                        TextSpan(
                          text: widget.pageModel.longMessage,
                        ),
                        (widget.pageModel.pageNumber != 4) ? WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Icon(Icons.chevron_right, color: widget.pageModel.secondColor,),
                          )
                        ) : WidgetSpan(child: Padding(padding: EdgeInsets.zero,)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
