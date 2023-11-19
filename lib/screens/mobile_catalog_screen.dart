import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_catalog_provider/providers/activescreen_provider.dart';
import 'package:tv_catalog_provider/providers/mobiledata_provider.dart';
import 'package:tv_catalog_provider/providers/tvdata_provider.dart';
import 'package:tv_catalog_provider/screens/mobile_detail_screen.dart';
import 'package:tv_catalog_provider/widgets/catalogue/brandfilter_dialog.dart';
import 'package:tv_catalog_provider/widgets/catalogue/best_seller.dart';
import 'package:tv_catalog_provider/widgets/catalogue/buy_now_button.dart';
import 'package:tv_catalog_provider/widgets/catalogue/discounted_price.dart';
import 'package:tv_catalog_provider/widgets/catalogue/empty_filter.dart';
import 'package:tv_catalog_provider/widgets/catalogue/extra_information.dart';
import 'package:tv_catalog_provider/widgets/catalogue/item_name.dart';
import 'package:tv_catalog_provider/widgets/catalogue/rating_stars.dart';
import 'package:tv_catalog_provider/widgets/catalogue/special_offer.dart';
import 'package:tv_catalog_provider/widgets/delivery_address.dart';
import 'package:tv_catalog_provider/widgets/utils.dart';

class MobileCatalog extends ConsumerStatefulWidget {
  const MobileCatalog({super.key});

  @override
  ConsumerState<MobileCatalog> createState() => _MobileCatalogState();
}

class _MobileCatalogState extends ConsumerState<MobileCatalog> {
  @override
  Widget build(BuildContext context) {
    final originalData = ref.watch(mobileDataProvider);
    final filteredData = ref.watch(filteredMobileDataProvider);
    final selectedSizeFilter = ref.watch(selectedMobileSizeFilterProvider);
    final onPrimeFilter = ref.watch(onPrimeMobileFilterProvider);
    final selectedBrands = ref.watch(selectedMobileBrandsFilterProvider);
    final mobileBrands = ref.watch(mobileBrandsProvider);
    final mobileSizeList = ref.watch(mobileSizesFilterChoiceProvider);

    void onClear() {
      ref.read(searchProvider.notifier).state = '';
      ref.read(onPrimeMobileFilterProvider.notifier).state = false;
      ref.read(selectedMobileSizeFilterProvider.notifier).state = null;
      ref.read(selectedMobileBrandsFilterProvider.notifier).state = [];
    }

    void onClickOnPrime(bool value) {
      ref.read(onPrimeMobileFilterProvider.notifier).state = value;
    }

    void onSizeChoiceSelect(String? value) {
      ref.read(selectedMobileSizeFilterProvider.notifier).state = value;
    }

    void onApplyBrands(List<String> brands) {
      ref.read(selectedMobileBrandsFilterProvider.notifier).state = brands;
    }

    if (filteredData.isEmpty && originalData.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color.fromARGB(255, 35, 147, 135),
        ),
      );
    }

    return Column(
      children: [
        const DeliveryAddress(),
        Container(
          height: 55,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color.fromARGB(149, 158, 158, 158),
                width: 2,
              ),
            ),
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/prime.png',
                width: 55,
                height: 20,
                fit: BoxFit.fill,
              ),
              const SizedBox(width: 2),
              Switch(
                value: onPrimeFilter,
                activeColor: const Color.fromARGB(255, 14, 116, 77),
                inactiveTrackColor: Colors.white,
                onChanged: onClickOnPrime,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    children: mobileSizeList.map((e) {
                      return Container(
                        padding: const EdgeInsets.only(right: 5),
                        child: ChoiceChip(
                          label: Text(e),
                          selected: selectedSizeFilter == e,
                          onSelected: (bool selected) {
                            String? value = selected ? e : null;
                            onSizeChoiceSelect(value);
                          },
                          backgroundColor:
                              const Color.fromARGB(90, 213, 212, 212),
                          selectedColor:
                              const Color.fromARGB(255, 177, 241, 233),
                          side: const BorderSide(color: Colors.white),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const VerticalDivider(
                color: Colors.grey,
                thickness: 1,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return BrandFilterDialog(
                        brands: mobileBrands,
                        selectedBrands: [...selectedBrands],
                        onApply: onApplyBrands,
                      );
                    },
                  );
                },
                child: const Row(
                  children: [
                    Text(
                      "Brands",
                      style: TextStyle(color: Color.fromARGB(255, 4, 114, 126)),
                    ),
                    SizedBox(width: 3),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Color.fromARGB(255, 4, 114, 126),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        if (filteredData.isEmpty) EmptyFilter(onClear: onClear),
        if (filteredData.isNotEmpty)
          Expanded(
            child: ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (BuildContext context, int index) {
                final mobile = filteredData[index];
                return GestureDetector(
                  onTap: () {
                    ref
                        .read(homeWidgetStackProvider.notifier)
                        .pushWidget(MobileDetailScreen(mobileId: mobile.id));
                  },
                  child: Card(
                    child: Stack(
                      children: [
                        if (mobile.bestSeller)
                          /* ---------- BESTSELLER ---------- */
                          const BestSeller(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              /* ---------- IMAGE ---------- */
                              Image.network(
                                mobile.imageUrls[mobile.color[0]]![0],
                                width: 160.0,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ItemName(
                                      name: Utils.getMobileName(
                                        brand: mobile.brand,
                                        name: mobile.name,
                                        longName: mobile.longName,
                                        color: mobile.color[0],
                                        size: mobile.sizes[0],
                                      ),
                                    ),
                                    /* ----------------------- RATING ------------------------ */
                                    RatingStars(
                                      rating: mobile.rating,
                                      totalRating: mobile.totalRating,
                                      iconSize: 20,
                                    ),
                                    if (mobile.dealOfTheDay ||
                                        mobile.limitedTimeDeal)
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    if (mobile.dealOfTheDay)
                                      const SpecialOffer(
                                        text: 'Deal of the Day',
                                        size: 12,
                                      ),
                                    if (mobile.limitedTimeDeal)
                                      const SpecialOffer(
                                        text: 'Limited Time Deal',
                                        size: 12,
                                      ),
                                    if (mobile.dealOfTheDay ||
                                        mobile.limitedTimeDeal)
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    DiscountedPrice(
                                      price: mobile.price[0],
                                      discount: mobile.discount[0],
                                    ),
                                    ExtraInformation(
                                      offer: mobile.offers,
                                      onPrime: mobile.onPrime,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const BuyNow(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
