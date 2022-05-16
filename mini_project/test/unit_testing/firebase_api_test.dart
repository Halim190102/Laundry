import 'package:mini_project/Api/api.dart';
import 'package:mini_project/Model/model_data.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'firebase_api_test.mocks.dart';

@GenerateMocks([DataAPI])
void main() async {
  group(
    'Data API :',
    () {
      DataAPI dataAPI = MockDataAPI();
      test(
        'get all data',
        () async {
          when(dataAPI.getData()).thenAnswer((_) async => <IsiData>[IsiData()]);
          var data = await dataAPI.getData();
          expect(data.isNotEmpty, true);
        },
      );
    },
  );
}
