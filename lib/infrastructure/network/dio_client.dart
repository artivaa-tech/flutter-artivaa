import 'package:dio/dio.dart';

import '../shared/dio_logger.dart';
import 'api_constants.dart';

class DioClient {
  Dio _dio = Dio();
  DioException? _dioError;
  var apiEndPoints = ApiConstants();
  var tag = 'ApiProvider';

  DioClient.base({remoteBaseUrl, accessToken}) {
    print(accessToken);
    var baseUrl = remoteBaseUrl ?? apiEndPoints.baseUrl;
    BaseOptions dioOptions = BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        // 10 seconds
        receiveTimeout: const Duration(seconds: 30),
        receiveDataWhenStatusError: true,
        followRedirects: false,
        baseUrl: baseUrl);
    _dio = Dio(dioOptions);
    _dio.interceptors.add(
        QueuedInterceptorsWrapper(onRequest: (RequestOptions options, handler) {
          if (accessToken != null && accessToken
              .toString()
              .isNotEmpty) {
            options.headers = {
              'Authorization': 'Bearer $accessToken',
              'content-type': 'application/json',
            };
          }
          DioLogger.onSend(tag, options);
          return handler.next(options);
        }, onResponse: (Response response, handler) {
          DioLogger.onSuccess(tag, response);
          return handler.next(response);
        }, onError: (DioException error, handler) async {
          _dioError = error;
          DioLogger.onError(tag, error);
          return handler.next(error);
        }));
  }

  //multipart
  DioClient.multipartBase({remoteBaseUrl, accessToken}) {
    var baseUrl = remoteBaseUrl ?? apiEndPoints.baseUrl;
    BaseOptions dioOptions = BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        receiveDataWhenStatusError: true,
        followRedirects: false,
        baseUrl: baseUrl);
    _dio = Dio(dioOptions);
    _dio.interceptors.add(
        QueuedInterceptorsWrapper(onRequest: (RequestOptions options, handler) {
          DioLogger.onSend(tag, options);
          if (accessToken != null && accessToken
              .toString()
              .isNotEmpty) {
            options.headers = {
              'Authorization': 'Bearer $accessToken',
              'Content-Type': 'multipart/form-data'
            };
          } else {
            options.headers = {
              'Content-Type':
              'multipart/form-data; boundary=<calculated when request is sent>'
            };
          }

          DioLogger.onSend(tag, options);
          return handler.next(options);
        }, onResponse: (Response response, handler) {
          DioLogger.onSuccess(tag, response);
          return handler.next(response);
        }, onError: (DioException error, handler) async {
          _dioError = error;
          DioLogger.onError(tag, error);
          return handler.next(error);
        }));
  }

/// auth


/*
  Future getMyCircle(params) async {
    try {
      Response response = await _dio.get(apiEndPoints.apiMyFollowersFollowing,queryParameters: params);
      return ApiResponseModel<MyCircleModel>.fromJson(
          response.data, (data) => MyCircleModel.fromJson(data));
    } catch (error, _) {
      catchErrorHandler();
    }
    return null;
  }

  Future getMyCommunities(params) async {
    try {
      Response response = await _dio.get(apiEndPoints.getMyCommunities, queryParameters: params);
      return ApiResponseModel<CommunityModel>.fromJson(
          response.data, (data) => CommunityModel.fromJson(data));
    } catch (error, _) {
      catchErrorHandler();
    }
    return null;
  }
*/
}
