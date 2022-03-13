import 'dart:convert';

import 'package:http/http.dart' as http;

const String ROOT = 'http://user-api-dev.london-design-studios.com/';
const String REGISTRATION_ONE = '$ROOT/api/v1/otps/register/send';
const String REGISTRATION_TWO = '$ROOT/api/v1/users/register';
const String LOGIN = '$ROOT/api/v1/users/login';

class CallApi {


  final String _url = 'http://user-api-dev.london-design-studios.com/';
  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;

    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  _setHeaders() => {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      };
}
