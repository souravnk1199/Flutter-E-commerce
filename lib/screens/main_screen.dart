import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_catalog_provider/providers/activescreen_provider.dart';
import 'package:tv_catalog_provider/providers/tvdata_provider.dart';
import 'package:tv_catalog_provider/screens/cart_screen.dart';
import 'package:tv_catalog_provider/screens/tv_catalog_screen.dart';
import 'package:tv_catalog_provider/screens/home_screen.dart';

class MainSscreen extends ConsumerStatefulWidget {
  const MainSscreen({super.key});

  @override
  ConsumerState<MainSscreen> createState() => _MainSscreenState();
}

class _MainSscreenState extends ConsumerState<MainSscreen> {
  late Widget activeScreen;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    activeScreen = const TvCatalog();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigationBarIndex = ref.watch(navigationBarProvider);
    final homeWidgetStack = ref.watch(homeWidgetStackProvider);
    final cartWidgetStack = ref.watch(cartWidgetStackProvider);
    if (navigationBarIndex == 0) {
      if (homeWidgetStack.isNotEmpty) {
        activeScreen = homeWidgetStack.last;
      } else {
        activeScreen = const HomeScreen();
      }
    } else if (navigationBarIndex == 3) {
      if (cartWidgetStack.isNotEmpty) {
        activeScreen = cartWidgetStack.last;
      } else {
        activeScreen = const CartScreen();
      }
    }

    final searchProviderState = ref.watch(searchProvider);
    searchController.text = searchProviderState;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 22, 231, 234),
                  Color.fromARGB(255, 108, 231, 219),
                  Color.fromARGB(255, 109, 223, 175)
                ],
              ),
            ),
          ),
          title: Row(
            children: [
              (homeWidgetStack.isNotEmpty && navigationBarIndex == 0) ||
                      (cartWidgetStack.isNotEmpty && navigationBarIndex == 3)
                  ? Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: IconButton(
                        onPressed: () {
                          if (navigationBarIndex == 0) {
                            ref
                                .read(homeWidgetStackProvider.notifier)
                                .popWidget();
                          } else if (navigationBarIndex == 3) {
                            ref
                                .read(cartWidgetStackProvider.notifier)
                                .popWidget();
                          }
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                    )
                  : Container(),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 1),
                        blurRadius: 4.0,
                        spreadRadius: 0.5,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: (value) {
                                  ref.read(searchProvider.notifier).state =
                                      value;
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Search televisions...',
                                  border: InputBorder.none,
                                ),
                                controller: searchController,
                              ),
                            ),
                            if (searchProviderState.isNotEmpty)
                              IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  ref.read(searchProvider.notifier).state = '';
                                },
                              ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.photo_camera_outlined),
                        onPressed: () {},
                        color: Colors.grey.shade600,
                      ),
                      IconButton(
                        icon: const Icon(Icons.mic_none_outlined),
                        onPressed: () {},
                        color: Colors.grey.shade600,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // leading: const Icon(Icons.arrow_back),
        ),
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 10, 128, 102),
        unselectedItemColor: Colors.black,
        currentIndex: navigationBarIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'You',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.layers_outlined),
            label: 'More',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
        onTap: (value) {
          ref.read(navigationBarProvider.notifier).state = value;
        },
      ),
    );
  }
}
