import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';

class ParentGate {
  ParentGate._();

  static bool _passed = false;
  static int _a = 3;
  static int _b = 2;

  static void reset() {
    _passed = false;
  }

  static Future<bool> verify(BuildContext context) async {
    if (_passed) return true;

    final completer = Completer<bool>();
    _a = 3 + DateTime.now().millisecondsSinceEpoch % 3;
    _b = 2;

    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => _ParentGateDialog(
        a: _a,
        b: _b,
        completer: completer,
      ),
    );

    final result = await completer.future;
    if (result == true) {
      _passed = true;
    }
    return result;
  }
}

class _ParentGateDialog extends StatefulWidget {
  final int a;
  final int b;
  final Completer<bool> completer;
  const _ParentGateDialog({
    required this.a,
    required this.b,
    required this.completer,
  });

  @override
  State<_ParentGateDialog> createState() => _ParentGateDialogState();
}

class _ParentGateDialogState extends State<_ParentGateDialog>
    with SingleTickerProviderStateMixin {
  final _controller = TextEditingController();
  late AnimationController _shakeCtrl;
  late Animation<double> _shakeAnim;

  @override
  void initState() {
    super.initState();
    _shakeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _shakeAnim = _shakeCtrl.drive(Tween<double>(begin: 0, end: 8))
      ..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    _shakeCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    final value = int.tryParse(text);
    if (value == null || value != widget.a + widget.b) {
      _shakeCtrl.forward().then((_) => _shakeCtrl.reverse());
      _controller.clear();
      return;
    }
    widget.completer.complete(true);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final shakeOffset = _shakeAnim.value;
    return AlertDialog(
      title: const Text('Parents Only'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Solve this to continue:'),
          const SizedBox(height: 16),
          Transform.translate(
            offset: Offset(shakeOffset, 0),
            child: Text(
              '${widget.a} + ${widget.b} = ?',
              style: AppTypography.displayHero.copyWith(
                color: AppColors.primary,
                fontSize: 32,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Enter answer',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.completer.complete(false);
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Go'),
        ),
      ],
    );
  }
}

class ParentGatedWidget extends StatefulWidget {
  final Widget child;

  const ParentGatedWidget({super.key, required this.child});

  @override
  State<ParentGatedWidget> createState() => _ParentGatedWidgetState();
}

class _ParentGatedWidgetState extends State<ParentGatedWidget> {
  bool _verified = false;

  @override
  void initState() {
    super.initState();
    _check();
  }

  Future<void> _check() async {
    final ok = await ParentGate.verify(context);
    if (mounted) {
      setState(() => _verified = ok);
      if (!ok) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_verified) return const SizedBox.shrink();
    return widget.child;
  }
}
