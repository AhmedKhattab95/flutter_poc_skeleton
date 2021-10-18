// base class to provide biometeric service avilable and ask user to verify himself by biometeric login

//depndes on local_auth: ^1.1.8
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

abstract class BiometericService {
  /// check if device contains any biometerics
  Future<bool> get isbiometericsAvilable;

  /// get list of avilable biometerics
  Future<List<BiometricMethod>> get availableBiometrics;

  ///define if fingerprint avilabel
  Future<bool> get isFingerPrintAvilable;

  ///define if login by face avilabel
  Future<bool> get isFaceRecognitionAvilable;

  /// request authontication
  /// [backgroudAuth] is used when the application goes into background for any
  /// reason while the authentication is in progress. Due to security reasons,
  /// the authentication has to be stopped at that time. If stickyAuth is set
  /// to true, authentication resumes when the app is resumed. If it is set to
  /// false (default), then as soon as app is paused a failure message is sent
  /// back to Dart and it is up to the client app to restart authentication or
  /// do something else.
  /// [useErrorDialogs] = true means the system will attempt to handle user
  /// fixable issues encountered while authenticating. For instance, if
  /// fingerprint reader exists on the phone but there's no fingerprint
  /// registered, the plugin will attempt to take the user to settings to add
  /// one. Anything that is not user fixable, such as no biometric sensor on
  /// device, will be returned as a [PlatformException].
  ///
  Future<bool> requestAuthenticate({
    required String localizedMessage,
    bool backgroudAuth = false,
    bool useErrorDialogs = true,
    AndroidAuthMessages androidAuthStrings = const AndroidAuthMessages(),
    IOSAuthMessages iOSAuthStrings = const IOSAuthMessages(),
    bool sensitiveTransaction = true,
    bool biometricOnly = false,
  });

  /// stop process of Authentication
  void stopAuthentication();
}

class BiometricMethod extends Equatable {
  final String _value;
  const BiometricMethod._(this._value);

  static final BiometricMethod Face = const BiometricMethod._('face');
  static final BiometricMethod Fingerprint = const BiometricMethod._('fingerprint');
  static final BiometricMethod Iris = const BiometricMethod._('iris');
  static final BiometricMethod None = const BiometricMethod._('none');

    factory BiometricMethod.mapFromEnumValue(BiometricType value) {
    switch (value) {
      case BiometricType.face:
        return Face;
      case BiometricType.fingerprint:
        return Fingerprint;
      case BiometricType.iris:
        return Iris;
      default:
        return None;
    }
  }

  @override
  List<Object?> get props => [_value];
}
