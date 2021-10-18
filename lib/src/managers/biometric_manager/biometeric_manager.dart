abstract class BiometericManager{

  Future<bool> showBiometericOptions();
  Future<bool> isFingerPrintAvilable();
  Future<bool> isFaceIdAvilable();
  Future<bool> requestBiometericLogin(String localizedMessage);
}