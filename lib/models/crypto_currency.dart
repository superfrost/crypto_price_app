import 'package:bitcoin_app/constants.dart';
import 'package:bitcoin_app/models/internet_controller.dart';


class CryptoCurrency {
  Future<List<dynamic>> getListCriptoCurrency() async {
    var currency = await InternetController().getData('$api_url/coins/markets?vs_currency=usd');
    print(currency);
    return currency;
  }

  Future<Map<String, dynamic>> getCriptoVsCurrency(List<String> crypto, {String currencie = 'usd'}) async {
    String makeStringFromList(List<String> list) {
      String stringFromList = '';
      for (String item in list) {
        stringFromList += item + ',';
      }
      return stringFromList;
    }

    String crip = makeStringFromList(crypto);
    var priceData = await InternetController().getData('$api_url/simple/price?ids=$crip&vs_currencies=$currencie');
    return priceData;
  }
}