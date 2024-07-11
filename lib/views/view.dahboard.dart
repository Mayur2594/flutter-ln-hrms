import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(1, (index) {
          return Card.outlined(
            margin: const EdgeInsets.all(5), // Edge-to-edge
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0), // Edge-to-edge
            ),
            elevation: 6,
            shadowColor: Colors.grey,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Text(
                'Card ${index + 1}',
                style: const TextStyle(fontSize: 24),
              ),
            ),
          );
        }),
      ),
    );
  }
}
