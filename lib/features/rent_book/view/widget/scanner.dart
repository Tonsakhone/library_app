import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libary_management/features/rent_book/view/cubit/rent_book_cubit.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  QRViewController? _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(
      () {
        _controller = controller;
        _controller?.scannedDataStream.listen(
          (scanData) async {
            id = scanData.code.toString();
            if (id != "" && id.isNotEmpty) {
              await context.read<RentBookCubit>().qrScanner(id: id);
              _controller?.pauseCamera();
              if (mounted) return Navigator.pop(context);
            }
          },
        );
      },
    );
  }

  String id = "";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RentBookCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("BarCode Scanner"),
          centerTitle: true,
        ),
        body: QRView(
          key: _qrKey,
          onQRViewCreated: _onQRViewCreated,
        ),
      ),
    );
  }
}
