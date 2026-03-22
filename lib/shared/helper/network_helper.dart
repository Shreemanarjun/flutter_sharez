import 'dart:io';

import 'package:flutter_sharez/bootstrap.dart';
import 'package:flutter_sharez/shared/exception/base_exception.dart';
import 'package:multiple_result/multiple_result.dart';

/// Returns the primary IPv4 address of this device that is not a loopback.
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

/// Enumerates all available IPv4 network interfaces on this device.
/// 
/// Filters out loopback addresses and returns a list of local IP addresses
/// (e.g., 192.168.1.x) that are useful for P2P networking.
Future<Result<List<String>, BaseException>> getAllIPs() async {
  final iplist = <String>[];
  try {
    final networkinterfaces = await NetworkInterface.list(
      type: InternetAddressType.IPv4,
    );

    for (var newti in networkinterfaces) {
      for (var ip in newti.addresses) {
        talker.log("Found IP: ${ip.address}");
        if (!ip.isLoopback) {
          iplist.add(ip.address);
        }
      }
    }
    return Success(iplist);
  } catch (e) {
    return Error(BaseException(message: e.toString()));
  }
}

/// Helper to get the network portion of an IP address (excluding the last octet).
List<String> getNetAddress(List<String> ipList) {
  List<String> netAdd = [];
  for (String ip in ipList) {
    var ipToList = ip.split('.');
    ipToList.removeLast();
    netAdd.add(ipToList.join('.'));
  }
  return netAdd;
}
