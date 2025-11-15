import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:query_assistant_padi/utils/toast_utils.dart';

class ResopnseInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage = "网络错误";
    if (err.type == DioExceptionType.connectionTimeout) {
      errorMessage = "连接超时";
    } else if (err.type == DioExceptionType.sendTimeout) {
      errorMessage = "请求超时";
    } else if (err.type == DioExceptionType.receiveTimeout) {
      errorMessage = "响应超时";
    } else if (err.type == DioExceptionType.badResponse) {
      errorMessage = "服务器响应错误";
    } else if (err.type == DioExceptionType.badCertificate) {
      errorMessage = "证书验证失败";
    } else if (err.type == DioExceptionType.connectionError) {
      errorMessage = "网络连接错误";
    } else if (err.type == DioExceptionType.unknown) {
      errorMessage = "未知错误";
    } else if (err.type == DioExceptionType.cancel) {
      errorMessage = "请求取消";
    } else if (err.response?.statusCode == 404) {
      errorMessage = "请求资源不存在";
    }
    debugPrint(errorMessage);
    ToastUtils.showErrorMsg(errorMessage);
    return handler.next(err);
  }
}
