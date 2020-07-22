import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';

class Database {

static List<List<dynamic>> _venueDB = [];
static List<List<double>> _combos;
static List<String> _writCombos;
static List<List<double>> _combos2;
static List<List<String>> _solutions;
static bool isLoaded = false;

static void resetValues() {
  Database._combos = Database._combos2;
}

static List<List<double>> getCombos(){
  return Database._combos;
}

static List<String> writCombos() {
  return Database._writCombos;
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
  _venueDB = await loadVenuedatabase();
  List<String> comboString = _venueDB.map<String>((row) => row[1]).toList(growable: false);
  List<List<double>> startingNums = [];
  List<String> wCombs =[];
  List<List<String>> totalSolutions = [];
  for (int i = 1; i < comboString.length; i++) {
    String st = comboString[i];
    List<String> sepString = st.trim().split(" ");
    List<double> fourNums = [];
    String writNums = '';
    for (int j = 0; j < sepString.length; j++) {
      fourNums.add(double.parse(sepString[j]));
      writNums += double.parse(sepString[j]).toInt().toString();
      if (j != sepString.length - 1) {
        writNums += ', ';
      }
    }
    List<String> indexedSols = [];
    for (int j = 2; j < _venueDB[i].length; j++) {
      if (_venueDB[i][j].toString().trim() != '') {
        indexedSols.add(_venueDB[i][j].toString().trim().replaceAll('/', String.fromCharCode(247)));
      }
    }
    fourNums.shuffle(Random());
    startingNums.add(fourNums);
    wCombs.add(writNums);
    totalSolutions.add(indexedSols);
  }
  Database._combos = startingNums;
  Database._combos2 = Database._combos;
  Database._writCombos = wCombs;
  Database._solutions = totalSolutions;
  Database.isLoaded = true;
  }
}