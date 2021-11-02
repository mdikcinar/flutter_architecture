import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/constants/enums/preferances_keys_enum.dart';
import '../../extensions/string_extension.dart';
import '../../init/cache/cache_manager.dart';
import '../../init/language/locale_keys.g.dart';
import '../../init/network/network_manager.dart';
import 'db_service_base.dart';

class DbService extends DbServiceBase {
  String? _token;
  String baseApiUrl = 'http://192.168.2.77:3000/api/';

  String? get token => _token;
}
