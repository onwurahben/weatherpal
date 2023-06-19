import 'package:http/http.dart' as http;
import 'dart:convert';

//Json Decoder class using Http package

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;


  Future getData() async {

    // http.get requests data from the url
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;

      //This method formats the data from json string to objects
      return jsonDecode(data);

    } else {
      print(response.statusCode);
    }
  }
}
