import 'package:flutter_test/flutter_test.dart';
import 'package:twenty_four_game/csv_reader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('loads every puzzle from 24Solutions.csv', () async {
    await Database.fetchVenueDatabase();

    final combos = Database.getCombos();
    final solutions = Database.getSolutions();
    final labels = Database.writCombos();

    expect(Database.isLoaded, isTrue);
    expect(combos, isNotEmpty);
    expect(solutions.length, combos.length);
    expect(labels.length, combos.length);

    for (var i = 0; i < combos.length; i++) {
      expect(combos[i].length, 4, reason: 'puzzle $i should have 4 numbers');
      expect(solutions[i], isNotEmpty, reason: 'puzzle $i has no solutions');
      expect(labels[i].split(', ').length, 4);
    }
  });
}
