import 'dart:async';
import 'package:roomcard/utils/logger.dart';
import 'package:roomcard/widgets/app_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../utils/page_back_utils.dart';
import '../utils/base_will_pop_scope2.dart';

class WebViewPage extends StatefulWidget {
  final  String url;
  final String title;
  final bool isShowAppBar = false;
  static String tag="";
  WebViewPage({Key? key, required this.url,this.title="",String tags=""}){
    tag=tags;
  }

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage>{
  late WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
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
      ..setBackgroundColor(const Color(0x00ff0000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('onProgress: ${progress}');
          },
          onPageStarted: (String url) {
            debugPrint('onPageStarted: ${url}');
          },
          onUrlChange: (UrlChange urlChange) {
            debugPrint('onUrlChange:$urlChange');
          //   String url = urlChange.url ?? "";
          //   debugPrint('1111111: $url');
          //   if (url.contains('baidu')) {
          //     if (await webViewController.canGoBack()) {
          //       webViewController.goBack();
          //     }
          //   }
          },
          onPageFinished: (String url) {
            debugPrint('onPageFinished:$url');
            // await webViewController
            //     .runJavaScriptReturningResult('document.title')
            //     .then((result) {
            //   debugPrint('标题--: $result');
            //   // if (result.replaceAll('"', '').isNotEmpty) {
            //   //   setState(() => title = result.replaceAll('"', ''));
            //   // }
            // });
          },
          onWebResourceError: (WebResourceError error) {
            logger.e('44444444: ${error.description}-${error.errorCode}');
          },
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
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    WebViewPage.tag="";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWillPopScope2(func: ()async{
      return PageBackUtils().clickGoBack();
    },
        child: buildCupertinoPageScaffold());
  }

  Widget buildCupertinoPageScaffold() {
    return AppScaffold(
     showAppBar: false,
    body: SafeArea(
        child: WebViewWidget(
          controller: webViewController,
        )),
  );
  }

  // 点击返回
  clickGoBack() async{
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      // Future.delayed(const Duration(milliseconds: 700), () {
      //   Get.back();
      // });
      if (webViewController == null) {
        // NavigatorUtil().pop();
        return false;
      }
      bool goBack = await webViewController!.canGoBack();
      if (goBack) {
        webViewController!.goBack();
        return false;
      } else {
        Get.back();
        return true;
      }
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
