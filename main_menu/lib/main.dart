import 'package:flutter/material.dart';
import 'currency_page.dart';
import 'unit_page.dart';
import 'options_page.dart';
import 'custom_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 36.0,
              fontFamily: 'Sans',
              fontWeight: FontWeight.w300,
              color: Colors.brown[50]),
          headline2: TextStyle(
              fontSize: 24.0,
              fontFamily: 'Sans',
              fontWeight: FontWeight.w200,
              color: Colors.brown[50]),
        ),
      ),
      home: MainMenu(title: 'Unit Currency Converter'),
    );
  }
}

class MainMenu extends StatefulWidget {
  MainMenu({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> with TickerProviderStateMixin {
  List<bool> highLightedButton = List.filled(3, false);
  Widget currentPage;
  AnimationController animationController;
  Animation<Offset> pageAnimation;
  Animation<Offset> menuAnimation;

  void changePage(int index, Widget newTopWidget) {
    if (highLightedButton[index] == true) {
      animationController.animateTo(1.0);
      return;
    }

    animationController.animateTo(0.0);

    currentPage = newTopWidget;

    animationController.animateTo(1.0);
    setState(() {
      for (int i = 0; i < highLightedButton.length; i++)
        highLightedButton[i] = false;
      highLightedButton[index] = true;
    });
  }

  bool isHighLighted(int index) => highLightedButton[index];

  void mockUp() {
    // animation to .5
    animationController.animateTo(0.5);
  }

  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    pageAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOutCubic,
    ));

    menuAnimation = Tween<Offset>(
      begin: const Offset(1.075, 0.0),
      end: const Offset(-1.0, 0.0),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOutCubic,
    ));

    changePage(
        0,
        UnitConverterPage(
          openMenuFunction: mockUp,
        ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(color: Colors.blueGrey[900]),
      SlideTransition(
          position: menuAnimation,
          child: Scaffold(
              backgroundColor: Colors.blueGrey[900],
              body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset("svg/logo_circlecompass.svg"),
                    Container(
                        margin: EdgeInsets.fromLTRB(0.0, 20.0, 50.0, 50.0),
                        child: Text(
                          "Konwenter definiowalnych miar i walut",
                          style: Theme.of(context).textTheme.headline1,
                        )),
                    MenuEntry(
                        context: context,
                        label: "Konwerter Miar",
                        iconName: "svg/unit_speedometer.svg",
                        entryIndex: 0,
                        isHighLighted: isHighLighted,
                        changePage: changePage,
                        correspondingWidget: UnitConverterPage(
                          openMenuFunction: mockUp,
                        )),
                    MenuEntry(
                        context: context,
                        label: "Tabela kursów",
                        iconName: "svg/currency_money.svg",
                        entryIndex: 1,
                        isHighLighted: isHighLighted,
                        changePage: changePage,
                        correspondingWidget: CurrencyConverterPage(
                          openMenuFunction: mockUp,
                        )),
                    MenuEntry(
                        context: context,
                        label: "Opcje",
                        iconName: "svg/options_paintroller.svg",
                        entryIndex: 2,
                        isHighLighted: isHighLighted,
                        changePage: changePage,
                        correspondingWidget:
                            OptionsPage(openMenuFunction: mockUp)),
                  ]))),
      SlideTransition(
          position: pageAnimation,
          child: ScaleTransition(
              scale: CurvedAnimation(
                  curve: Curves.easeInOutCubic, parent: animationController),
              child: currentPage))
      //
    ]);
  }
}
