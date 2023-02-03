import 'package:my_genderizeio/my_genderizeio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

import 'genderizeio_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Genderize.io', () {
    // 1
    final client = MockClient();

    // 2
    final genderize = GenderizeAPI(client);

    test('Peter is male', () async {
      // 3
      when(
        client.get(Uri.parse('https://api.genderize.io?name=peter')),
      ).thenAnswer(
        (_) async => http.Response(
          '{"name":"peter","gender":"male","probability":0.99,"count":165452}',
          200,
        ),
      );

      // 4
      final result = await genderize.send('peter');

      // 5
      expect(result.gender, 'male');
    });

    // 6
    test('API exception', () async {
      when(
        client.get(Uri.parse('https://api.genderize.io?name=')),
      ).thenAnswer(
        (_) async => http.Response(
          '{"error":"Missing \'name\' parameter"}',
          500,
        ),
      );
      final result = genderize.send('');
      await expectLater(
        result,
        throwsException,
      );
    });
  });
}
