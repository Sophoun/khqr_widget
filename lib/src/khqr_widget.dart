import 'dart:async';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ignore: must_be_immutable
class KhqrWidget extends StatefulWidget {
  const KhqrWidget({
    super.key,
    this.width = 300,
    required this.receiverName,
    required this.amount,
    required this.currency,
    required this.qr,
    this.qrIcon,
    this.duration,
    this.onRetry,
    this.shadowColor,
    this.clearAmountIcon,
    this.expiredIcon,
    this.onCountingDown,
  });

  final double width;
  final String receiverName;
  final String amount;
  final String currency;
  final String qr;
  final Image? qrIcon;
  final Duration? duration;
  final Function()? onRetry;
  final Color? shadowColor;
  final Widget? clearAmountIcon;
  final Widget? expiredIcon;
  final Function(Duration)? onCountingDown;

  @override
  State<KhqrWidget> createState() => _KhqrWidgetState();
}

class _KhqrWidgetState extends State<KhqrWidget> {
  double get _aspecRatio => 20 / 29;
  double get _height => (widget.width / _aspecRatio);
  Duration? _duration;
  int _durationCount = 0;
  final _durationStream = StreamController<Duration>.broadcast();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _updateDuration();
    });
  }

  @override
  void dispose() {
    _durationStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: widget.width - 25,
            height: _height,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(widget.width * 0.12 * _aspecRatio),
              boxShadow: [
                BoxShadow(
                  color: widget.shadowColor ?? Colors.black.withAlpha(20),
                  blurRadius: widget.width * 0.16 * _aspecRatio,
                  offset: const Offset(0, 0), // Shadow position
                ),
              ],
            ),
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                Container(
                  height: _height * 0.15 * _aspecRatio,
                  width: widget.width,
                  color: const Color.fromRGBO(255, 35, 26, 1),
                  padding: EdgeInsets.all(widget.width * 0.07 * _aspecRatio),
                  child: const Image(
                    image: AssetImage(
                      "assets/images/KHQR_Logo_white.png",
                      package: "khqr_widget",
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: widget.width,
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
                              height: _height * 0.05 * _aspecRatio,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.symmetric(
                                horizontal: widget.width * 0.1 * _aspecRatio,
                              ),
                              child: AutoSizeText(
                                widget.receiverName,
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                maxFontSize: 14,
                                minFontSize: 8,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.nunitoSans().copyWith(
                                  fontSize: 0.07 * widget.width * _aspecRatio,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: _height * 0.005 * _aspecRatio,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.symmetric(
                                horizontal: widget.width * 0.1 * _aspecRatio,
                              ),
                              child: Row(
                                textDirection: TextDirection.ltr,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RichText(
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                      text: widget.amount,
                                      style: GoogleFonts.nunitoSans().copyWith(
                                        fontSize:
                                            0.15 * widget.width * _aspecRatio,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: widget.width * 0.03 * _aspecRatio,
                                  ),
                                  RichText(
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                      text: widget.currency,
                                      style: GoogleFonts.nunitoSans().copyWith(
                                        fontSize:
                                            0.07 * widget.width * _aspecRatio,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  if (widget.clearAmountIcon != null)
                                    widget.clearAmountIcon!
                                ],
                              ),
                            ),
                            SizedBox(
                              height: _height * 0.03 * _aspecRatio,
                            ),
                            CustomPaint(
                              painter: DashedLineHorizontalPainter(
                                aspecRatio: _aspecRatio,
                              ),
                              size: Size(widget.width, 1),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: _height * 0.06 * _aspecRatio),
                                    child: SizedBox(
                                      width: _height * 0.78 * _aspecRatio,
                                      height: _height * 0.78 * _aspecRatio,
                                      child: StreamBuilder<Duration>(
                                        stream: _durationStream.stream,
                                        builder: (context, snapshot) {
                                          final data = snapshot.data;
                                          return Stack(
                                            children: [
                                              QrImageView(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                data: widget.qr,
                                                version: QrVersions.auto,
                                                backgroundColor: Colors.white,
                                                embeddedImage:
                                                    widget.qrIcon?.image,
                                              ),
                                              if ((data?.inSeconds ?? 0) <= 0)
                                                widget.expiredIcon != null
                                                    ? Container(
                                                        constraints:
                                                            const BoxConstraints
                                                                .expand(),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            widget.onRetry
                                                                ?.call();
                                                            _updateDuration();
                                                          },
                                                          child: widget
                                                              .expiredIcon!,
                                                        ),
                                                      )
                                                    : Container(
                                                        color: Colors.black
                                                            .withAlpha(230),
                                                        constraints:
                                                            const BoxConstraints
                                                                .expand(),
                                                        child: MouseRegion(
                                                          cursor:
                                                              SystemMouseCursors
                                                                  .click,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {},
                                                            child: const Icon(
                                                              Icons
                                                                  .restart_alt_rounded,
                                                              color:
                                                                  Colors.white,
                                                              size: 50,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  if (widget.duration != null)
                                    SizedBox(
                                      height: _height * 0.05 * _aspecRatio,
                                    ),
                                  if (widget.duration != null)
                                    StreamBuilder<Duration>(
                                      stream: _durationStream.stream,
                                      builder: (context, snapshot) => widget
                                                  .onCountingDown !=
                                              null
                                          ? widget.onCountingDown!(
                                              snapshot.data ??
                                                  const Duration(seconds: 0))
                                          : RichText(
                                              textDirection: TextDirection.ltr,
                                              textAlign: TextAlign.left,
                                              text: TextSpan(
                                                text:
                                                    "QR expired in: ${_duration?.inMinutes.remainder(60).toString().padLeft(1, '0')}:${_duration?.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                                                style: GoogleFonts.nunitoSans()
                                                    .copyWith(
                                                  fontSize: 0.07 *
                                                      widget.width *
                                                      _aspecRatio,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ),
                                    ),
                                ],
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
        ],
      ),
    );
  }

  void _updateDuration() {
    if (widget.duration == null) return;
    _duration = widget.duration;
    _durationCount = 0;
    Future.microtask(() async {
      while (_duration!.inSeconds > 0) {
        _duration =
            Duration(seconds: widget.duration!.inSeconds - _durationCount);
        log("Duration: ${_duration!.inSeconds}");
        _durationStream.sink.add(_duration!);
        await Future.delayed(const Duration(seconds: 1));
        _durationCount += 1;
        if (!mounted) break;
      }
    });
  }
}

/// [DashedLineHorizontalPainter] help to draw dashed line
class DashedLineHorizontalPainter extends CustomPainter {
  DashedLineHorizontalPainter({
    required this.aspecRatio,
  });

  final double aspecRatio;

  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = size.width * 0.07 * aspecRatio,
        dashSpace = size.width * 0.04 * aspecRatio,
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

/// [QrHeaderClipper] help to clip header
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

    path.lineTo(width - width * 0.13 * aspecRatio, 0);
    path.lineTo(width, height * 0.1 * aspecRatio);
    path.lineTo(height, 0);
    path.lineTo(width, height);
    path.lineTo(0, height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
