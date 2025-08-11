import 'dart:async';
import 'dart:collection';
import 'package:roomcard/routes/app_router.dart';
import 'package:roomcard/utils/events_util.dart';
import 'package:roomcard/utils/logger.dart';
import 'package:roomcard/widgets/dialogs/default_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Dialog 构建函数类型定义
typedef DialogBuilder = Widget Function(BuildContext context);

/// 全局对话框队列管理器，确保任意时刻仅显示一个对话框，自动排队显示
class DialogQueueManager {
  /// 单例实例
  static final DialogQueueManager _instance = DialogQueueManager._internal();
  factory DialogQueueManager() => _instance;
  DialogQueueManager._internal();

  /// 每个 dialog 间隔时间，防止闪烁
  final nextInterval = 500.milliseconds;

  /// 队列用于缓存待展示的 Dialog 构建器
  final Queue<DialogBuilder> _dialogQueue = Queue();

  /// 是否正在展示某个对话框
  bool _isShowing = false;

  StreamSubscription? didChange;

  /// 添加一个 dialog 到队列中，并尝试立即展示
  void show(DialogBuilder builder) {
    _dialogQueue.add(builder);
    _tryShowNext();
  }

  /// 尝试展示队列中的下一个 dialog
  void _tryShowNext() {
    //不是main首页就不展示
    if (Get.currentRoute != AppRouter.main.path) {
      didChange ??= EventsUtil.routerDidChange.on().listen((_) {
        if (Get.currentRoute == AppRouter.main.path) {
          _tryShowNext();
        }
      });
      return;
    }

    ///清空弹夹
    didChange?.cancel();
    didChange = null;

    // 如果已有 dialog 正在展示 或 队列为空，则跳过
    if (_isShowing || _dialogQueue.isEmpty) return;

    _isShowing = true;

    // 取出并构建下一个 dialog
    final builder = _dialogQueue.removeFirst();
    showDefaultDialog(
      Get.context!,
      barrierDismissible: false,
      pageBuilder: (context, p1, p2) => builder(context),
    ).then((_) async {
      // dialog 关闭后，设置为非展示状态，等待一段时间再尝试下一个
      _isShowing = false;
      await nextInterval.delay();
      _tryShowNext(); // 当前对话框关闭后，尝试显示下一个
    });
  }

  /// 清空队列中所有未展示的 dialog
  void clear() {
    _dialogQueue.clear();
  }
}
