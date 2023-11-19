import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_catalog_provider/widgets/delivery_address.dart';
import 'package:tv_catalog_provider/widgets/home/carousel_images.dart';
import 'package:tv_catalog_provider/widgets/home/deal_of_day.dart';
import 'package:tv_catalog_provider/widgets/home/top_categories.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          DeliveryAddress(),
          SizedBox(height: 10),
          TopCategories(),
          SizedBox(height: 10),
          CarouselImage(),
          DealOfDay(),
        ],
      ),
    );
  }
}
