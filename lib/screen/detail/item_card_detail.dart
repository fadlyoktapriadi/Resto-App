
import 'package:flutter/material.dart';

class ItemCardDetail extends StatelessWidget {
  final String label;

  const ItemCardDetail({required this.label, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Center(
          child: Text(label, style: Theme.of(context).textTheme.bodySmall),
        ),
      ),
    );
  }
}
