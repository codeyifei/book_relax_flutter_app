import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerDialog extends StatefulWidget {
  final String message;
  final DialogType type;
  final bool autoClose;
  final Duration autoCloseDuration;

  const CustomerDialog(
    this.message, {
    super.key,
    this.type = DialogType.info,
    this.autoClose = false,
    this.autoCloseDuration = const Duration(seconds: 3),
  });

  show({BuildContext? context}) {
    showDialog(
      context: context ?? Get.context!,
      barrierColor: Colors.black45,
      builder: (context) => this,
    );
  }

  @override
  State<CustomerDialog> createState() => _CustomerDialogState();
}

class _CustomerDialogState extends State<CustomerDialog> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    if (widget.autoClose) {
      _timer = Timer(widget.autoCloseDuration, () {
        Get.back();
      });
    }
  }

  @override
  void deactivate() {
    super.deactivate();

    _timer?.cancel();
  }

  Color get _iconColor {
    switch (widget.type) {
      case DialogType.info:
        return Colors.blue;
      case DialogType.warning:
        return Colors.orange;
      case DialogType.error:
        return Colors.red;
      case DialogType.success:
        return Colors.green;
    }
  }

  IconData get _icon {
    switch (widget.type) {
      case DialogType.success:
        return Icons.check_circle_outline;
      case DialogType.info:
        return Icons.info_outline;
      case DialogType.warning:
        return Icons.error_outline;
      case DialogType.error:
        return Icons.highlight_off;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Container(
        height: 300,
        padding: const EdgeInsets.all(16.0),
        child: FractionallySizedBox(
          widthFactor: 0.7,
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: FractionallySizedBox(
                  widthFactor: 0.7,
                  heightFactor: 0.7,
                  child: FittedBox(
                    child: Icon(
                      _icon,
                      color: _iconColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: widget.message.length > 10
                    ? _text
                    : FittedBox(
                        child: _text,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text get _text => Text(
        widget.message,
        maxLines: 2,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      );
}

enum DialogType {
  info,
  success,
  warning,
  error,
}
