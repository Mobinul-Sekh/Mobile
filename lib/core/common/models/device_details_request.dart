// Dart imports:
import 'dart:convert';

class DeviceDetailsRequest {
  String? board;
  String? brand;
  String? device;
  String? hardware;
  String? host;
  String? deviceID;
  String? manufacturer;
  String? deviceModel;
  String? product;
  String? type;
  String? isPhysicalDevice;
  String? androidID;

  DeviceDetailsRequest({
    this.board,
    this.brand,
    this.device,
    this.hardware,
    this.host,
    this.deviceID,
    this.manufacturer,
    this.deviceModel,
    this.product,
    this.type,
    this.isPhysicalDevice,
    this.androidID,
  });

  Map<String, dynamic> toMap() {
    return {
      'board': board,
      'brand': brand,
      'device': device,
      'hardware': hardware,
      'host': host,
      'device_id': deviceID,
      'manufacture': manufacturer,
      'device_model': deviceModel,
      'product': product,
      'type': type,
      'isPhysical_device': isPhysicalDevice,
      'android_id': androidID,
    };
  }

  String toJson() => json.encode(toMap());
}
