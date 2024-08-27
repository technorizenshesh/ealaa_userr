import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class FaceRecognization extends StatefulWidget {
  const FaceRecognization({super.key});

  @override
  State<FaceRecognization> createState() => _FaceRecognizationState();
}

enum SupportedState { unknown, supported, unSupported }

class _FaceRecognizationState extends State<FaceRecognization> {
  final LocalAuthentication auth = LocalAuthentication();
  SupportedState supportedState = SupportedState.unknown;

  List<BiometricType>? availableBiometrices;

  @override
  void initState() {
    auth.isDeviceSupported().then((bool isSupported) => setState(() =>
        supportedState == isSupported
            ? SupportedState.supported
            : SupportedState.unSupported));
    checkBiometric();
    getAvailableBiometrices();
    super.initState();
  }

  Future<void> checkBiometric() async {
    late bool canCheckBiometric;
    try {
      canCheckBiometric = await auth.canCheckBiometrics;
      print("Biometric Supported: $canCheckBiometric");
    } on PlatformException catch (e) {
      print(e);
      canCheckBiometric = false;
    }
  }

  Future<void> getAvailableBiometrices() async {
    late List<BiometricType> biometricTypes;
    try {
      biometricTypes = await auth.getAvailableBiometrics();
      print("Supported biometrices: $biometricTypes");
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) {
      return;
    }
    setState(() {
      availableBiometrices = biometricTypes;
    });
  }

  Future<void> authenticateWithBiometrices() async {
    late List<BiometricType> biometricTypes;
    try {
      final authenticated = await auth.authenticate(
          localizedReason: 'Authenticate with fingerprint or Face ID',
          options:
              AuthenticationOptions(stickyAuth: true, biometricOnly: true));
      if (!mounted) {
        return;
      }

      if (authenticated) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Splash();
          },
        ));
      }
    } on PlatformException catch (e) {
      print(e);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biometric Authentication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              supportedState == SupportedState.supported
                  ? 'Biometric authentication is supported on this device'
                  : supportedState == SupportedState.unSupported
                      ? 'Biometric authentication is not supported on this device'
                      : 'Checking Biometric Support...',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: supportedState == SupportedState.supported
                      ? Colors.green
                      : supportedState == SupportedState.unSupported
                          ? Colors.red
                          : Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Supported biometrices: $availableBiometrices'),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  authenticateWithBiometrices();
                }, child: Text('Authenticate with Face Id'))
          ],
        ),
      ),
    );
  }
}
