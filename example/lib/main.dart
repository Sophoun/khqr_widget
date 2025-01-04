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
      appBar: AppBar(),
      body: Center(
        child: KhqrWidget(
          receiverName: "receiverName receiverName ",
          amount: "12.23",
          currency: "USD",
          qrPadding: const EdgeInsets.all(12),
          qr: "YOUR_QR_DATA",
          qrIcon: Image.asset(
            "assets/cambify.png",
          ),
          duration: const Duration(seconds: 3),
          clearAmountIcon: const Icon(
            Icons.clear_rounded,
            color: Colors.black,
          ),
          expiredIcon: Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(0),
            ),
            child: const Icon(
              Icons.clear,
            ),
          ),
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
