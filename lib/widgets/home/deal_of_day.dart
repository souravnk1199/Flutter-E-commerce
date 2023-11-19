import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_catalog_provider/providers/activescreen_provider.dart';
import 'package:tv_catalog_provider/screens/mobile_catalog_screen.dart';
import 'package:tv_catalog_provider/screens/tv_catalog_screen.dart';

class DealOfDay extends ConsumerWidget {
  const DealOfDay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    ref
                        .read(homeWidgetStackProvider.notifier)
                        .pushWidget(const MobileCatalog());
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(50, 0, 0, 0), width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Image.asset('assets/images/mobile_category.jpg'),
                        const Text(
                          'Mobile',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 30),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    ref
                        .read(homeWidgetStackProvider.notifier)
                        .pushWidget(const TvCatalog());
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(50, 0, 0, 0), width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Image.asset('assets/images/tv_category.jpg'),
                        const Text(
                          'Television',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15),
          child: const Text(
            'Deals of the Day',
            style: TextStyle(fontSize: 20),
          ),
        ),
        const SizedBox(height: 10),
        Image.network(
          'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Central/P3/CEPC/R01_Cepc_Desktop_CC_1x._SY304_CB575146312_.jpg',
          height: 250,
        )
      ],
    );
  }
}
