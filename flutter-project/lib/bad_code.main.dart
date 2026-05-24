import 'package:flutter/material.dart';

// Concrete Data Model used directly everywhere
class ShopItem {
  final String id;
  final String name;
  final double priceEgp;
  final String category; // 'PowerTool', 'HandTool', 'Safety'

  ShopItem({
    required this.id,
    required this.name,
    required this.priceEgp,
    required this.category,
  });
}

void main() {
  runApp(const MonolithicFanniShopApp());
}

class MonolithicFanniShopApp extends StatefulWidget {
  const MonolithicFanniShopApp({super.key});

  @override
  State<MonolithicFanniShopApp> createState() => _MonolithicFanniShopAppState();
}

class _MonolithicFanniShopAppState extends State<MonolithicFanniShopApp> {
  // --- VIOLATION: MONOLITHIC STATE BLENDING (SRP Violation) ---
  // This single state class manages UI theme, shopping cart, shop items database,
  // checkout orchestration, and local historical log persistence simultaneously.

  bool _isDarkTheme = false;
  final List<ShopItem> _cart = [];
  final List<String> _localOrderHistoryCache = [];

  final List<ShopItem> _catalog = [
    ShopItem(
      id: "PT_01",
      name: "Bosch Professional Drill",
      priceEgp: 4500.0,
      category: "PowerTool",
    ),
    ShopItem(
      id: "HT_02",
      name: "Stanley Socket Wrench Set",
      priceEgp: 1800.0,
      category: "HandTool",
    ),
    ShopItem(
      id: "ST_03",
      name: "3M Heavy Duty Safety Glasses",
      priceEgp: 450.0,
      category: "Safety",
    ),
  ];

  // --- VIOLATION: OCP & LSP & DIP CRASH LOOPS ---
  void executeCheckout(String walletProvider, double totalAmount) {
    print("Initializing checkout logic inside state manager...");

    // Hardcoded Low-Level Dependency Instantiation (Violates DIP)
    final walletProcessor = VodafoneCashGateway();

    // Brittle string matching rules controlling critical flow (Violates OCP)
    if (walletProvider == 'VodafoneCash') {
      walletProcessor.payWithVodafoneWallet("01012345678", totalAmount);
    } else if (walletProvider == 'InstaPay') {
      // Violates LSP: Changing execution path violently or throwing unexpected crashes
      // when a specific subtype path is selected in a generic pipeline.
      throw UnsupportedError(
        "InstaPay gateway sync parameters missing! App crashed.",
      );
    }

    // Hardcoded Local Cache persistence call (Violates DIP)
    final localStorage = MockHiveBox();
    localStorage.writeToDisk(
      "ORDER_${DateTime.now().millisecondsSinceEpoch}",
      "Total: $totalAmount EGP",
    );

    setState(() {
      _localOrderHistoryCache.add(
        "Order of $totalAmount EGP processed via $walletProvider",
      );
      _cart.clear();
    });
  }

  // --- VIOLATION: INTERFACE SEGREGATION (ISP Violation) ---
  // Forcing the UI context to possess low-level configuration utility triggers
  void rotateSecurityKeys() {
    print("Rotating localized cryptographic DB security blocks...");
  }

  @override
  Widget build(BuildContext context) {
    double totalCartPrice = _cart.fold(0, (sum, item) => sum + item.priceEgp);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Fanni Store - متجر فني"),
          actions: [
            IconButton(
              icon: Icon(_isDarkTheme ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                setState(() {
                  _isDarkTheme = !_isDarkTheme;
                });
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
                itemCount: _catalog.length,
                itemBuilder: (context, index) {
                  final item = _catalog[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text("${item.priceEgp} EGP (${item.category})"),
                    trailing: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _cart.add(item);
                        });
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
                    "Items in Cart: ${_cart.length} | Total: $totalCartPrice EGP",
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
                        onPressed: _cart.isEmpty
                            ? null
                            : () => executeCheckout(
                                "VodafoneCash",
                                totalCartPrice,
                              ),
                        child: const Text(
                          "Pay Vodafone Cash",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade400,
                        ),
                        onPressed: _cart.isEmpty
                            ? null
                            : () => executeCheckout("InstaPay", totalCartPrice),
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
            if (_localOrderHistoryCache.isNotEmpty) ...[
              const Divider(),
              const Text("Local Cached Sync History Log:"),
              Expanded(
                child: ListView.builder(
                  itemCount: _localOrderHistoryCache.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: const Icon(Icons.dns, color: Colors.grey),
                    title: Text(
                      _localOrderHistoryCache[index],
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Low-Level Detail 1: Concrete Wallet Engine
class VodafoneCashGateway {
  void payWithVodafoneWallet(String walletNumber, double cashAmount) {
    print(
      "SUCCESS: Deducted $cashAmount EGP from wallet connection path $walletNumber",
    );
  }
}

// Low-Level Detail 2: Concrete Hardware Storage Driver
class MockHiveBox {
  void writeToDisk(String key, String numericalValue) {
    print(
      "CACHE HIT: Securely wrote block index [$key] to smartphone flash chip.",
    );
  }
}
