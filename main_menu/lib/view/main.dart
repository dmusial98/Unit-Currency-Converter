import 'package:flutter/material.dart';
import 'exchange_rates_page.dart';
import 'package:main_menu/UnitMeasureDao.dart';
import 'currency_page.dart';
import 'unit_page.dart';
import 'options_page.dart';
import 'custom_widgets.dart';
import 'exchange_converter_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'database.dart';
import 'package:main_menu/UnitMeasureDB.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await $FloorFlutterDatabase
    .databaseBuilder('flutter_database.db')
    .build();
  final dao = database.unitMeasureDao;

  // await dao.insertUnitMeasure(UnitMeasureDB(null, "kilogram", "kg", 0));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "gram", "g", 0));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "dekagram", "dag", 0));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "miligram", "mg", 0));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "funt", "lb", 0));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "uncja", "oz", 0));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "tona", "t", 0));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "kwintal", "q", 0));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "unit (masa atomowa)", "u", 0));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "karat", "ct", 0));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 0));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 0));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 0));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 0));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 0));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 0));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 0));

  // await dao.insertUnitMeasure(UnitMeasureDB(null, "metr", "m", 1));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "kilometr", "km", 1));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "decymetr", "dm", 1));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "centymetr", "cm", 1));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "milimetr", "mm", 1));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "mila morska", "INM", 1));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "mila angielska", "LM", 1));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "łokieć", "ell", 1));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "stopa", "ft", 1));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "jard", "yd", 1));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 1));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 1));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 1));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 1));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 1));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 1));
  // await dao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 1));

  var test = await dao.findUnitMeasureById(1);
  print("udało się: " + test.name);

  runApp(MyApp(dao));
}

class MyApp extends StatelessWidget {
  final UnitMeasureDao dao;

  const MyApp(this.dao);

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
              fontWeight: FontWeight.w300,
              color: Colors.brown[50]),
          headline3: TextStyle(
              fontSize: 24.0,
              fontFamily: 'Sans',
              fontWeight: FontWeight.w200,
              color: Colors.brown[50]),
          headline4: TextStyle(
              fontSize: 18.0,
              fontFamily: 'Sans',
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w300,
              color: Colors.brown[50]),
        ),
      ),
      home: MainMenu(title: 'Unit Currency Converter', dao: dao),
    );
  }
}

class MainMenu extends StatefulWidget {
  MainMenu({Key key, this.title, this.dao}) : super(key: key);
  final String title;
  final UnitMeasureDao dao;

  @override
  _MainMenuState createState() => _MainMenuState(dao);
}

class _MainMenuState extends State<MainMenu> with TickerProviderStateMixin {
  List<bool> highLightedButton = List.filled(4, false);
  Widget currentPage;
  AnimationController animationController;
  Animation<Offset> pageAnimation;
  Animation<Offset> menuAnimation;
  final UnitMeasureDao dao;

  _MainMenuState(this.dao);

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
          openMenuFunction: mockUp, dao: dao,
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
                    Image(image: AssetImage("png/logo.png"), width: 128, height: 128),
                    Container(
                        margin: EdgeInsets.fromLTRB(0.0, 20.0, 50.0, 50.0),
                        child: Text(
                          "Konwenter definiowalnych miar i walut",
                          style: Theme.of(context).textTheme.headline1,
                        )),
                    MenuEntry(
                        context: context,
                        label: "Konwerter Miar",
                        iconName: "png/unit_conv.png",
                        entryIndex: 0,
                        isHighLighted: isHighLighted,
                        changePage: changePage,
                        correspondingWidget: UnitConverterPage(
                          openMenuFunction: mockUp, dao: dao
                        )),
                    MenuEntry(
                        context: context,
                        label: "Tabela kursów",
                        iconName: "png/curr_conv.png",
                        entryIndex: 1,
                        isHighLighted: isHighLighted,
                        changePage: changePage,
                        correspondingWidget: ExchangeRatesPage(
                          openMenuFunction: mockUp,
                        )),
                    MenuEntry(
                        context: context,
                        label: "Konwerter walut",
                        iconName: "png/curr_tbl.png",
                        entryIndex: 2,
                        isHighLighted: isHighLighted,
                        changePage: changePage,
                        correspondingWidget:
                            ExchangeConverterPage(openMenuFunction: mockUp)),
                    MenuEntry(
                        context: context,
                        label: "Opcje",
                        iconName: "png/options.png",
                        entryIndex: 3,
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
