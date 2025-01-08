import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khqr_widget/src/scale.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ignore: must_be_immutable
class KhqrWidget extends StatefulWidget {
  const KhqrWidget({
    super.key,
    this.width = 300,
    this.height = 450,
    required this.receiverName,
    required this.amount,
    required this.currency,
    required this.qr,
    this.qrIcon,
    this.duration,
    this.onRetry,
    this.clearAmountIcon,
    this.expiredIcon,
    this.onCountingDown,
    this.qrPadding = const EdgeInsets.all(4),
  });

  final double width;
  final double height;
  final String receiverName;
  final String amount;
  final String currency;
  final String? qr;
  final Image? qrIcon;
  final Duration? duration;
  final Function()? onRetry;
  final Widget? clearAmountIcon;
  final Widget? expiredIcon;
  final Function(Duration)? onCountingDown;
  final EdgeInsets qrPadding;

  @override
  State<KhqrWidget> createState() => _KhqrWidgetState();
}

class _KhqrWidgetState extends State<KhqrWidget> {
  double get aspecRatio => 20 / 29;
  Duration? _duration;
  int _durationCount = 0;
  final _durationStream = StreamController<Duration>.broadcast();

  @override
  void initState() {
    super.initState();

    /// Setup the screen with the device screen [Size] and the [size] you will use.
    Scale.setupWith(const Size(1080, 1920), Size(widget.width, widget.height));

    /// Update the duration
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _updateDuration();
    });
  }

  @override
  void dispose() {
    /// Dispose the duration stream
    _durationStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: widget.width,
        maxHeight: widget.height,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          alignment: Alignment.topCenter,
          children: [
            SvgPicture.string(
              khqrBackgroundSvgStr,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.only(
                  left: constraints.maxWidth * 0.08,
                  top: constraints.maxHeight * 0.11,
                  right: constraints.maxWidth * 0.08,
                  bottom: constraints.maxHeight * 0.0),
              child: StreamBuilder(
                stream: _durationStream.stream,
                builder: (context, snapshot) => Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// Group of Receiver and and Amount
                    SizedBox(
                      width: constraints.maxWidth * 0.9,
                      height: constraints.maxHeight * 0.15,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Text(
                              widget.receiverName,
                              style: TextStyle(
                                  fontSize: constraints.maxHeight * 0.03),
                              maxLines: 1,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Row(
                            spacing: constraints.maxWidth * 0.02,
                            textBaseline: TextBaseline.alphabetic,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth: constraints.maxWidth * 0.7,
                                ),
                                child: FittedBox(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    spacing: constraints.maxWidth * 0.03,
                                    textBaseline: TextBaseline.alphabetic,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    children: [
                                      Text(
                                        widget.amount,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: constraints.maxWidth * 0.1,
                                        ),
                                        maxLines: 1,
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        widget.currency,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: constraints.maxWidth * 0.05,
                                        ),
                                        maxLines: 1,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                  width: constraints.maxWidth * 0.1,
                                  height: constraints.maxWidth * 0.1,
                                  child: widget.clearAmountIcon ??
                                      const SizedBox()),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: constraints.maxHeight *
                            (widget.onCountingDown != null ? 0.07 : 0.1)),

                    /// Group of QR
                    Container(
                      width: constraints.maxWidth * 0.9,
                      height: constraints.maxHeight * 0.56,
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          if (widget.qr != null)
                            QrImageView(
                              size: constraints.maxWidth * 0.9,
                              data: widget.qr!,
                              padding: widget.qrPadding,
                              embeddedImage: widget.qrIcon?.image,
                            ),

                          /// if expired
                          if (_duration != null &&
                              snapshot.data?.inSeconds == 0)
                            SizedBox(
                              width: constraints.maxWidth * 0.9,
                              height: constraints.maxHeight * 0.56,
                              child: GestureDetector(
                                onTap: () {
                                  _updateDuration();
                                  widget.onRetry?.call();
                                },
                                child: widget.expiredIcon!,
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.02),
                    if (_duration != null && widget.onCountingDown != null)
                      Container(
                        width: constraints.maxWidth * 0.9,
                        height: constraints.maxHeight * 0.06,
                        alignment: Alignment.center,
                        child: FittedBox(
                          child: widget
                              .onCountingDown!(snapshot.data ?? Duration.zero),
                        ),
                      )
                  ],
                ),
              ),
            )
          ],
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
        _durationStream.sink.add(_duration!);
        await Future.delayed(const Duration(seconds: 1));
        _durationCount += 1;
        if (!mounted) break;
      }
    });
  }
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
