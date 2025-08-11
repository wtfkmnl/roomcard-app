// import 'dart:convert';
// import 'package:crypto/crypto.dart';

import 'dart:convert';
import 'package:crypto/crypto.dart' as cy;

///加密
class CryptoUtil {
  /// MD5 加密
  static String md5(String input) {
    return cy.md5.convert(utf8.encode(input)).toString();
  }
}
