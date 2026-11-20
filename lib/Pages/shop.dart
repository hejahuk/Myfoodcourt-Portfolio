import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_court/features/screens/product_details/product_details.dart';
import 'package:food_court/features/controller/cart_controller.dart';
import 'package:food_court/features/screens/cart_screen/cart_screen.dart';

class Shopping extends StatefulWidget {
  const Shopping({super.key});

  @override
  State<Shopping> createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  // //////////////////////////// <State & Data> ////////////////////////////

  // Controls the pull-up panel (DraggableScrollableSheet) below — lets us
  // resize it manually when the user drags the handle, and animate it open
  // automatically when a search starts.
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();

  // Holds the text typed into the search bar and the current search term
  // (lower-cased, for case-insensitive matching).
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // How much of the screen the pull-up panel takes up: just the handle bar
  // at rest, 95% when dragged open. The panel snaps between these two values.
  static const double _collapsedSize = 0.08;
  static const double _expandedSize = 0.95;

  // The tabs/content only render once the panel is dragged past this size —
  // below it there isn't enough room for them and they'd overflow.
  static const double _contentRevealThreshold =
      (_collapsedSize + _expandedSize) / 2;

  // Placeholder stall data grouped by category, shown as swipeable tabs in
  // the pull-up panel. In a real app this would come from a database/API.
  // Each stall also carries the info needed to open ProductDetails when
  // tapped: dishTitle/price/image are the same data home.dart's product
  // grid uses, so tapping a stall opens the exact same screen Home does.
  final Map<String, List<Map<String, String>>> categorizedStalls = const {
    "Rice": [
      {
        "name": "Chicken rice stall",
        "products": "256 products",
        "dishTitle": "Chicken Rice",
        "category": "Rice",
        "price": "\$4.50",
        "image":
            "assets/img/chicken_rice_logo.png",
      },
    ],
    "Noodles": [
      {
        "name": "Noodle Express",
        "products": "120 products",
        "dishTitle": "Noodles King",
        "category": "Noodles",
        "price": "\$6.50",
        "image":
            "assets/img/seafood_noddle.png",
      },
    ],
    "Drinks": [
      {
        "name": "Beverage Stall",
        "products": "80 products",
        "dishTitle": "Iced Tea",
        "category": "Drinks",
        "price": "\$1.50",
        "image":
            "assets/img/coffee.png",
      },
    ],
    "Desserts": [
      {
        "name": "Wrap Stall",
        "products": "64 products",
        "dishTitle": "Wrap",
        "category": "Desserts",
        "price": "\$4.00",
        "image":
            "assets/img/wrap.png",
      },
    ],
  };

  // Opens the same ProductDetails screen the Home page's product cards use.
  void _openProductDetails(Map<String, String> stall) {
    Get.to(
      () => ProductDetails(
        title: stall["dishTitle"]!,
        category: stall["category"]!,
        price: stall["price"]!,
        imageUrl: stall["image"]!,
      ),
    );
  }

