// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import 'dart:convert';

import '../Global/urls.dart';
import '../Global/utils.dart';

class Controller {
  Future<dynamic> postApi({endpoint, body}) async {
    try {
      logs("$apiurl/$endpoint");
      var res = await http.post(Uri.parse("$apiurl/$endpoint"),
          headers: <String, String>{
            'Context-Type': 'application/json;charSet=UTF-8'
          },
          body: body);
      logs(res.body);
      if (res.statusCode == 200) {
        final data = await json.decode(res.body);
        return data;
      } else {
        logs("error occur");
        return null;
      }
    } catch (e) {
      logs(e);
    }
  }

  Future<dynamic> getApi({id, endpoint}) async {
    logs("$apiurl/$endpoint/$id");
    try {
      var res = await http.get(
        Uri.parse("$apiurl/$endpoint/$id"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
      );
      logs(res.body);
      if (res.statusCode == 200) {
        final data = await json.decode(res.body);
        logs(data);

        return data;
      } else {
        return "error";
      }
    } catch (e) {
      logs(e);
    }
  }

  Future<dynamic> deleteApi({id, endpoint}) async {
    logs("$apiurl/$endpoint/$id");
    try {
      var res = await http.delete(
        Uri.parse("$apiurl/$endpoint/$id"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
      );

      if (res.statusCode == 200) {
        final data = await json.decode(res.body);

        logs(data);

        return data;
      } else {
        return "error";
      }
    } catch (e) {
      logs(e);
    }
  }

  Future<dynamic> sendEmailApi({endpoint, body}) async {
    try {
      logs("$endpoint");

      logs("$body");
      var res = await http.post(Uri.parse("$endpoint"),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: body);
      logs(res.body);
      if (res.statusCode == 200) {
        final data = res.body;
        logs(data);
        return data;
      } else {
        logs("error occur");
      }
    } catch (e) {
      logs(e);
    }
  }
}
