import 'package:flutter/material.dart';
import '/services/checkout_facade.dart';
import '/services/cart_service.dart';
import '/services/checkout_service.dart';
import '/services/local_storage.dart';
import '/services/order_history_cache.dart';
import '/services/payment_gateway.dart';
import '/services/products_service.dart';
import '/services/theme_service.dart';

void main() {
  final cartService = CartServiceImpl();
  final checkoutService = CheckoutServiceImpl();
  final localStorage = HiveBox();

  runApp(
    FanniShopApp(
      ThemeServiceImpl(),
      cartService,
      OrderHistoryCacheImpl(),
      ProductsServiceImpl(),
      CheckoutFacadeImpl(cartService, checkoutService, localStorage),
    ),
  );
}

class FanniShopApp extends StatefulWidget {
  const FanniShopApp(
    this._themeService,
    this._cartService,
    this._orderHistoryCache,
    this._productsService,
    this._checkoutFacade, {
    super.key,
  });
  final ThemeService _themeService;
  final CartService _cartService;
  final OrderHistoryCache _orderHistoryCache;
  final ProductsService _productsService;
  final CheckoutFacade _checkoutFacade;
  @override
  State<FanniShopApp> createState() => _FanniShopAppState();
}

class _FanniShopAppState extends State<FanniShopApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: widget._themeService.isDarkTheme
          ? ThemeData.dark()
          : ThemeData.light(),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Fanni Store - متجر فني"),
            actions: [
              IconButton(
                icon: Icon(
                  widget._themeService.isDarkTheme
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
                onPressed: () {
                  setState(() => widget._themeService.toggle());
                },
              ),
            ],
          ),
          body: Column(
            children: [
              // Catalog List View
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Available Maintenance Tools",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget._productsService.products.length,
                  itemBuilder: (context, index) {
                    final item = widget._productsService.products[index];
                    return ListTile(
                      title: Text(item.name),
                      subtitle: Text("${item.priceEgp} EGP (${item.category})"),
                      trailing: ElevatedButton(
                        onPressed: () {
                          setState(() => widget._cartService.addItem(item));
                        },
                        child: const Text("Add"),
                      ),
                    );
                  },
                ),
              ),
              const Divider(thickness: 2),

              // Cart and Controls Panel
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      "Items in Cart: ${widget._cartService.itemsLength} | Total: ${widget._cartService.totalCartPrice} EGP",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade400,
                          ),
                          onPressed: widget._cartService.isEmpty
                              ? null
                              : () {
                                  widget._checkoutFacade.checkout(
                                    VodafoneCashGateway('01029393920'),
                                  );
                                  setState(() {});
                                },
                          child: const Text(
                            "Pay Vodafone Cash",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade400,
                          ),
                          onPressed: widget._cartService.isEmpty
                              ? null
                              : () {
                                  widget._checkoutFacade.checkout(
                                    InstapayGateway('01029393920'),
                                  );
                                  setState(() {});
                                },
                          child: const Text(
                            "Pay InstaPay",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Local Cache Log Readout Panel
              if (!widget._orderHistoryCache.isEmpty) ...[
                const Divider(),
                const Text("Local Cached Sync History Log:"),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget._orderHistoryCache.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: const Icon(Icons.dns, color: Colors.grey),
                      title: Text(
                        widget._orderHistoryCache.localOrderHistoryCache[index],
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
