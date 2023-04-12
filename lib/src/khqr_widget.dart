import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ignore: must_be_immutable
class KhqrWidget extends StatelessWidget {
  KhqrWidget({
    super.key,
    this.width = 300,
    required this.receiverName,
    required this.amount,
    required this.currency,
    required this.qr,
    this.image,
    this.duration,
    this.onRetry,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _updateDuration();
    });
  }

  double get _aspecRatio => 20 / 29;

  final double width;
  double get _height => width / _aspecRatio;

  final String receiverName;
  final String amount;
  final String currency;
  final String qr;
  final Image? image;
  final Duration? duration;
  Duration? _duration;
  int _durationCount = 0;
  final _durationStream = StreamController<Duration>.broadcast();
  final Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: width,
            height: _height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(width * 0.12 * _aspecRatio),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(20),
                  blurRadius: width * 0.16 * _aspecRatio,
                  offset: const Offset(0, 0), // Shadow position
                ),
              ],
            ),
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                Container(
                  height: _height * 0.2 * _aspecRatio,
                  width: width,
                  color: const Color.fromRGBO(255, 35, 26, 1),
                  padding: EdgeInsets.all(width * 0.1 * _aspecRatio),
                  child: Image.asset(
                    "assets/images/KHQR_Logo_white.png",
                  ),
                ),
                Expanded(
                  child: Container(
                    width: width,
                    color: const Color.fromRGBO(255, 35, 26, 1),
                    child: ClipPath(
                      clipper: QrHeaderClipper(aspecRatio: _aspecRatio),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: _height * 0.08 * _aspecRatio,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.2 * _aspecRatio,
                              ),
                              child: RichText(
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  text: receiverName,
                                  style: GoogleFonts.nunitoSans().copyWith(
                                    fontSize: 0.07 * width * _aspecRatio,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: _height * 0.01 * _aspecRatio,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.2 * _aspecRatio,
                              ),
                              child: Row(
                                textDirection: TextDirection.ltr,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  RichText(
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                      text: amount,
                                      style: GoogleFonts.nunitoSans().copyWith(
                                        fontSize: 0.15 * width * _aspecRatio,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.03 * _aspecRatio,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      bottom: _height * 0.03 * _aspecRatio,
                                    ),
                                    child: RichText(
                                      textDirection: TextDirection.ltr,
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        text: currency,
                                        style:
                                            GoogleFonts.nunitoSans().copyWith(
                                          fontSize: 0.07 * width * _aspecRatio,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: _height * 0.06 * _aspecRatio,
                            ),
                            CustomPaint(
                              painter: DashedLineHorizontalPainter(
                                aspecRatio: _aspecRatio,
                              ),
                              size: Size(width, 1),
                            ),
                            Expanded(
                              child: Center(
                                child: SizedBox(
                                  width: _height * 0.7 * _aspecRatio,
                                  height: _height * 0.7 * _aspecRatio,
                                  child: StreamBuilder<Duration>(
                                    stream: _durationStream.stream,
                                    builder: (context, snapshot) {
                                      final data = snapshot.data;
                                      return data!.inSeconds > 0
                                          ? QrImage(
                                              padding: const EdgeInsets.all(0),
                                              data: qr,
                                              version: QrVersions.auto,
                                              backgroundColor: Colors.white,
                                              embeddedImage: image?.image,
                                            )
                                          : MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: GestureDetector(
                                                onTap: () {
                                                  onRetry?.call();
                                                  _updateDuration();
                                                },
                                                child: const Icon(
                                                  Icons.restart_alt_rounded,
                                                  size: 50,
                                                ),
                                              ),
                                            );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (duration != null)
            SizedBox(
              height: _height * 0.07 * _aspecRatio,
            ),
          if (duration != null)
            StreamBuilder<Duration>(
              stream: _durationStream.stream,
              builder: (context, snapshot) => RichText(
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.left,
                text: TextSpan(
                  text:
                      "QR expired in: ${_duration!.inMinutes.remainder(60).toString().padLeft(1, '0')}:${_duration!.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                  style: GoogleFonts.nunitoSans().copyWith(
                    fontSize: 0.07 * width * _aspecRatio,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _updateDuration() {
    if (duration == null) return;
    _duration = duration;
    _durationCount = 0;
    Future.microtask(() async {
      while (_duration!.inSeconds > 0) {
        _duration = Duration(seconds: duration!.inSeconds - _durationCount);
        log("Duration: ${_duration!.inSeconds}");
        _durationStream.sink.add(_duration!);
        await Future.delayed(const Duration(seconds: 1));
        _durationCount += 1;
      }
    });
  }
}

class DashedLineHorizontalPainter extends CustomPainter {
  DashedLineHorizontalPainter({
    required this.aspecRatio,
  });

  final double aspecRatio;

  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = size.width * 0.02 * aspecRatio,
        dashSpace = size.width * 0.02 * aspecRatio,
        startX = 0;
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class QrHeaderClipper extends CustomClipper<Path> {
  QrHeaderClipper({
    required this.aspecRatio,
  });

  final double aspecRatio;

  @override
  Path getClip(Size size) {
    var path = Path();
    final width = size.width;
    final height = size.height;

    path.lineTo(width - width * 0.15 * aspecRatio, 0);
    path.lineTo(width, height * 0.13 * aspecRatio);
    path.lineTo(height, 0);
    path.lineTo(width, height);
    path.lineTo(0, height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
