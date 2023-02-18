import 'package:flutter/material.dart';

/// Wrapper for stateful functionality to provide onInit calls in stateles widget
// ignore: must_be_immutable
class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;
  Function? onDelete;
  StatefulWrapper(
      {super.key, required this.onInit, required this.child, this.onDelete});
  @override
  // ignore: library_private_types_in_public_api
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    // ignore: unnecessary_null_comparison
    if (widget.onInit != null) {
      widget.onInit();
    }
    super.initState();
  }

  @override
  void dispose() {
    // ignore: unnecessary_null_comparison
    if (widget.onDelete != null) {
      widget.onDelete!();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
