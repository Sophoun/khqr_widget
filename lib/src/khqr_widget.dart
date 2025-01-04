import 'dart:async';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ignore: must_be_immutable
class KhqrWidget extends StatefulWidget {
  const KhqrWidget({
    super.key,
    this.width = 280,
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
    this.qrPadding = const EdgeInsets.all(4),
  });

  final double width;
  final String receiverName;
  final String amount;
  final String currency;
  final String? qr;
  final Image? qrIcon;
  final Duration? duration;
  final Function()? onRetry;
  final Color? shadowColor;
  final Widget? clearAmountIcon;
  final Widget? expiredIcon;
  final Function(Duration)? onCountingDown;
  final EdgeInsets qrPadding;

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
    return Container(
      width: widget.width * 0.8 * _aspecRatio,
      height: _height * 0.8 * _aspecRatio,
      color: Colors.transparent,
      child: AspectRatio(
        aspectRatio: _aspecRatio,
        child: LayoutBuilder(
          builder: (context, constraints) => Stack(
            children: [
              SizedBox(
                child: SvgPicture.string(khqrBackgroundSvgStr),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: constraints.minHeight * 0.08 * _aspecRatio,
                    top: constraints.minHeight * 0.03 * _aspecRatio,
                    right: constraints.minHeight * 0.08 * _aspecRatio,
                    bottom: constraints.minHeight * 0.03 * _aspecRatio),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// receiver name
                    SizedBox(
                      height: constraints.minHeight * 0.15 * _aspecRatio,
                    ),
                    Row(
                      children: [
                        AutoSizeText(
                          widget.receiverName,
                          maxLines: 1,
                          minFontSize: 8,
                          maxFontSize: 12,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.roboto(
                            fontSize: 24 * _aspecRatio,
                          ),
                        ),
                      ],
                    ),

                    /// Amount and currency
                    SizedBox(
                      height: constraints.minHeight * 0.03 * _aspecRatio,
                    ),
                    Row(
                      spacing: constraints.minHeight * 0.03 * _aspecRatio,
                      textBaseline: TextBaseline.alphabetic,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /// Amount
                        AutoSizeText(
                          widget.amount,
                          maxLines: 1,
                          minFontSize: 8,
                          maxFontSize: 22,
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontSize: 42 * _aspecRatio,
                          ),
                        ),

                        /// Currency
                        AutoSizeText(
                          widget.currency,
                          maxLines: 1,
                          minFontSize: 8,
                          maxFontSize: 12,
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            fontSize: 22 * _aspecRatio,
                          ),
                        ),
                        const Spacer(),

                        /// Clear amount
                        if (widget.clearAmountIcon != null)
                          widget.clearAmountIcon!,
                      ],
                    ),

                    /// QR
                    SizedBox(
                      height: constraints.minHeight * 0.1 * _aspecRatio,
                    ),
                    StreamBuilder<Duration>(
                        stream: _durationStream.stream,
                        builder: (context, snapshot) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              /// QR data to show
                              QrImageView(
                                size: constraints.maxWidth * 1.1 * _aspecRatio,
                                data: widget.qr!,
                                padding: widget.qrPadding,
                              ),

                              /// Expired icon
                              if (snapshot.data?.inSeconds == 0 &&
                                  widget.expiredIcon != null)
                                SizedBox(
                                    width: constraints.maxWidth *
                                        1.1 *
                                        _aspecRatio,
                                    height: constraints.maxWidth *
                                        1.1 *
                                        _aspecRatio,
                                    child: GestureDetector(
                                        onTap: () {
                                          _updateDuration();
                                          widget.onRetry?.call();
                                        },
                                        child: widget.expiredIcon!)),
                            ],
                          );
                        }),

                    /// Counting down
                    SizedBox(
                      height: constraints.maxWidth * 0.05 * _aspecRatio,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: StreamBuilder<Duration>(
                            stream: _durationStream.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return widget.onCountingDown != null
                                    ? widget.onCountingDown!(snapshot.data!)
                                    : AutoSizeText(
                                        "Expired in ${snapshot.data!.inSeconds} seconds",
                                        maxLines: 1,
                                        minFontSize: 8,
                                        maxFontSize: 12,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          fontSize: 12 * _aspecRatio,
                                        ),
                                      );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
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

String get khqrBackgroundSvgStr => """
<svg width="283" height="420" viewBox="0 0 283 420" fill="none" xmlns="http://www.w3.org/2000/svg">
<rect x="1" width="281" height="420" rx="20" fill="white"/>
<path d="M281.716 39.0078H258.688L281.716 61.9974V39.0078Z" fill="#E21A1A"/>
<path d="M1.28906 20C1.28906 8.9543 10.2434 0 21.2891 0H261.711C272.757 0 281.711 8.9543 281.711 20V39.0153H1.28906V20Z" fill="#E21A1A"/>
<path d="M149.581 17.8479V21.9761H145.523C145.117 21.9761 144.812 21.6665 144.812 21.2536V17.8479C144.812 17.435 145.117 17.1254 145.523 17.1254H148.769C149.277 17.0222 149.581 17.435 149.581 17.8479Z" fill="white"/>
<path d="M168.447 19.5019H166.418C166.418 17.025 164.491 15.0641 162.056 15.0641C160.128 15.0641 158.505 16.3025 157.896 18.1602C157.795 18.5731 157.693 19.0891 157.693 19.5019V26.0038H157.592C156.476 26.0038 155.664 25.075 155.664 24.0429V19.5019C155.664 17.7474 156.374 15.9929 157.693 14.7545C158.911 13.6192 160.433 13 162.056 13C165.606 13 168.447 15.8898 168.447 19.5019Z" fill="white"/>
<path d="M168.438 26.0081H165.597L164.887 25.2857L163.365 23.7376L161.234 21.5703H164.075L168.438 26.0081Z" fill="white"/>
<path d="M150.295 23.9397H144.208C143.497 23.9397 142.889 23.3205 142.889 22.5981V16.4058C142.889 15.6833 143.497 15.0641 144.208 15.0641H150.295C151.005 15.0641 151.614 15.6833 151.614 16.4058V22.5981L153.643 24.6621V14.9609C153.643 13.8256 152.729 13 151.715 13H142.889C141.772 13 140.961 13.9288 140.961 14.9609V23.9397C140.961 25.075 141.874 25.9006 142.889 25.9006H152.324L150.295 23.9397Z" fill="white"/>
<path d="M125.629 26.0038H122.788L116.904 19.9148V26.0038H114.57V13H116.904V18.7795L122.586 13H125.324L119.237 19.1923L125.629 26.0038Z" fill="white"/>
<path d="M136.287 13H138.52V26.0038H136.287V20.3275H129.794V26.0038H127.461V13H129.794V18.4698H136.287V13Z" fill="white"/>
<path d="M1 124.07H282" stroke="black" stroke-opacity="0.5" stroke-linecap="square" stroke-linejoin="round" stroke-dasharray="8 8"/>
</svg>
""";
