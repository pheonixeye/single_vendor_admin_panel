import 'package:equatable/equatable.dart';

class AppUserLog extends Equatable {
  //TODO: remove unnessecary data
  final String event;
  final String userId;
  final String userEmail;
  final String userName;
  final String mode;
  final String ip;
  final String time;
  final String osCode;
  final String osName;
  final String osVersion;
  final String clientType;
  final String clientCode;
  final String clientName;
  final String clientVersion;
  final String clientEngine;
  final String clientEngineVersion;
  final String deviceName;
  final String deviceBrand;
  final String deviceModel;
  final String countryCode;
  final String countryName;

  const AppUserLog({
    required this.event,
    required this.userId,
    required this.userEmail,
    required this.userName,
    required this.mode,
    required this.ip,
    required this.time,
    required this.osCode,
    required this.osName,
    required this.osVersion,
    required this.clientType,
    required this.clientCode,
    required this.clientName,
    required this.clientVersion,
    required this.clientEngine,
    required this.clientEngineVersion,
    required this.deviceName,
    required this.deviceBrand,
    required this.deviceModel,
    required this.countryCode,
    required this.countryName,
  });

  factory AppUserLog.fromJson(Map<String, dynamic> json) {
    return AppUserLog(
      event: json['event'],
      userId: json['userId'],
      userEmail: json['userEmail'],
      userName: json['userName'],
      mode: json['mode'],
      ip: json['ip'],
      time: json['time'],
      osCode: json['osCode'],
      osName: json['osName'],
      osVersion: json['osVersion'],
      clientType: json['clientType'],
      clientCode: json['clientCode'],
      clientName: json['clientName'],
      clientVersion: json['clientVersion'],
      clientEngine: json['clientEngine'],
      clientEngineVersion: json['clientEngineVersion'],
      deviceName: json['deviceName'],
      deviceBrand: json['deviceBrand'],
      deviceModel: json['deviceModel'],
      countryCode: json['countryCode'],
      countryName: json['countryName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['event'] = event;
    data['userId'] = userId;
    data['userEmail'] = userEmail;
    data['userName'] = userName;
    data['mode'] = mode;
    data['ip'] = ip;
    data['time'] = time;
    data['osCode'] = osCode;
    data['osName'] = osName;
    data['osVersion'] = osVersion;
    data['clientType'] = clientType;
    data['clientCode'] = clientCode;
    data['clientName'] = clientName;
    data['clientVersion'] = clientVersion;
    data['clientEngine'] = clientEngine;
    data['clientEngineVersion'] = clientEngineVersion;
    data['deviceName'] = deviceName;
    data['deviceBrand'] = deviceBrand;
    data['deviceModel'] = deviceModel;
    data['countryCode'] = countryCode;
    data['countryName'] = countryName;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  List<Object?> get props => [
        event,
        userId,
        userEmail,
        userName,
        mode,
        ip,
        time,
        osCode,
        osName,
        osVersion,
        clientType,
        clientCode,
        clientName,
        clientVersion,
        clientEngine,
        clientEngineVersion,
        deviceName,
        deviceBrand,
        deviceModel,
        countryCode,
        countryName
      ];
}

List<AppUserLog> appUserLogListFromJson(List<Map<String, dynamic>> json) {
  return json.map((e) => AppUserLog.fromJson(e)).toList();
}

List<Map<String, dynamic>> appUserLogListToJson(List<AppUserLog> list) {
  return list.map((e) => e.toJson()).toList();
}

class AppUserLogData extends Equatable {
  final int total;
  final List<AppUserLog> logs;

  const AppUserLogData({
    required this.total,
    required this.logs,
  });

  factory AppUserLogData.fromJson(Map<String, dynamic> json) {
    return AppUserLogData(
      total: json['total'],
      logs: appUserLogListFromJson(json['logs']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'logs': appUserLogListToJson(logs),
    };
  }

  @override
  List<Object?> get props => [total, logs];
}
