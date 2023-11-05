import '../const/data.dart';

class DataUtils{
  static pathToUrl(String value) {
    // 여기서 반환된 값이 어노테이션한 속성에 들어감
    return 'http://$ip$value';
  }
}