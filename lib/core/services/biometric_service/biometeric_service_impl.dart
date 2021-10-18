import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart';

import 'biometeric_service.dart';

class BiometericServiceImpl implements BiometericService {
  bool _initialized = false;
  final _localAuth = LocalAuthentication();

  Future<void> _init() async {
    if (_initialized) return;
    var avilableBiometerics = await _localAuth.getAvailableBiometrics();
    _availableBiometrics = avilableBiometerics.map((e) => BiometricMethod.mapFromEnumValue(e)).toList();
    _initialized = true;
  }

  @override
  Future<bool> get isbiometericsAvilable async {
    await _init();
    return _localAuth.canCheckBiometrics;
  }

  late List<BiometricMethod> _availableBiometrics;

  @override
  Future<List<BiometricMethod>> get availableBiometrics async {
    await _init();
    return Future.value(_availableBiometrics);
  }

  @override
  Future<bool> get isFaceRecognitionAvilable async {
    var biometerics = await availableBiometrics;
    return biometerics.any((element) => element == BiometricMethod.Face);
  }

  @override
  Future<bool> get isFingerPrintAvilable async {
    var biometerics = await availableBiometrics;
    return biometerics.any((element) => element == BiometricMethod.Fingerprint);
  }

  @override
  Future<bool> requestAuthenticate({
    required String localizedMessage,
    bool backgroudAuth = false,
    bool useErrorDialogs = true,
    AndroidAuthMessages androidAuthStrings = const AndroidAuthMessages(),
    IOSAuthMessages iOSAuthStrings = const IOSAuthMessages(),
    bool sensitiveTransaction = true,
    bool biometricOnly = false,
  }) =>
      _localAuth.authenticate(
          localizedReason: localizedMessage,
          stickyAuth: backgroudAuth,
          useErrorDialogs: useErrorDialogs,
          androidAuthStrings: androidAuthStrings,
          iOSAuthStrings: iOSAuthStrings,
          sensitiveTransaction: sensitiveTransaction,
          biometricOnly: biometricOnly);

  @override
  void stopAuthentication() {
    _localAuth.stopAuthentication();
  }
}
