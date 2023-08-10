import 'dart:io';

import 'package:flutter_sharez/bootstrap.dart';
import 'package:flutter_sharez/shared/exception/base_exception.dart';
import 'package:multiple_result/multiple_result.dart';

Future<Result<String, BaseException>> getDefaultAddress() async {
  final ipresult = await getAllIPs();
  return ipresult.when(
    (iplist) {
      if (iplist.isEmpty) {
        return Error(BaseException(message: "No IPs found"));
      } else {
        return Success(iplist.first);
      }
    },
    (error) {
      return Error(error);
    },
  );
}

Future<Result<List<String>, BaseException>> getAllIPs() async {
  final iplist = <String>[];
  try {
    final networkinterfaces = await NetworkInterface.list(
      type: InternetAddressType.IPv4,
    );

    for (var newti in networkinterfaces) {
      for (var ip in newti.addresses) {
        talker.log(ip.address);
        if (ip.address.startsWith("192.168") || ip.address.startsWith("10.0")) {
          iplist.add(ip.address);
        }
      }
    }
    return Success(iplist);
  } catch (e) {
    return Error(BaseException(message: e.toString()));
  }
}

List<String> getNetAddress(List<String> ipList) {
  List<String> netAdd = [];
  for (String ip in ipList) {
    var ipToList = ip.split('.');
    ipToList.removeLast();
    netAdd.add(ipToList.join('.'));
  }
  return netAdd;
}
