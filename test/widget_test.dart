import 'package:flutter_test/flutter_test.dart';
import 'package:abc_wonder/data/static/number_data.dart';
import 'package:abc_wonder/data/static/alphabet_data.dart';
import 'package:abc_wonder/data/static/color_data.dart';
import 'package:abc_wonder/data/static/shape_data.dart';
import 'package:abc_wonder/data/static/days_data.dart';
import 'package:abc_wonder/data/static/months_data.dart';

void main() {
  group('Static data integrity', () {
    test('NumberData has exactly 10 items (1-10)', () {
      expect(NumberData.items.length, 10);
      expect(NumberData.byId('1')?.spokenName, 'One');
      expect(NumberData.byId('10')?.spokenName, 'Ten');
      expect(NumberData.byId('0'), isNull);
    });

    test('AlphabetData has 26 letters', () {
      expect(AlphabetData.items.length, 26);
      expect(AlphabetData.byId('A')?.character, 'A');
      expect(AlphabetData.byId('Z')?.character, 'Z');
    });

    test('ColorData has 10 colors', () {
      expect(ColorData.items.length, 10);
      expect(ColorData.byId('red')?.name, 'Red');
    });

    test('ShapeData has 8 shapes', () {
      expect(ShapeData.items.length, 8);
      expect(ShapeData.byId('circle')?.name, 'Circle');
    });

    test('DaysData has 7 days', () {
      expect(DaysData.items.length, 7);
      expect(DaysData.byId('sunday')?.name, 'Sunday');
    });

    test('MonthsData has 12 months', () {
      expect(MonthsData.items.length, 12);
      expect(MonthsData.byId('january')?.name, 'January');
    });
  });
}
