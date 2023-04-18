import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

class KhqrStandWidget extends StatelessWidget {
  const KhqrStandWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100),
      width: 1470,
      child: Center(
        child: Stack(
          children: [
            const Image(
              image: AssetImage(
                'assets/images/Vector.png',
                package: "khqr",
              ),
            ),
            const Align(
              alignment: AlignmentDirectional.topStart,
              child: Image(
                image: AssetImage(
                  'assets/images/Vector1.png',
                  package: "khqr",
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    const SizedBox(
                      width: 220,
                      height: 60,
                      child: Image(
                        image: AssetImage(
                          'assets/images/Prince_Logo_3.png',
                          package: "khqr",
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Scan. Pay. Done.',
                        style: GoogleFonts.nunitoSans(
                          textStyle: Theme.of(context).textTheme.headlineMedium,
                          fontSize: 16,
                          color: const Color(0xFF000000),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        // Top Left
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black.withOpacity(0.2),
                                width: 3.0), //Border.all
                            borderRadius: const BorderRadius.only(
                                topLeft:
                                    Radius.circular(20)), //BorderRadius.all
                          ),
                        ),
                        // Top Left Overlap
                        Positioned(
                          top: 3,
                          left: 3,
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.white, width: 3.0), //Border.all
                              /*** The BorderRadius widget  is here ***/
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20)), //
                            ),
                          ),
                        ),
                        // Top Right
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black.withOpacity(0.2),
                                width: 3,
                              ),
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(20)),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 3,
                          right: 3,
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.white, width: 3.0), //Border.all
                              /*** The BorderRadius widget  is here ***/
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(20)), //
                            ),
                          ),
                        ),
                        // Bottom Left
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.2),
                                  width: 3.0), //Border.all
                              borderRadius: const BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(20)), //BorderRadius.all
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 3,
                          left: 3,
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.white, width: 3.0), //Border.all
                              /*** The BorderRadius widget  is here ***/
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20)), //
                            ),
                          ),
                        ),
                        // Bottom Left Overlap
                        Positioned(
                          bottom: 3,
                          left: 3,
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.white, width: 3.0), //Border.all
                              /*** The BorderRadius widget  is here ***/
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20)), //
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black.withOpacity(0.2),
                                width: 3,
                              ),
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(20)),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 3,
                          right: 3,
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.white, width: 3.0), //Border.all
                              /*** The BorderRadius widget  is here ***/
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(20)), //
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: 180,
                          width: 180,
                          child: QrImage(
                            data:
                                'Sok Somnangjjhgffghggdddssopppjgdasdfrlcxsuytrraassdd',
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Sok Somnang',
                        style: GoogleFonts.poppins(
                          textStyle: Theme.of(context).textTheme.titleLarge,
                          fontSize: 26,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 118, top: 35),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Member of',
                            style: GoogleFonts.poppins(
                              textStyle: Theme.of(context).textTheme.titleLarge,
                              fontSize: 9,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Image(
                            image: AssetImage(
                              'assets/images/KHQR_Logo.png',
                              package: "khqr",
                            ),
                            width: 60,
                            fit: BoxFit.fill,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Bank Hotline: 1800-20-8888',
                            maxLines: 1,
                            style: GoogleFonts.poppins(
                              textStyle: Theme.of(context).textTheme.titleLarge,
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Align(
              alignment: AlignmentDirectional.bottomStart,
              child: Padding(
                  padding: EdgeInsets.only(bottom: 3.6),
                  child: Image(
                    image: AssetImage(
                      'assets/images/Vector2.png',
                      package: "khqr",
                    ),
                    width: 287,
                  )),
            ),
            const Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Padding(
                  padding: EdgeInsets.only(bottom: 4.2),
                  child: Image(
                    image: AssetImage(
                      'assets/images/Group.png',
                      package: "khqr",
                    ),
                    width: 140,
                    fit: BoxFit.cover,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
