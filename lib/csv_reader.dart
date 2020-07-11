import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';

class Database {

static List<List<dynamic>> venueDB;
static List<List<double>> _combos;
static List<List<String>> _solutions;

static List<List<double>> getCombos(){
  return Database._combos;
}

static List<List<String>> getSolutions() {
  return Database._solutions;
}

static Future<String> _loadVenueDatabase() async {
  return await rootBundle.loadString('assets/24Solutions.csv');
}

static Future<List<List<dynamic>>> loadVenuedatabase() async {
  String data = await _loadVenueDatabase();
  List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(data);
  return rowsAsListOfValues;
}

static fetchVenueDatabase() async{
  venueDB = await loadVenuedatabase();
  List<String> comboString = venueDB.map<String>((row) => row[1]).toList(growable: false);
  List<List<double>> startingNums = [];
  List<List<String>> totalSolutions = [];
  for (int i = 1; i < comboString.length; i++) {
    String st = comboString[i];
    List<String> sepString = st.trim().split(" ");
    List<double> fourNums = [];
    for (int j = 0; j < sepString.length; j++) {
      fourNums.add(double.parse(sepString[j]));
    }
    List<String> indexedSols = [];
    for (int j = 2; j < venueDB[i].length; j++) {
      if (venueDB[i][j].toString().trim() != '') {
        indexedSols.add(venueDB[i][j].toString().trim());
      }
    }
    fourNums.shuffle(Random());
    startingNums.add(fourNums);
    totalSolutions.add(indexedSols);
  }
  Database._combos = startingNums;
  Database._solutions = totalSolutions;
  }
}

//class TableLayout extends StatefulWidget {
//  @override
//  _TableLayoutState createState() => _TableLayoutState();
//}
//
//class _TableLayoutState extends State<TableLayout> {
//  List<List<dynamic>> data = [];
//  loadAsset() async {
//    final myData = await rootBundle.loadString("assets/24Solutions.csv");
//    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);
//    print(csvTable.elementAt(1).elementAt(1));
//    String st = csvTable.elementAt(1).elementAt(1);
//    print(st);
//    List<String> sepString = st.trim().split(" ");
//    for (int i = 0; i < sepString.length; i++) {
//      int num = int.parse(sepString[i]);
//      print(num);
//    }
//    data = csvTable;
//    setState(() {
//
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//      floatingActionButton: FloatingActionButton(
//          child: Icon(Icons.refresh),
//          onPressed: () async {
//            await loadAsset();
//            //print(data);
//          }),
//      appBar: AppBar(
//        title: Text("Table Layout and CSV"),
//      ),
//
//      body: SingleChildScrollView(
//
//      ),
//    );
//  }
//}