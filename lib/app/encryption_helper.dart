import 'package:encrypt/encrypt.dart';
import 'hidden_keys.dart';

class EncryptionHelper {
  static final _key = Key.fromUtf8(
    Mykeys.encryption_key, // Ensure this key is 32 characters long
    //myKeys are hidden.
  );
  static final _iv = IV.fromLength(16);

  static String encryptPassword(String password) {
    final encrypter = Encrypter(AES(_key));
    final encrypted = encrypter.encrypt(password, iv: _iv);
    return encrypted.base64;
  }

  static String decryptPassword(String encryptedPassword) {
    final encrypter = Encrypter(AES(_key));
    final decrypted = encrypter.decrypt(
      Encrypted.from64(encryptedPassword),
      iv: _iv,
    );
    return decrypted;
  }
}
