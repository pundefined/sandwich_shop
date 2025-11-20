import 'package:flutter/material.dart';
import 'package:sandwich_shop/views/order_screen.dart';
import 'package:sandwich_shop/views/cart_screen.dart';
import 'package:sandwich_shop/views/sign_in_screen.dart';
import 'package:sandwich_shop/models/cart.dart';

/// AppShell provides a shared Drawer widget so screens don't need to duplicate
/// drawer code. This is an incremental refactor: screens keep their own
/// Scaffold for now but can reuse this Drawer until a full single-shell
/// refactor is applied.
class AppShell {
  /// Build a Drawer with top-level navigation items.
  static Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Row(
                children: [
                  SizedBox(
                    width: 56,
                    height: 56,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Sandwich Shop',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.restaurant_menu),
              title: const Text('Order'),
              onTap: () {
                Navigator.pop(context); // close drawer
                // If we're already on OrderScreen, just pop until root or do nothing.
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => OrderScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Cart'),
              onTap: () {
                Navigator.pop(context);
                // NOTE: we don't have a global cart yet. For now open an empty
                // CartScreen. In later subtasks we'll wire a shared cart.
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => CartScreen(cart: Cart()),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Sign In'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const SignInScreen(),
                  ),
                );
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),
      ),
    );
  }
}