  @override
  void dispose() {
    _sheetController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // //////////////////////////// <Search Feature> ////////////////////////////

  // Runs on every keystroke in the search bar: saves the query and, once the
  // user has typed something, expands the pull-up panel so the results are
  // visible straight away.
  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value.trim().toLowerCase();
    });
    if (_searchQuery.isNotEmpty && _sheetController.isAttached) {
      _sheetController.animateTo(
        _expandedSize,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
  }

  // Flattens every category into one list and keeps only the stalls whose
  // name contains the search text. Powers the search-results view below.
  List<Map<String, String>> get _searchResults {
    return categorizedStalls.values
        .expand((stalls) => stalls)
        .where((stall) => stall["name"]!.toLowerCase().contains(_searchQuery))
        .toList();
  }

  // //////////////////////// <Pull-Up Panel Drag Handle> ////////////////////////

  // Called while the user is dragging the grey handle bar: converts the
  // finger's vertical movement into a new panel size (as a fraction of
  // screen height) and applies it immediately.
  void _onHandleDragUpdate(DragUpdateDetails details) {
    if (!_sheetController.isAttached) return;
    final screenHeight = MediaQuery.of(context).size.height;
    final newSize = _sheetController.size - details.delta.dy / screenHeight;
    _sheetController.jumpTo(newSize.clamp(_collapsedSize, _expandedSize));
  }

  // Called when the user lets go of the handle: snaps the panel to whichever
  // of the two sizes (collapsed/expanded) it's closer to, animated smoothly.
  void _onHandleDragEnd(DragEndDetails details) {
    if (!_sheetController.isAttached) return;
    final target = _sheetController.size > (_collapsedSize + _expandedSize) / 2
        ? _expandedSize
        : _collapsedSize;
    _sheetController.animateTo(
      target,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  // //////////////////////////// <View All Pop-up> ////////////////////////////

  // Opens a modal bottom sheet listing every stall from every category,
  // triggered by tapping "View all" next to the Featured Stalls heading.
  void _showAllFeaturedStores() {
    final allStalls = categorizedStalls.values
        .expand((stalls) => stalls)
        .toList();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const Text(
                  "All Featured Stores",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: allStalls.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 24),
                    itemBuilder: (context, index) {
                      final stall = allStalls[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          _openProductDetails(stall);
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(stall["image"]!),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        stall["name"]!,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const Icon(
                                        Icons.circle,
                                        size: 8,
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    stall["products"]!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // //////////////////////////// <Search Results Widget> ////////////////////////////

  // Shows the filtered search results as a list, or a "no stalls found"
  // message if nothing matches. Swapped in below the panel's drag handle
  // whenever there's an active search query.
  Widget _buildSearchResults() {
    final results = _searchResults;
    if (results.isEmpty) {
      return Center(
        child: Text(
          'No stalls found for "$_searchQuery"',
          style: TextStyle(color: Colors.grey.shade600),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: results.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) => _StallCard(stall: results[index]),
    );
  }

  // //////////////////////////// <Build Method> ////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // //////////////////////////// <AppBar> ////////////////////////////
      // TOP APP BAR: page title + cart icon with item-count badge.
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text("Store", style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  onPressed: () => Get.to(() => const CartScreen()),
                  icon: const Icon(Icons.shopping_cart, color: Colors.black),
                ),
                // Hides completely when the cart is empty, otherwise shows
                // the real item count — same pattern as the Home page's
                // AppBar (lib/appBar/appBar.dart).
                Obx(() {
                  final itemCount = CartController.instance.cartItems.length;
                  if (itemCount == 0) return const SizedBox.shrink();
                  return Positioned(
                    right: 4,
                    top: 8,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Text(
                          itemCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),

      // //////////////////////////// <Body> ////////////////////////////

      // The body is a Stack so the pull-up panel can float on top of the
      // search bar / featured stalls content and slide up to cover it.
      body: Stack(
        children: [
          // BACKGROUND LAYER: search bar + Featured Stalls section.
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                // //////////////////////////// <Search Bar> ////////////////////////////
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.grey),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: _onSearchChanged,
                            decoration: const InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: "Search in Store",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // //////////////////////////// <Featured Stalls> ////////////////////////////
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Featured Stalls",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: _showAllFeaturedStores,
                        child: const Text("View all"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // One card per stall across every category: Chicken rice
                // stall, Noodle Express, Beverage Stall, and Wrap Stall.
                ...categorizedStalls.values.expand((stalls) => stalls).map((
                  stall,
                ) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      bottom: 8,
                    ),
                    child: GestureDetector(
                      onTap: () => _openProductDetails(stall),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 22,
                              backgroundImage: AssetImage(stall["image"]!),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      stall["name"]!,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.circle,
                                      size: 8,
                                      color: Colors.blue,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  stall["products"]!,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                // Spacer so the page can still scroll a little behind the sheet.
                const SizedBox(height: 400),
              ],
            ),
          ),

          // //////////////////////////// <Pull-Up Panel> ////////////////////////////

          // FOREGROUND LAYER: the pull-up panel. Snaps between _collapsedSize
          // and _expandedSize, and contains the category tabs / search results.
          DraggableScrollableSheet(
            controller: _sheetController,
            initialChildSize: _collapsedSize,
            minChildSize: _collapsedSize,
            maxChildSize: _expandedSize,
            snap: true,
            snapSizes: const [_collapsedSize, _expandedSize],
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // DraggableScrollableController.isAttached only turns true once a
                    // real Scrollable is using this scrollController, otherwise our
                    // handle's jumpTo/animateTo calls below silently no-op. This dummy
                    // scrollable exists only to satisfy that — it's never touched.
                    IgnorePointer(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        physics: const NeverScrollableScrollPhysics(),
                        child: const SizedBox(height: 1),
                      ),
                    ),
                    DefaultTabController(
                      length: categorizedStalls.length,
                      child: Column(
                        children: [
                          // Drag handle bar — this is what the user grabs to
                          // resize the panel (see _onHandleDragUpdate/End above).
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onVerticalDragUpdate: _onHandleDragUpdate,
                            onVerticalDragEnd: _onHandleDragEnd,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: Center(
                                child: Container(
                                  width: 48,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // The tabs/content only show once the panel is
                          // dragged past _contentRevealThreshold — below that
                          // there isn't room for them and they'd overflow.
                          Expanded(
                            child: AnimatedBuilder(
                              animation: _sheetController,
                              builder: (context, child) {
                                final isOpen =
                                    _sheetController.isAttached &&
                                    _sheetController.size >
                                        _contentRevealThreshold;
                                if (!isOpen) {
                                  return const SizedBox.shrink();
                                }
                                // No active search: show the category tabs
                                // (swipe left/right between Rice/Noodles/
                                // Drinks/Desserts). While searching, show the
                                // filtered results list instead.
                                if (_searchQuery.isEmpty) {
                                  return Column(
                                    children: [
                                      TabBar(
                                        isScrollable: true,
                                        labelColor: Colors.black,
                                        unselectedLabelColor: Colors.grey,
                                        indicatorColor: Colors.red,
                                        tabs: categorizedStalls.keys
                                            .map(
                                              (category) => Tab(text: category),
                                            )
                                            .toList(),
                                      ),
                                      Expanded(
                                        child: TabBarView(
                                          children: categorizedStalls.values
                                              .map((stalls) {
                                                return ListView.separated(
                                                  padding: const EdgeInsets.all(
                                                    16,
                                                  ),
                                                  itemCount: stalls.length,
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          const SizedBox(
                                                            height: 12,
                                                          ),
                                                  itemBuilder:
                                                      (context, index) {
                                                        return _StallCard(
                                                          stall: stalls[index],
                                                        );
                                                      },
                                                );
                                              })
                                              .toList(),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return _buildSearchResults();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// //////////////////////////// <Stall Card Widget> ////////////////////////////

// One stall's card: avatar, name, verified dot, product count, and a row of
// placeholder thumbnails. Reused in both the category tabs and search results.
class _StallCard extends StatelessWidget {
  const _StallCard({required this.stall});

  final Map<String, String> stall;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
        () => ProductDetails(
          title: stall["dishTitle"]!,
          category: stall["category"]!,
          price: stall["price"]!,
          imageUrl: stall["image"]!,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(stall["image"]!),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          stall["name"]!,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.circle, size: 8, color: Colors.blue),
                      ],
                    ),
                    Text(
                      stall["products"]!,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: List.generate(3, (index) {
                return Padding(
                  padding: EdgeInsets.only(right: index < 2 ? 8 : 0),
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.fastfood, color: Colors.grey.shade400),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
