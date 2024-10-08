<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

The KHQR package is QR widgets that align with Cambodia QR spec.

## Features

It's easily to show KHQR in your app.

## Getting started

To geting start with the package. Add dependency to your `pubspec.yaml`

```yaml
dependencies:
  khqr_widget: 'latest-version'
```

## Usage

- KhqrWidget

![Preview](https://github.com/Sophoun/khqr_widget/raw/main/khqr_preview.png)

```dart
KhqrWidget(
  width: 300,
  receiverName: "Cambify",
  amount: "25.00",
  currency: "USD",
  qr: "YOUR_QR_DATA",
  qrIcon: Image.asset(
     "assets/images/logo.png",
  ),
  duration: const Duration(minutes: 3),
  onRetry: () => {
    // TODO()
  },
  clearAmountIcon: const Icon(
    Icons.clear_rounded,
    color: Colors.black,
  ),
  expiredIcon: Container(
    constraints: const BoxConstraints.expand(),
    color: Colors.green,
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
```

- KhqrStandWidget

![Preview](https://github.com/Sophoun/khqr_widget/raw/main/khqr_stand_preview.png)

```dart
KhqrStandWidget(
  logo: Image.asset("assets/cambify.png"),
  qrData:
      "YOUR_QR_DATA",
  name: "John Due",
  bakongId: "yourbakong@id",
  qrIcon: Image.asset("assets/dolar_symbol.png"),
)
```

## MIT License

```
Copyright (c) 2023 Sophoun Nheum

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
