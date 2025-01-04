import 'dart:math';

import 'package:flutter/material.dart';
import 'package:khqr_widget/khqr_widget.dart';

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
                    builder: (context) => KhqrWidgetDemo(),
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

// ignore: must_be_immutable
class KhqrWidgetDemo extends StatelessWidget {
  KhqrWidgetDemo({super.key});

  String qrData = "YOUR_QR_DATA";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: StatefulBuilder(
          builder: (context, setState) => KhqrWidget(
            width: 300,
            receiverName: "Cambify LTD by John Due ",
            amount: "12.23",
            currency: "USD",
            qr: qrData,
            qrIcon: Image.asset(
              "assets/cambify.png",
            ),
            duration: const Duration(seconds: 3),
            clearAmountIcon: const Icon(
              size: 12,
              Icons.clear_rounded,
              color: Colors.black,
            ),
            expiredIcon: Container(
              constraints: const BoxConstraints.expand(),
              decoration: BoxDecoration(
                color: Colors.green.withAlpha(150),
                borderRadius: BorderRadius.circular(0),
              ),
              child: const Icon(
                Icons.clear,
              ),
            ),
            onRetry: () {
              setState(() {
                qrData = "${Random().nextInt(100)}";
              });
            },
            onCountingDown: (p0) => Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(p0.inSeconds.toString()),
            ),
          ),
        ),
      ),
    );
  }
}

class KhqrStandWidgetDemo extends StatelessWidget {
  const KhqrStandWidgetDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: KhqrStandWidget(
          logo: Image.asset("assets/cambify.png"),
          qrData: "YOUR_QR_DATA",
          name: "John Due",
          bakongId: "yourbakong@id",
          qrIcon: Image.asset("assets/dolar_symbol.png"),
        ),
      ),
    );
  }
}
