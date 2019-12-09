import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionWidget extends StatefulWidget {
  const PermissionWidget(this._permissionGroup);

  final PermissionGroup _permissionGroup;

  @override
  _PermissionState createState() => _PermissionState(_permissionGroup);
}

class _PermissionState extends State<PermissionWidget> {
  _PermissionState(this._permissionGroup);

  final PermissionGroup _permissionGroup;
  PermissionStatus _permissionStatus = PermissionStatus.unknown;

  @override
  void initState() {
    super.initState();
    requestPermission(_permissionGroup);
    _listenForPermissionStatus();
  }

  void _listenForPermissionStatus() {
    final Future<PermissionStatus> statusFuture =
        PermissionHandler().checkPermissionStatus(_permissionGroup);

    statusFuture.then((PermissionStatus status) {
      setState(() {
        _permissionStatus = status;
      });
    });
  }

  Color getPermissionColor() {
    switch (_permissionStatus) {
      case PermissionStatus.denied:
        return Colors.redAccent;
      case PermissionStatus.granted:
        return Colors.greenAccent;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.info),
      onPressed: () {
        checkServiceStatus(context, _permissionGroup);
      },
      color: getPermissionColor(),
      tooltip: _permissionGroup.toString(),
    );
  }

  void checkServiceStatus(BuildContext context, PermissionGroup permission) {
    String _permissionTitle = _permissionGroup.toString().substring(16);
    String _permissionStat = _permissionStatus.toString().substring(17);
    String _buffer = ": Permission status ";

    PermissionHandler()
        .checkServiceStatus(permission)
        .then((ServiceStatus serviceStatus) {
      requestPermission(_permissionGroup);

      final SnackBar snackBar =
          SnackBar(content: Text(_permissionTitle + _buffer + _permissionStat));

      Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  Future<void> requestPermission(PermissionGroup permission) async {
    final List<PermissionGroup> permissions = <PermissionGroup>[permission];
    final Map<PermissionGroup, PermissionStatus> permissionRequestResult =
        await PermissionHandler().requestPermissions(permissions);

    setState(() {
      print(permissionRequestResult);
      _permissionStatus = permissionRequestResult[permission];
      print(_permissionStatus);
    });
  }
}
