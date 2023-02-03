import 'package:my_genderizeio/genderizeio.dart';

void main() async {
  final genderize = GenderizeAPI();
  final result = await genderize.send('peter');
  print('${result.name} ${result.gender}');
}
