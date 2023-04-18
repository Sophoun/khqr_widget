import 'package:flutter/material.dart';
import 'package:khqr/khqr.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KHQR Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text("KhqrWidget sample")),
        body: Builder(builder: (context) {
          return ListView(
            children: [
              ListTile(
                title: const Text("KhqrWidget"),
                tileColor: Colors.grey.shade200,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const KhqrWidgetDemo(),
                  ));
                },
              ),
              ListTile(
                title: const Text("KhqrStandWidget"),
                tileColor: Colors.grey.shade200,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const KhqrStandWidgetDemo(),
                  ));
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}

class KhqrWidgetDemo extends StatelessWidget {
  const KhqrWidgetDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: KhqrWidget(
          receiverName: "receiverName",
          amount: "12.23",
          currency: "USD",
          qr: "YOUR_QR_DATA",
        ),
      ),
    );
  }
}

class KhqrStandWidgetDemo extends StatelessWidget {
  const KhqrStandWidgetDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: KhqrStandWidget(),
      ),
    );
  }
}
