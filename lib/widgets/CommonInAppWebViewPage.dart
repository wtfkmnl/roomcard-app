import 'dart:async';
import 'package:roomcard/utils/logger.dart';
import 'package:roomcard/widgets/app_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utils/base_will_pop_scope2.dart';
import '../utils/page_back_utils.dart';

class CommonInAppWebViewPage extends StatefulWidget {
  final String url;
  final String title;
  final bool isShowAppBar = false;

  CommonInAppWebViewPage({Key? key, required this.url, this.title = ""})
      : super(key: key);

  @override
  State<CommonInAppWebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<CommonInAppWebViewPage> {
  final GlobalKey webViewKey = GlobalKey();
  late InAppWebViewController webViewController;
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWillPopScope2(
        func: () async {
          return await PageBackUtils().clickGoBack();
        }, child: buildCupertinoPageScaffold());

    // return buildCupertinoPageScaffold();

  }

  Widget buildCupertinoPageScaffold() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel("FlutterChannel", onMessageReceived: (message){
        if (message.message.isEmpty){
          return;
        }else{
          if ("3"==message.message) {
            Get.back();
          } else if ("4"==message.message) {
            //todo:跳转客服
            // onlinekefu();
            // toCustomerService();
            // ToastUtil.showToast("js交互${4}");
          }
        }
      })
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          // onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            //todo:这个地方的监听，待续
            debugPrint('onNavigationRequest: ${request.url}');
            debugPrint('onNavigationRequest: ${request.isMainFrame}');
            if (request.url.contains('baidu')) { https://www.baidu.com/
            Get.back();
            return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    return AppScaffold(
      title: Text("客服"),
      showAppBar: true,
      body: SafeArea(
   // child: WebViewWidget(controller: controller),
          child: InAppWebView(
            key: webViewKey,
             initialUrlRequest: URLRequest(
              url: WebUri.uri(Uri.parse(widget.url)),
            ),
               initialSettings: InAppWebViewSettings(
                 mediaPlaybackRequiresUserGesture: false,
                allowFileAccessFromFileURLs: true,
                // useShouldOverrideUrlLoading: true,
                  useHybridComposition: true,
                   allowsInlineMediaPlayback: true,
              ),
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                    useShouldOverrideUrlLoading: true,
                   mediaPlaybackRequiresUserGesture: false, // 允许自动播放音频
                   allowFileAccessFromFileURLs: true),

                // android 支持HybridComposition
                android: AndroidInAppWebViewOptions(
                  useHybridComposition: true,
                ),
               ios: IOSInAppWebViewOptions(
                  allowsInlineMediaPlayback: true,
                ),
              ),
              androidShouldInterceptRequest:
                 (InAppWebViewController controller, request) async {},

            // logger.e("1111chooseFile${request}",
             onWebViewCreated: (InAppWebViewController controller) {
               webViewController = controller;
               controller.addJavaScriptHandler(
                   handlerName: 'chooseFile',
                   callback: (args) {
                    logger.e("1111chooseFile${args}");
                     // 处理文件选择操作，args 包含了从 H5 页面传递过来的数据
                    // 你可以在此处处理选中的文件或图片
                    // 例如，使用 `file_picker` 插件来选择文件
                    // 然后将文件路径返回给 H5 页面
                   });
             },
            // onLongPressHitTestResult: (controller, hitTestResult) async {
             //   if (hitTestResult.extra != null && hitTestResult.type == InAppWebViewHitTestResultType.EDIT_TEXT_TYPE) {
             //     String selectedText = await controller.evaluateJavascript(source: """
             //   window.getSelection().toString();
             // """);
             //
            //     // 复制选中的文本内容到剪贴板
            //     if (selectedText.isNotEmpty) {
            //       Clipboard.setData(ClipboardData(text: selectedText));
             //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Text copied to clipboard')));
             //     }
             //   }
             // },
             onLoadHttpError: (InAppWebViewController controller, Uri? url,
                 int statusCode, String description){

             },
               androidOnPermissionRequest: (InAppWebViewController controller, String origin, List<String> resources) async {
                 return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
               },
               onLoadStart: (InAppWebViewController controller, Uri? url) {
               logger.e("onLoadStart${url}");
             },
           )),
    );
  }

  goBack() async {
    if (webViewController == null) {
      // NavigatorUtil().pop();
      return;
    }
    bool goBack = await webViewController!.canGoBack();
    if (goBack) {
      webViewController!.goBack();
      return false;
    } else {
      return true;
    }
  }
}
