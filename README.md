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

![Preview](https://github.com/Sophoun/khqr/raw/main/khqr_preview.png)

## Getting started

To geting start with the package. Add dependency to your `pubspec.yaml`

```yaml
dependencies:
  khqr: 'latest-version'
```

## Usage

```dart
KhqrWidget(
  width: 300,
  receiverName: "Cambify",
  amount: "25.00"
  currency: "USD",
  qr: "your-qr-string",
  image: Image.asset(
     "assets/images/logo.png",
  ),
  duration:
      widget.checkoutController.verifyPaymentTimeout,
  onRetry: () => _checkPaymentWithRetry(
    context,
    widget.checkout.saleOrder.id,
  ),
),
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
