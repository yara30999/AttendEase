import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class EncryptionHelper {
  static final _key = Key.fromUtf8(
    dotenv.env['ENCRYPTION_KEY']!, // Ensure this key is 32 characters long
  );

  static String encryptPassword(String password) {
    // Generate a new random IV for each encryption
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(_key));
    final encrypted = encrypter.encrypt(password, iv: iv);

    // Store IV with the encrypted data
    final combined = '${iv.base64}:${encrypted.base64}';
    // Encode the combined string to base64 for storage
    return base64Encode(utf8.encode(combined));
  }

  static String decryptPassword(String encryptedPassword) {
    try {
      // Decode and split the combined data
      final decodedBytes = base64Decode(encryptedPassword);
      final decodedString = utf8.decode(decodedBytes);
      final parts = decodedString.split(':');

      if (parts.length != 2) {
        throw Exception('Invalid encrypted data format');
      }

      // Extract IV and encrypted data
      final iv = IV.fromBase64(parts[0]);
      final encrypted = Encrypted.from64(parts[1]);

      final encrypter = Encrypter(AES(_key));
      final decrypted = encrypter.decrypt(encrypted, iv: iv);

      return decrypted;
    } catch (e) {
      throw Exception('Failed to decrypt password: $e');
    }
  }
}
