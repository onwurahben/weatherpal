import 'package:http/http.dart' as http;
import 'dart:convert';

//Json Decoder class using Http package

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;


  Future getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;

      //This method formats the data
      return jsonDecode(data);

    } else {
      print(response.statusCode);
    }
  }
}
