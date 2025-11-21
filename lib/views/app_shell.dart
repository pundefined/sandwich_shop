import 'package:flutter/material.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/views/order_screen.dart';
import 'package:sandwich_shop/views/cart_screen.dart';
import 'package:sandwich_shop/views/sign_in_screen.dart';

/// Build the application's Drawer used across screens.
Drawer buildAppDrawer(BuildContext context) {
  // Provide an explicit width to avoid overflow with large content
  // and to ensure consistent layout across platforms and tests.
  return Drawer(
    width: 320,
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
                const Expanded(
                  child: Text(
                    'Sandwich Shop',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.restaurant_menu),
            title: const Text('Order'),
            onTap: () {
              Navigator.pop(context); // close drawer
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const OrderScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Cart'),
            onTap: () {
              Navigator.pop(context);
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

/// A small reusable Scaffold wrapper used across the app to avoid
/// duplicating common Scaffold configuration (AppBar, Drawer, FAB, etc.).
///
/// Usage:
/// SharedScaffold(
///   title: 'Order',
///   body: OrderScreen(),
/// )
class SharedScaffold extends StatelessWidget {
  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;
  final bool extendBodyBehindAppBar;
  final bool showDrawer;

  const SharedScaffold({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.appBar,
    this.extendBodyBehindAppBar = false,
    this.showDrawer = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar ??
          (title != null
              ? AppBar(
                  title: Text(title!),
                  actions: actions,
                )
              : null),
      drawer: showDrawer ? buildAppDrawer(context) : null,
      body: SafeArea(
        child: body,
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
    );
  }
}
