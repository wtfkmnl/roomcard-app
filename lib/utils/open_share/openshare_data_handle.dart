import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:roomcard/global.dart';
import 'package:roomcard/utils/open_share/open_share_util.dart';

/// 处理openshare的数据 downloadSite invitationCode
class OpenshareDataHandle {
  static Future handleData() async {
    /// 先取instalXX的数据
    var installXXData = await rootBundle.loadString("assets/instalXX.json");
    var installXXJsonData = jsonDecode(installXXData);
    dynamic installXXInvitationCode;
    dynamic installXXDownloadSite;
    if (installXXJsonData is Map) {
      installXXDownloadSite = installXXJsonData["shareName"] ?? "";
      installXXInvitationCode = installXXJsonData["id"] ?? "";
    }

    dynamic openShareInvitationCode;
    dynamic openShareDownloadSite;
    dynamic param = await openShare.getShareParam();
    if (param != null) {
      dynamic shareName = param["shareName"];
      if (shareName != null) {
        openShareDownloadSite = shareName;
      }
      dynamic id = param["id"];
      if (id != null) {
        openShareInvitationCode = id;
      }
    }

    /// 取值顺序：打包配置 -> instalXX -> openshare
    if (Global.instance.archiveModel.iNvitationCode != "invitationCode") {
      Global.instance.openShareDataModel.invitationCode =
          Global.instance.archiveModel.iNvitationCode;
    } else {
      Global.instance.openShareDataModel.invitationCode =
          installXXInvitationCode ?? openShareInvitationCode ?? "";
    }

    if (Global.instance.archiveModel.dOwnloadSite != "downloadSite") {
      Global.instance.openShareDataModel.downloadSite =
          Global.instance.archiveModel.dOwnloadSite;
    } else {
      Global.instance.openShareDataModel.downloadSite =
          installXXDownloadSite ?? openShareDownloadSite ?? "";
    }
  }
}

class OpenShareDataModel {
  dynamic invitationCode = "";
  dynamic downloadSite = "";
}
