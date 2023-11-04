import 'package:flutter/material.dart';
import 'package:flutter_delivery/common/layout/default_layout.dart';

class RootTap extends StatelessWidget {
  const RootTap({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      child: Scaffold(
        body: Center(
          child: Text('root tap'),
        ),
      ),
    );
  }
}
