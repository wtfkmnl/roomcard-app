import 'dart:convert';
import 'dart:io';

import 'text_utils.dart';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';
import 'package:logger/logger.dart';

/// 加密和解密工具类
class EncryptUtils {
  /// md5 加密字符串
  static String encodeMd5(String data) {
    var content = const Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  static String toMd5(String input) {
    var bytes = utf8.encode(input);
    var md5Result = md5.convert(bytes);
    return md5Result.toString();
  }

  /// md5 加密file
  static String encodeMd5File(File file) {
    var readAsStringSync = file.readAsStringSync();
    var content = const Utf8Encoder().convert(readAsStringSync);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  // /// 异或对称加密
  // static String xorCode(String res, String key) {
  //   List<String> keyList = key.split(',');
  //   List<int> codeUnits = res.codeUnits;
  //   List<int> codes = [];
  //   for (int i = 0, length = codeUnits.length; i < length; i++) {
  //     int code = codeUnits[i] ^ int.parse(keyList[i % keyList.length]);
  //     codes.add(code);
  //   }
  //   return String.fromCharCodes(codes);
  // }
  //
  // /// 异或对称 Base64 加密
  // static String xorBase64Encode(String res, String key) {
  //   String encode = xorCode(res, key);
  //   encode = encodeBase64(encode);
  //   return encode;
  // }
  //
  // /// 异或对称 Base64 解密
  // static String xorBase64Decode(String res, String key) {
  //   String encode = decodeBase64(res);
  //   encode = xorCode(encode, key);
  //   return encode;
  // }

  /// Base64加密字符串
  static String encodeBase64(String data) {
    var content = utf8.encode(data);
    var digest = base64Encode(content);
    return digest;
  }

  /// Base64解密字符串
  static String decodeBase64(String data) {
    List<int> bytes = base64Decode(data);
    String result = utf8.decode(bytes);
    return result;
  }

  //账户名加密 1 md5两次 2 前半段倒序+后半段倒序 3 取当前的前2-8位位检验位 4 md5
  static String appEncrypt(String value) {
    if (Platform.isIOS) {
      return encryptionToken(value, 6);
    }
    String first = encodeMd5(value.toLowerCase());
    first = encodeMd5(first);
    String rev0 = TextUtils.reverse(first.substring(0, (first.length ~/ 2)));
    String rev1 =
        TextUtils.reverse(first.substring((first.length ~/ 2)));
    first = rev0 + rev1;
    String valueCheck = "";
    valueCheck = first.substring(2, 8);
    first=first+valueCheck;
    first=encodeMd5(first);
    return first;
  }

  static String encryptionToken(String input, int count) {
    String lowerAccount = input.toLowerCase();
    String tempStr1 = toMd5(lowerAccount);
    String tempStr2 = toMd5(tempStr1);

    String two = tempStr2.substring(0, tempStr2.length ~/ 2);
    String one = tempStr2.substring(tempStr2.length ~/ 2);

    String total = '${reversed(two)}${reversed(one)}';
    String fanal = total.substring(0, count);

    return toMd5('$total$fanal');
  }

  static String reversed(String input) {
    List<String> characters = input.split('');
    List<String> reversedCharacters = characters.reversed.toList();
    return reversedCharacters.join();
  }

  //密码加密
  static String pwdEncrypt(String value) {
    // if (Platform.isIOS) {
    //   return encryptionToken(value, 3);
    // }
    String first = encodeMd5(value);
    first = encodeMd5(first);
    String rev0 = TextUtils.reverse(first.substring(0, (first.length ~/ 2)));
    String rev1 =
    TextUtils.reverse(first.substring((first.length ~/ 2), first.length));
    first = rev0 + rev1;
    String valueCheck = first.substring(0, 3);
    first=first+valueCheck;
    first=encodeMd5(first);
    return first;
  }

  // private static final char[] sHexDigits = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};

   static String withrawPwdEnrugt(String source) {
     var bytes = utf8.encode(source); // 将输入字符串编码为UTF-8字节
     var md5Result = md5.convert(bytes); // 获取MD5 hash值
     // 将MD5 hash值转换为16进制字符串，然后取其中的前32位
     return md5Result.toString().substring(0, 32);

  }
}
