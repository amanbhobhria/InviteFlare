/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */


import 'package:dio/dio.dart';
import 'package:invite_flare/core_2/core/translations/local_keys.dart';
import 'package:invite_flare/core_2/data/remote_service/network/error_message_response_model.dart';

import '../../../../export.dart';

// ignore: avoid_classes_with_only_static_members
class NetworkExceptions {
  static String messageData = "";

  static getDioException(error) {
    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              return messageData = stringRequestCancelled.tr;
            case DioExceptionType.connectionTimeout:
              return messageData = stringConnectionTimeout.tr;
            case DioExceptionType.unknown:
              List<String> dateParts = error.message!.split(":");
              List<String> message = dateParts[2].split(",");

              if (message[0].trim() == stringConnectionRefused.tr) {
                return messageData = stringServerMaintenance.tr;
              } else if (message[0].trim() == stringNetworkUnreachable.tr) {
                return messageData = stringNetworkUnreachable.tr;
              } else if (dateParts[1].trim() == stringFailedToConnect.tr) {
                return messageData = stringInternetConnection.tr;
              } else {
                return messageData = dateParts[1];
              }
            case DioExceptionType.receiveTimeout:
              return messageData = stringTimeOut.tr;
            case DioExceptionType.badResponse:
              switch (error.response!.statusCode) {
                case 400:
                  Map<String, dynamic> data = error.response?.data;
                  if (data.values.elementAt(0).runtimeType == String) {
                    return messageData = data.values.elementAt(0);
                  } else {
                    Map<String, dynamic> datas = data.values.elementAt(0);
                    if (data.values.elementAt(0) == null) {
                      var dataValue = ErrorMessageResponseModel.fromJson(
                          error.response?.data)
                          .message;
                      if (dataValue == null) {
                        return messageData = stringUnAuthRequest.tr;
                      } else {
                        return messageData = dataValue;
                      }
                    } else {
                      return messageData = datas.values.first[0];
                    }
                  }
                case 401:
                  // TODO: remove LocalKey_token
                  // storage.remove(LOCALKEY_token);
                  try {
                    return messageData = error.response?.data['message'] ??
                        'Unauthorised Exception';
                  } catch (err) {
                    return messageData = 'Unauthorised Exception';
                  }
                case 403:
                  // TODO: remove LocalKey_token
                  // storage.remove(LOCALKEY_token);
                  try {
                    return messageData = error.response?.data['message'] ??
                        'Unauthorised Exception';
                  } catch (err) {
                    return messageData = 'Unauthorised Exception';
                  }
                case 404:
                  return messageData = stringNotFound.tr;
                case 408:
                  return messageData = stringRequestTimeOut.tr;
                case 500:
                  return messageData = stringInternalServerError.tr;
                case 503:
                  return messageData = stringInternetServiceUnavailable.tr;
                default:
                  return messageData = stringSomethingsIsWrong.tr;
              }
            case DioExceptionType.sendTimeout:
              return messageData = stringTimeOut;
            case DioExceptionType.badCertificate:
              // TODO: Handle this case.
              break;
            case DioExceptionType.badResponse:
              // TODO: Handle this case.
              break;
            case DioExceptionType.connectionError:
              // TODO: Handle this case.
              break;
          }
        } else if (error is SocketException) {
          return messageData = socketExceptions.tr;
        } else {
          return messageData = stringUnexpectedException.tr;
        }
      } on FormatException catch (_) {
        return messageData = stringFormatException.tr;
      } catch (_) {
        return messageData = stringUnexpectedException.tr;
      }
    } else {
      if (error.toString().contains(stringNotSubType.tr)) {
        return messageData = stringUnableToProcessData.tr;
      } else {
        return messageData = stringUnexpectedException.tr;
      }
    }
  }
}
