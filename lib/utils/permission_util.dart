import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

/// 权限检查及请求
///
/// 外部可通过此方法来进行权限的检查和请求，将自动跳转到`PermissionRequestPage`页面。
///
/// 传入 `Permission` 以及对应的权限名称 `permissionTypeStr`，如果有权限则返回 `Future true`
///
/// `isRequiredPermission` 如果为 `true`,则 "取消" 按钮将执行 "退出app" 的操作
Future<bool> permissionCheckAndRequest(
    BuildContext context, Permission permission, String permissionTypeStr,
    {bool isRequiredPermission = false}) async {
  int sdkVersion = 33;
  if (Platform.isAndroid) {
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    AndroidDeviceInfo android = await plugin.androidInfo;
    sdkVersion = android.version.sdkInt;
  }
  bool isGranted = false;

  ///是否被授权
  if (sdkVersion >= 33) {
    isGranted = await getPermissonType(permission).isGranted;
  } else {
    isGranted = await permission.status.isGranted;
  }

  if (!isGranted) {
    await Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: ((context, animation, secondaryAnimation) {
          return PermissionRequestPage(
              permission, permissionTypeStr, sdkVersion,
              isRequiredPermission: isRequiredPermission);
        })));
    // await Get.dialog(barrierColor:Colors.green,PermissionRequestPage(
    //     permission, permissionTypeStr, sdkVersion,
    //     isRequiredPermission: isRequiredPermission));
  } else {
    return true;
  }

  return false;
}

Permission getPermissonType(Permission permission) {
  if (permission == Permission.photos) {
    return Permission.photos;
  } else if (permission == Permission.storage) {
    return Permission.storage;
  }
  return Permission.storage;
}

class PermissionRequestPage extends StatefulWidget {
  PermissionRequestPage(
      this.permission, this.permissionTypeStr, this.sdkVersion,
      {super.key, this.isRequiredPermission = false});

  final Permission permission;
  final String permissionTypeStr;
  final bool isRequiredPermission;
  final int sdkVersion;

  @override
  State<PermissionRequestPage> createState() => _PermissionRequestPageState();
}

class _PermissionRequestPageState extends State<PermissionRequestPage>
    with WidgetsBindingObserver {
  bool _isGoSetting = false;
  late final List<String> msgList;
  int _clickSure = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    msgList = [
      "${widget.permissionTypeStr}功能需要获取您设备的${widget.permissionTypeStr}权限，否则可能无法正常工作。\n是否申请${widget.permissionTypeStr}权限？",
      "${widget.permissionTypeStr}权限不全，是否重新申请权限？",
      "没有${widget.permissionTypeStr}权限，您可以手动开启权限",
      widget.isRequiredPermission ? "退出应用" : "取消"
    ];
    checkPermission(widget.permission);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // 监听 app 从后台切回前台
    if (state == AppLifecycleState.resumed && _isGoSetting) {
      checkPermission(widget.permission);
    }
  }

  /// 校验权限
  void checkPermission(Permission permission) async {
    PermissionStatus status;
    if (widget.sdkVersion >= 33) {
      status = await getPermissonType(permission).status;
    } else {
      status = await permission.status;
    }

    if (status.isGranted) {
      _popPage();
      return;
    }

    // 还未申请权限或之前拒绝了权限(在 iOS 上为首次申请权限，拒绝后将变为 `永久拒绝权限`)
    if (status.isDenied) {
      if (_clickSure == 1) {
        _isGoSetting = true;
      }
      showAlert(
          permission, msgList[0], msgList[3], _isGoSetting ? "前往应用中心" : "确定");
    }
    // 权限已被永久拒绝
    if (status.isPermanentlyDenied) {
      _isGoSetting = true;
      showAlert(
          permission, msgList[2], msgList[3], _isGoSetting ? "前往应用中心" : "确定");
    }
    // 拥有部分权限
    if (status.isLimited) {
      if (Platform.isIOS || Platform.isMacOS) _isGoSetting = true;
      showAlert(
          permission, msgList[1], msgList[3], _isGoSetting ? "前往应用中心" : "确定");
    }
    // 拥有部分权限(仅限 iOS)
    if (status.isRestricted) {
      if (Platform.isIOS || Platform.isMacOS) _isGoSetting = true;
      showAlert(
          permission, msgList[1], msgList[3], _isGoSetting ? "前往应用中心" : "确定");
    }
  }

  void showAlert(Permission permission, String message, String cancelMsg,
      String confirmMsg) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text("温馨提示"),
            content: Text(message),
            actions: [
              CupertinoDialogAction(
                  child: Text(cancelMsg),
                  onPressed: () {
                    widget.isRequiredPermission
                        ? _quitApp()
                        : _popDialogAndPage(context);
                  }),
              CupertinoDialogAction(
                  child: Text(confirmMsg),
                  onPressed: () async {
                    if (_isGoSetting) {
                      openAppSettings();
                      Navigator.of(context).pop();
                      _isGoSetting = true;
                    } else {
                      requestPermisson(permission);
                      _clickSure++;
                    }
                    _popPage();
                  })
            ],
          );
        });
  }

  /// 申请权限
  void requestPermisson(Permission permission) async {
    // 申请权限
    if (widget.sdkVersion >= 33) {
      Permission permissions = getPermissonType(permission);
      PermissionStatus b = await permissions.request();
    } else {
      await permission.request();
    }

    // 再次校验
    checkPermission(permission);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  /// 退出应用程序
  void _quitApp() {
    SystemChannels.platform.invokeMethod("SystemNavigator.pop");
  }

  /// 关闭整个权限申请页面
  void _popDialogAndPage(BuildContext dialogContext) {
    _popDialog(dialogContext);
    _popPage();
    if(_clickSure>0){
      Navigator.of(context).pop();
    }
  }

  /// 关闭弹窗
  void _popDialog(BuildContext dialogContext) {
    Navigator.of(dialogContext).pop();
  }

  /// 关闭透明页面
  void _popPage() {
    Navigator.of(context).pop();
  }
}
