import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider_crypto.dart';
import 'screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => CryptoProvider()),
      ],
      child: MaterialApp(
        title: 'Pasar Crypto',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CryptoListScreen(),
      ),
    );
  }
}