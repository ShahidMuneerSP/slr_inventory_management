// ignore_for_file: file_names, deprecated_member_use, unnecessary_null_comparison

import 'dart:developer';
import 'dart:math' hide log;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:slr_inventory_management/Screens/Sales/Sales%20Customer/widgets/Add%20Customer%20Sale/controller/addCustomerSaleController.dart';




class Productserachbarcodescanner extends StatefulWidget {
  final Addcustomersalecontroller controllers;
  final String type;
  final String id;
  final String sellType;
 const Productserachbarcodescanner({
    super.key,
    required this.controllers,
    required this.type,
    required this.id,
    required this.sellType,
  });

  @override
  State<Productserachbarcodescanner> createState() => _ProductserachbarcodescannerState();
}

var scanArea = 250.0;
//final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
// QRViewController? _controller;
// Barcode? result;

final text = TextEditingController();

class _ProductserachbarcodescannerState extends State<Productserachbarcodescanner> {
  @override
  void dispose() {
    log('Disposed');
    controller.dispose();
    super.dispose();
  }

  BarcodeCapture? barCode;

  MobileScannerController controller = MobileScannerController(
    torchEnabled: false,
  );

  //final form = Get.put(FormController());
  bool isStarted = true;
  double _zoomFactor = 0.0;
  @override
  Widget build(BuildContext context) {
    controller.start();
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Material(
          color: Colors.transparent,
          elevation: 5,
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
      ),
      body: Stack(
        children: [
          MobileScanner(
            placeholderBuilder: (p0, p1) {
              return Center(child: CircularProgressIndicator());
            },
            //  overlay: OverlayBarCodeWidget(),
            controller: controller,

            errorBuilder: (context, error, child) {
              return ScannerErrorWidget(error: error);
            },
            onDetect: (barcode) {
              setState(() {
                barCode = barcode;
              });

              print(
                'ON Detected : ' + (barcode.barcodes.first.rawValue.toString()),
              );
              controller.stop();

              onScannerDetected(
                texts: barcode.barcodes.first.rawValue.toString(),
              );
            },
          ),
          Positioned.fill(
            child: Container(
              decoration: ShapeDecoration(
                shape: QrScannerOverlayShape(
                  cutOutHeight: 200,
                  cutOutWidth: 300,
                  cutOutBottomOffset: 50,
                  borderColor: Color.fromARGB(255, 255, 189, 76),
                  borderRadius: 10,
                  borderLength: 20,
                  borderWidth: 9,
                  // cutOutSize: 250.0,
                ),
              ),
            ),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 300,
                height: 50,
                child: Slider(
                  activeColor: Color.fromARGB(255, 255, 189, 76),

                  inactiveColor: Color.fromARGB(255, 255, 189, 76).withOpacity(0.4),
                  value: _zoomFactor,
                  onChanged: (value) {
                    setState(() {
                      _zoomFactor = value;
                      controller.setZoomScale(value);
                    });
                  },
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 90,
              color: Colors.black.withOpacity(0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromARGB(255, 255, 189, 76),
                        ),
                        child: IconButton(
                          color: Colors.white,
                          icon: ValueListenableBuilder<TorchState>(
                            valueListenable: controller.torchState,
                            builder: (context, state, child) {
                              switch (state) {
                                case TorchState.off:
                                  return const Icon(
                                    Icons.flash_off,
                                    color: Colors.blueGrey,
                                  );
                                case TorchState.on:
                                  return const Icon(
                                    Icons.flash_on,
                                    color: Colors.black,
                                  );
                              }
                            },
                          ),
                          iconSize: 32.0,
                          onPressed: () {
                            setState(() {
                              controller.toggleTorch();
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromARGB(255, 255, 189, 76),
                        ),
                        child: IconButton(
                          color: Colors.white,
                          icon: ValueListenableBuilder<CameraFacing>(
                            valueListenable: controller.cameraFacingState,
                            builder: (context, state, child) {
                              switch (state) {
                                case CameraFacing.back:
                                  return Icon(
                                    Icons.flip_camera_ios_outlined,
                                    color: Colors.black,
                                  );
                                case CameraFacing.front:
                                  return Icon(
                                    Icons.flip_camera_ios_outlined,
                                    color: Colors.white,
                                  );
                              }
                            },
                          ),
                          iconSize: 32.0,
                          onPressed: () {
                            setState(() {
                              controller.switchCamera();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  onScannerDetected({required String texts}) {
    try {
      if (texts.length < 14) {
        if (texts != null) {
          setState(() {
            widget.controllers.searchProductController.text = texts;
          });
          // _controller!.stopCamera();
          // _controller!.resumeCamera();
        
          widget.controllers.isFast.value = false;
          widget.controllers.isEmpty.value = true;
          widget.controllers.minimumLetter.value = false;
          // widget.controllers.searchWithApi(
          //   text: widget.controllers.text.text,
          //   id: widget.id,
          //   sellType: widget.sellType,
          //   type: widget.type,
          // );
          Get.back();
          log('Success$texts');
        } else {
          //  _popUp(context);
          log('Fail$texts');
        }
      } else {
       // form.errorSnackBar(title: 'Oops', text: 'Invalid BarCode');
      }
    } catch (e) {
      log('Error  in scanning $e');
    }
  }
}


class ScannerErrorWidget extends StatelessWidget {
  const ScannerErrorWidget({super.key, required this.error});

  final MobileScannerException error;

  @override
  Widget build(BuildContext context) {
    String errorMessage;

    switch (error.errorCode) {
      case MobileScannerErrorCode.controllerUninitialized:
        errorMessage = 'Controller not ready.';
        break;
      case MobileScannerErrorCode.permissionDenied:
        errorMessage = 'Permission denied';
        break;
      case MobileScannerErrorCode.unsupported:
        errorMessage = 'Scanning is unsupported on this device';
        break;
      default:
        errorMessage = 'Generic Error';
        break;
    }

    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Icon(Icons.error, color: Colors.white),
            ),
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              error.errorDetails?.message ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}



class QrScannerOverlayShape extends ShapeBorder {
  QrScannerOverlayShape({
    this.borderColor = Colors.red,
    this.borderWidth = 3.0,
    this.overlayColor = const Color.fromRGBO(0, 0, 0, 80),
    this.borderRadius = 0,
    this.borderLength = 40,
    double? cutOutSize,
    double? cutOutWidth,
    double? cutOutHeight,
    this.cutOutBottomOffset = 0,
  })  : cutOutWidth = cutOutWidth ?? cutOutSize ?? 250,
        cutOutHeight = cutOutHeight ?? cutOutSize ?? 250 {
    assert(
    borderLength <=
        min(this.cutOutWidth, this.cutOutHeight) / 2 + borderWidth * 2,
    "Border can't be larger than ${min(this.cutOutWidth, this.cutOutHeight) / 2 + borderWidth * 2}",
    );
    assert(
    (cutOutWidth == null && cutOutHeight == null) ||
        (cutOutSize == null && cutOutWidth != null && cutOutHeight != null),
    'Use only cutOutWidth and cutOutHeight or only cutOutSize');
  }

  final Color borderColor;
  final double borderWidth;
  final Color overlayColor;
  final double borderRadius;
  final double borderLength;
  final double cutOutWidth;
  final double cutOutHeight;
  final double cutOutBottomOffset;

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path getLeftTopPath(Rect rect) {
      return Path()
        ..moveTo(rect.left, rect.bottom)
        ..lineTo(rect.left, rect.top)
        ..lineTo(rect.right, rect.top);
    }

    return getLeftTopPath(rect)
      ..lineTo(
        rect.right,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.top,
      );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final width = rect.width;
    final borderWidthSize = width / 2;
    final height = rect.height;
    final borderOffset = borderWidth / 2;
    final mBorderLength =
    borderLength > min(cutOutHeight, cutOutHeight) / 2 + borderWidth * 2
        ? borderWidthSize / 2
        : borderLength;
    final mCutOutWidth =
    cutOutWidth < width ? cutOutWidth : width - borderOffset;
    final mCutOutHeight =
    cutOutHeight < height ? cutOutHeight : height - borderOffset;

    final backgroundPaint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final boxPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final cutOutRect = Rect.fromLTWH(
      rect.left + width / 2 - mCutOutWidth / 2 + borderOffset,
      -cutOutBottomOffset +
          rect.top +
          height / 2 -
          mCutOutHeight / 2 +
          borderOffset,
      mCutOutWidth - borderOffset * 2,
      mCutOutHeight - borderOffset * 2,
    );

    canvas
      ..saveLayer(
        rect,
        backgroundPaint,
      )
      ..drawRect(
        rect,
        backgroundPaint,
      )
      // Draw top right corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.right - mBorderLength,
          cutOutRect.top,
          cutOutRect.right,
          cutOutRect.top + mBorderLength,
          topRight: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
    // Draw top left corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.left,
          cutOutRect.top,
          cutOutRect.left + mBorderLength,
          cutOutRect.top + mBorderLength,
          topLeft: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
    // Draw bottom right corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.right - mBorderLength,
          cutOutRect.bottom - mBorderLength,
          cutOutRect.right,
          cutOutRect.bottom,
          bottomRight: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
    // Draw bottom left corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.left,
          cutOutRect.bottom - mBorderLength,
          cutOutRect.left + mBorderLength,
          cutOutRect.bottom,
          bottomLeft: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      ..drawRRect(
        RRect.fromRectAndRadius(
          cutOutRect,
          Radius.circular(borderRadius),
        ),
        boxPaint,
      )
      ..restore();
  }

  @override
  ShapeBorder scale(double t) {
    return QrScannerOverlayShape(
      borderColor: borderColor,
      borderWidth: borderWidth,
      overlayColor: overlayColor,
    );
  }
}