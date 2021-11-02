import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../base/model/base_model.dart';

class NetworkManager {
  late Dio _dio;
  static NetworkManager? _instance;
  static NetworkManager get instance {
    if (_instance == null) return _instance = NetworkManager._init();
    return _instance!;
  }

  NetworkManager._init() {
    final baseOptions = BaseOptions();
    _dio = Dio(baseOptions);
    _dio.interceptors.add(InterceptorsWrapper(
        /*onError: (e) {
        return BaseError(e.message);
      },*/
        ));
  }

  Future dioGet<T extends BaseModel>({required String path, required T model, Options? options}) async {
    try {
      final response = await _dio.get(path, options: options);

      switch (response.statusCode) {
        case HttpStatus.ok:
          final responseBody = response.data;
          if (responseBody is List) {
            return responseBody.map((e) => model.fromJson(e)).toList();
          } else if (responseBody is Map) {
            return model.fromJson(responseBody as Map<String, dynamic>);
          } else {
            if (responseBody['message'] != null) {
              debugPrint('Dio get error message: ' + responseBody['message']);
              return;
            }
          }
          return responseBody;
        default:
      }
    } catch (err) {
      if (err is DioError) {
        Fluttertoast.showToast(msg: 'Request failed. Please check your internet connection');
      }
      debugPrint('Error:' + err.toString());
    }
  }

  Future get({required String path, Options? options}) async {
    try {
      final response = await _dio.get(path, options: options);

      switch (response.statusCode) {
        case HttpStatus.ok:
          final responseBody = response.data;
          return responseBody;
        case HttpStatus.unauthorized:
          Fluttertoast.showToast(msg: 'Token experied. Please login again.');
          break;
        default:
      }
    } catch (err) {
      if (err is DioError) {
        Fluttertoast.showToast(msg: 'Request failed. Please check your internet connection');
      }
      debugPrint('Error:' + err.toString());
    }
  }

  Future post({required url, Map<String, dynamic>? data, Options? options}) async {
    try {
      final response = await _dio.post(url, data: data, options: options);
      switch (response.statusCode) {
        case HttpStatus.ok:
          final responseBody = response.data;
          return responseBody;

        case HttpStatus.created:
          final responseBody = response.data;
          return responseBody;
        case HttpStatus.unauthorized:
          Fluttertoast.showToast(msg: 'Token experied. Please login again.');
          break;

        default:
          final responseBody = response.data;
          return responseBody;
      }
    } catch (err) {
      if (err is DioError) {
        Fluttertoast.showToast(msg: 'Request failed. Please check your internet connection');
      }
      debugPrint('Error:' + err.toString());
    }
  }

  Future patch({required url, Map<String, dynamic>? data, Options? options}) async {
    try {
      final response = await _dio.patch(url, data: data, options: options);
      switch (response.statusCode) {
        case HttpStatus.ok:
          final responseBody = response.data;
          return responseBody;
        case HttpStatus.unauthorized:
          Fluttertoast.showToast(msg: 'Token experied. Please login again.');
          break;
        default:
          final responseBody = response.data;
          return responseBody;
      }
    } catch (err) {
      if (err is DioError) {
        Fluttertoast.showToast(msg: 'Request failed. Please check your internet connection');
      }
      debugPrint('Error:' + err.toString());
    }
  }

  Future delete({required url, Map<String, dynamic>? data, Options? options}) async {
    try {
      final response = await _dio.delete(url, data: data, options: options);
      switch (response.statusCode) {
        case HttpStatus.ok:
          final responseBody = response.data;
          return responseBody;
        case HttpStatus.unauthorized:
          Fluttertoast.showToast(msg: 'Token experied. Please login again.');
          break;
        default:
          final responseBody = response.data;
          return responseBody;
      }
    } catch (err) {
      if (err is DioError) {
        Fluttertoast.showToast(msg: 'Request failed. Please check your internet connection');
      }
      debugPrint('Error:' + err.toString());
    }
  }
}
