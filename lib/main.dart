import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Sandwich Counter')),
            body: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OrderItemDisplay(5, 'Footlong'),
                  OrderItemDisplay(5, 'Footlong'),
                  OrderItemDisplay(5, 'Footlong'),
                ])));
  }
}

class OrderItemDisplay extends StatelessWidget {
  final String itemType;
  final int quantity;

  const OrderItemDisplay(this.quantity, this.itemType, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 400,
        height: 50,
        color: Colors.lime,
        alignment: Alignment.center,
        child: Text('$quantity $itemType sandwich(es): ${'🥪' * quantity}'));
  }
}
