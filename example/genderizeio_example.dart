import 'package:my_genderizeio/my_genderizeio.dart';

void main() async {
  final genderize = GenderizeAPI();
  final result = await genderize.send('peter');
  print('${result.name} ${result.gender}');
}
