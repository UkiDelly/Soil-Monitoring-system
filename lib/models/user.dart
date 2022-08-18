import 'package:dio/dio.dart';
import 'package:jwt_decode/jwt_decode.dart';

class User {
  String username, password;
  String? name;

  User({required this.password, required this.username, this.name});

  var _token;
  String _userId = '';

  // getter
  get userId => _userId;
  get token => _token;

  login() async {
    const url = "https://soil-analysis-usls.herokuapp.com/v1/user/login";

    var response = await Dio()
        .post(url, data: {'username': username, 'password': password});

    // var response = await http.post(Uri.parse(url),
    //     body: {'username': username, 'password': password});

    if (response.statusCode == 200) {
      var item = response.data;

      // decode the token to get th userId
      var decodeToken = Jwt.parseJwt(item['data']['authToken']);

      // save the userId
      _userId = decodeToken['_id'];

      //save the token into the class
      _token = item['data']['authToken'];

      // No user exist
    } else if (response.statusCode == 401) {
      _token = false;

      // Server is offline
    }
  }

  //TODO: fix this
  register() async {
    const url = "https://soil-analysis-usls.herokuapp.com/v1/user/create";

    var response = await Dio().post(url,
        data: {'name': name, 'username': username, 'password': password});

    // var response = await http.post(Uri.parse(url),
    //     body: {'name': name, 'username': username, 'password': password});
    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }
}
