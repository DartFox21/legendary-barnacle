import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:retry/retry.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<bool> refund(String id) async {
    late bool value;
    try {
      http.Response access = await retry(
        () async => await http
            .get(
              Uri.parse(
                  'https://us-central1-godart-60d60.cloudfunctions.net/api/initiaterefund?transaction=$id'),
            )
            .timeout(const Duration(seconds: 10)),
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );
      Map bank = jsonDecode(access.body);
      if (access.statusCode == 200) {
        Map banks = jsonDecode(access.body);

        value = banks['status'];
      } else {
        value = false;
        print(bank);
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
    return value;
  }
}
