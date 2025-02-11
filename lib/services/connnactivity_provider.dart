import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityProvider extends StatefulWidget {
  @override
  _ConnectivityProviderState createState() => _ConnectivityProviderState();
}

class _ConnectivityProviderState extends State<ConnectivityProvider> {
  late StreamSubscription<List<ConnectivityResult>> _subscription; // Listen to a single connectivity result

  bool _isConnected = true;

  @override
  void initState() {
    super.initState();

    // Listen for connectivity changes
    _subscription = Connectivity().onConnectivityChanged.listen(( result) {
      _updateConnectionStatus(result.first); // Use the result directly
    });

    // Check initial connectivity
    _checkInitialConnectivity();
  }

  Future<void> _checkInitialConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    _updateConnectionStatus(result.first); // Directly use the result
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    setState(() {
      // Update connection status based on the result
      _isConnected = result != ConnectivityResult.none;
    });
  }

  @override
  void dispose() {
    // Cancel the subscription when disposing
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connectivity Example')),
      body: Stack(
        children: [
          const Center(
            child: Text(
              'Check Connectivity',
              style: TextStyle(fontSize: 24),
            ),
          ),
          if (!_isConnected) _buildNoInternetBanner(), // Show banner when no connection
        ],
      ),
    );
  }

  // Banner that shows when there's no internet connection
  Widget _buildNoInternetBanner() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Material(
        elevation: 4,
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'No Internet Connection',
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
