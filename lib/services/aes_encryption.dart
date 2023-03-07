import 'package:encrypt/encrypt.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:cheetukaliapp/utils/urls.dart';

class AesDecryption {
  static final digest = sha512.convert(utf8.encode(Urls.enKey));
  static final key1 = digest.toString().substring(0, 32);
  static final key = Key.fromUtf8(key1); //32 chars
  static final digest1 = sha512.convert(utf8.encode(Urls.enIv));
  static final iv1 = digest1.toString().substring(0, 16);
  static final iv = IV.fromUtf8(iv1); //16 chars

//   Flutter encryption
  static String encryp(String text) {
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(text, iv: iv);

    return encrypted.base64;
  }

//Flutter decryption
  static String decryp(String text) {
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final decrypted = encrypter.decrypt(Encrypted.fromBase64(text), iv: iv);

    return decrypted;
  }
}
