import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sandwich Shop App',
      home: OrderScreen(maxQuantity: 5),
    );
  }
}

class OrderScreen extends StatefulWidget {
  final int maxQuantity;

  const OrderScreen({super.key, this.maxQuantity = 10});

  @override
  State<OrderScreen> createState() {
    return _OrderScreenState();
  }
}

class _OrderScreenState extends State<OrderScreen> {
  int _quantity = 0;
  String _note = '';
  late final TextEditingController _noteController;
  String _selectedType = 'Footlong';
  static const List<String> _sandwichTypes = ['Footlong', 'Six-inch'];

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _increaseQuantity() {
    if (_quantity < widget.maxQuantity) {
      setState(() {
        _note = _noteController.text;
        _quantity++;
        print('Current quantity: $_quantity');
      });
    }
  }

  void _decreaseQuantity() {
    if (_quantity > 0) {
      setState(() {
        _note = _noteController.text;
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sandwich Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OrderItemDisplay(
              _quantity,
              _selectedType,
              note: _note,
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 320,
              child: SegmentedButton<String>(
                segments: const <ButtonSegment<String>>[
                  ButtonSegment(value: 'Footlong', label: Text('Footlong')),
                  ButtonSegment(value: 'Six-inch', label: Text('Six-inch')),
                ],
                selected: <String>{_selectedType},
                onSelectionChanged: (Set<String> newSelection) {
                  if (newSelection.isEmpty) return;
                  setState(() => _selectedType = newSelection.first);
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 320,
              child: TextField(
                controller: _noteController,
                decoration: const InputDecoration(
                  labelText: 'Order note',
                  hintText: 'e.g., no onions, extra pickles',
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.done,
              ),
            ),
            const SizedBox(height: 12),
            // Wrap the Row in the same SizedBox width as the TextField
            SizedBox(
              width: 320,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.purple,
                    ),
                    onPressed: _quantity < widget.maxQuantity
                        ? _increaseQuantity
                        : null,
                    child: const Text('Add'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.purple,
                    ),
                    onPressed: _quantity > 0 ? _decreaseQuantity : null,
                    child: const Text('Remove'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderItemDisplay extends StatelessWidget {
  final int quantity;
  final String itemType;
  final String note;

  const OrderItemDisplay(this.quantity, this.itemType,
      {super.key, this.note = ''});

  @override
  Widget build(BuildContext context) {
    final noteText = note.isNotEmpty ? '\nNote: $note' : '';
    return Text(
      '$quantity $itemType sandwich(es): ${'🥪' * quantity}$noteText',
      textAlign: TextAlign.center,
    );
  }
}
