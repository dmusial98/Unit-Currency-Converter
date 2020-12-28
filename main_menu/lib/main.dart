import 'package:flutter/material.dart';
import 'package:main_menu/database/unit_type_db/unit_type_db.dart';
import 'database/database.dart';
import 'database/unit_measure_db/unit_measure_db.dart';
import 'database/unit_type_db/unit_type_dao.dart';
import 'view/exchange_rates_page.dart';
import 'database/unit_measure_db/unit_measure_dao.dart';
import 'view/unit_page.dart';
import 'view/custom_widgets.dart';
import 'view/exchange_converter_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await $FloorFlutterDatabase
      .databaseBuilder('flutter_database.db')
      .build();
  final unitMeasureDao = database.unitMeasureDao;
  final unitTypeDao = database.unitTypeDao;

  // await unitTypeDao.insertUnitType(UnitTypeDB(null, "Masa"));
  // await unitTypeDao.insertUnitType(UnitTypeDB(null, "Długość"));
  // await unitTypeDao.insertUnitType(UnitTypeDB(null, "Czas"));
  
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "kilogram", "kg", 1, "#kg = #g * 1000", "#g = #kg / 1000", 0));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "gram", "g", 1, "#g = #kg / 1000", "#kg = #g * 1000", 0));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "dekagram", "dag", 1, "#dag = #g * 100", "#g = #dag / 100", 0));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "miligram", "mg", 1, "#mg = #g / 1000", "#g = #mg * 1000", 0));
  
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "metr", "m", 2, "#m = #km / 1000", "#km = #m * 1000", 0));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "kilometr", "km", 2, "#km = #m * 1000", "#m = #km / 1000", 0));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "decymetr", "dm", 2, "#dm = #cm * 10", "#m = #dm * 10", 0));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "centymetr", "cm", 2, "#cm = #m / 100", "#dm = #cm * 10", 0));

  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "sekunda", "s", 3, "#s = #m / 60", "#h = #s * 3600", 0));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "godzina", "h", 3, "#h = 60 * #m", "#m = #h / 60", 0));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "minuta", "m", 3, "#m = #s * 60", "#h = #m * 60", 0));

  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "funt", "lb", 1, 5));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "uncja", "oz", 1, 6));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "tona", "t", 1, 7));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "kwintal", "q", 1, 8));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "unit (masa atomowa)", "u", 1, 9));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "karat", "ct", 1, 10));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 1, 11));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 1, 12));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 1, 13));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 1, 14));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 1, 15));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 1, 16));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 1, 17));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "milimetr", "mm", 2, 5));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "mila morska", "INM", 2, 6));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "mila angielska", "LM", 2, 7));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "łokieć", "ell", 2, 8));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "stopa", "ft", 2, 9));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "jard", "yd", 2, 10));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 2, 11));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 2, 12));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 2, 13));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 2, 14));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 2, 15));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 2, 16));
  // await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(null, "Jednostka", "jed", 2, 17));

  var test = await unitMeasureDao.findUnitMeasureById(1);
  print("udało się: " + test.name);

  var test2 = await unitTypeDao.getAllUnitTypes();
  print('udało się: ' + test2[2].name);

  runApp(MyApp(unitMeasureDao, unitTypeDao));
}

class MyApp extends StatelessWidget {
  final UnitMeasureDao unitMeasureDao;
  final UnitTypeDao unitTypeDao;

  const MyApp(this.unitMeasureDao, this.unitTypeDao);

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
      home: MainMenu(title: 'Unit Currency Converter', unitMeasureDao: unitMeasureDao, unitTypeDao: unitTypeDao),
    );
  }
}

class MainMenu extends StatefulWidget {
  MainMenu({Key key, this.title, this.unitMeasureDao, this.unitTypeDao}) : super(key: key);
  final String title;
  final UnitMeasureDao unitMeasureDao;
  final UnitTypeDao unitTypeDao;

  @override
  _MainMenuState createState() => _MainMenuState(unitMeasureDao, unitTypeDao);
}

class _MainMenuState extends State<MainMenu> with TickerProviderStateMixin {
  List<bool> highLightedButton = List.filled(3, false);
  Widget currentPage;
  AnimationController animationController;
  Animation<Offset> pageAnimation;
  Animation<Offset> menuAnimation;
  final UnitMeasureDao unitMeasureDao;
  final UnitTypeDao unitTypeDao;

  _MainMenuState(this.unitMeasureDao, this.unitTypeDao);

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
          unitMeasureDao: unitMeasureDao,
          unitTypeDao: unitTypeDao,
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
                    Image(
                        image: AssetImage("png/logo.png"),
                        width: 128,
                        height: 128),
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
                            openMenuFunction: mockUp, unitMeasureDao: unitMeasureDao, unitTypeDao: unitTypeDao)),
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
