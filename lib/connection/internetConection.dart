import 'package:connectivity_plus/connectivity_plus.dart';

Future<String> checkInternetConnection() async {
// This condition is for demo purposes only to explain every connection type.
// Use conditions which work for your requirements.
  final List<ConnectivityResult> connectivityResult =
      await (Connectivity().checkConnectivity());

// This condition is for demo purposes only to explain every connection type.
// Use conditions which work for your requirements.
  if (connectivityResult.contains(ConnectivityResult.none)) {
    print('No Internet Connectionnnnnnnnnnnnnnnnnnnnnnn');
    return 'none';
    // No available network types
  } else {
    print('Internet Connection availableeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
    return 'available';
  }
}
