import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twenty_four_game/screens/onboarding/models/onboard_page_model.dart';

class OnboardPage extends StatefulWidget {
  final OnboardPageModel pageModel;

  const OnboardPage({Key key, this.pageModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OnboardPageState();
  }
}

class _OnboardPageState extends State<OnboardPage> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Container(
      width: _width,
      height: _height,
      color: widget.pageModel.primeColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: _height/9, left: (widget.pageModel.secondPath != '') ? 15.0: 0),
                child: Container(
                  height: (widget.pageModel.thirdPath == '') ? _height / 3 : _height/6,
                  width: (widget.pageModel.secondPath == '') ? _width*.8 : (_width-30)/2,
                  child: FittedBox(
                    child: Image.asset(widget.pageModel.imagePath,
                    ),
                  ),
                ),
              ),
              (widget.pageModel.secondPath != '') ? Padding(
                padding: EdgeInsets.only(top: _height/9, right: 15.0),
                child: Container(
                  height: (widget.pageModel.thirdPath == '') ? _height / 3 : _height/6,
                  width: (_width - 30)/2,
                  child: FittedBox(
                    child: Image.asset(widget.pageModel.secondPath,
                    ),
                  ),
                ),
              ) : Container(),
            ],
          ),
          (widget.pageModel.thirdPath != '') ? Container(
            height: _height/6,
            width: _width,
            child: FittedBox(
              child: Image.asset(widget.pageModel.thirdPath,
              ),
            ),
          ): Container(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.pageModel.caption,
                    style: Theme.of(context).textTheme.headline3.copyWith(
                      color: widget.pageModel.secondColor.withOpacity(.8),
                      fontSize: 28,
                        ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: _height/60, bottom: _height/120),
                    child: Text(
                      widget.pageModel.message,
                      style: Theme.of(context).textTheme.headline4.copyWith(
                        fontSize: 36,
                        color: widget.pageModel.secondColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 18.0),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.headline4.copyWith(
                              fontSize: 20,
                          color: widget.pageModel.secondColor.withOpacity(.9),

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
            ),
          )
        ],
      ),
    );
  }
}
