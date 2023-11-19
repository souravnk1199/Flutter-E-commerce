import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_catalog_provider/providers/activescreen_provider.dart';
import 'package:tv_catalog_provider/providers/tvdata_provider.dart';
import 'package:tv_catalog_provider/screens/tv_detail_screen.dart';
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

class TvCatalog extends ConsumerStatefulWidget {
  const TvCatalog({
    super.key,
  });

  @override
  ConsumerState<TvCatalog> createState() => _TvCatalogState();
}

class _TvCatalogState extends ConsumerState<TvCatalog> {
  @override
  Widget build(BuildContext context) {
    final originalData = ref.watch(tvDataProvider);
    final filteredData = ref.watch(filteredTvdataProvider);
    final selectedSizeFilter = ref.watch(selectedTvSizeFilterProvider);
    final onPrimeFilter = ref.watch(onPrimeTvFilterProvider);
    final selectedBrands = ref.watch(selectedTvBrandsFilterProvider);
    final tvBrands = ref.watch(tvBrandsProvider);

    void onClear() {
      ref.read(searchProvider.notifier).state = '';
      ref.read(onPrimeTvFilterProvider.notifier).state = false;
      ref.read(selectedTvSizeFilterProvider.notifier).state = null;
      ref.read(selectedTvBrandsFilterProvider.notifier).state = [];
    }

    void onClickOnPrime(bool value) {
      ref.read(onPrimeTvFilterProvider.notifier).state = value;
    }

    void onSizeChoiceSelect(int? value) {
      ref.read(selectedTvSizeFilterProvider.notifier).state = value;
    }

    void onApplyBrands(List<String> brands) {
      ref.read(selectedTvBrandsFilterProvider.notifier).state = brands;
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
                onChanged: onClickOnPrime,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: choiceList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(right: 5),
                      child: ChoiceChip(
                        label: Text(choiceList[index]),
                        selected: selectedSizeFilter == index,
                        onSelected: (bool selected) {
                          int? value = selected ? index : null;
                          onSizeChoiceSelect(value);
                        },
                        backgroundColor:
                            const Color.fromARGB(90, 213, 212, 212),
                        selectedColor: const Color.fromARGB(255, 177, 241, 233),
                        side: const BorderSide(color: Colors.white),
                      ),
                    );
                  },
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
                        brands: tvBrands,
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
                final tv = filteredData[index];
                return GestureDetector(
                  onTap: () {
                    ref
                        .read(homeWidgetStackProvider.notifier)
                        .pushWidget(TVDetailScreen(tvId: tv.id));
                  },
                  child: Card(
                    child: Stack(
                      children: [
                        if (tv.bestSeller)
                          /* ---------- BESTSELLER ---------- */
                          const BestSeller(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              /* ---------- IMAGE ---------- */
                              Image.network(
                                tv.imageUrls[0],
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
                                    ItemName(name: tv.name),
                                    /* ----------------------- RATING ------------------------ */
                                    RatingStars(
                                      rating: tv.rating,
                                      totalRating: tv.totalRating,
                                      iconSize: 20,
                                    ),
                                    if (tv.dealOfTheDay || tv.limitedTimeDeal)
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    if (tv.dealOfTheDay)
                                      const SpecialOffer(
                                        text: 'Deal of the Day',
                                        size: 12,
                                      ),
                                    if (tv.limitedTimeDeal)
                                      const SpecialOffer(
                                        text: 'Limited Time Deal',
                                        size: 12,
                                      ),
                                    if (tv.dealOfTheDay || tv.limitedTimeDeal)
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    DiscountedPrice(
                                      price: tv.price[0],
                                      discount: tv.discount[0],
                                    ),
                                    ExtraInformation(
                                        offer: tv.offers, onPrime: tv.onPrime),
                                    const SizedBox(height: 5),
                                    Utils.getSizeList(tv.sizes),
                                    const SizedBox(height: 5),
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
