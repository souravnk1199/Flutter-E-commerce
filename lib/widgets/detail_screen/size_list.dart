import 'package:flutter/material.dart';
import 'package:tv_catalog_provider/widgets/utils.dart';

class SizeList extends StatelessWidget {
  final int id;
  final bool isTv;
  final List<dynamic> sizes;
  final List<int> stocks;
  final List<double> prices;
  final int selectedIndex;
  final bool showSizes;
  final void Function(int) onToggleSize;
  final void Function(int, int) onSelectSizeIndex;
  const SizeList({
    super.key,
    required this.id,
    required this.isTv,
    required this.sizes,
    required this.stocks,
    required this.prices,
    required this.selectedIndex,
    required this.showSizes,
    required this.onToggleSize,
    required this.onSelectSizeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              onToggleSize(id);
            },
            child: Row(
              children: [
                const Text(
                  "Size:",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '  ${sizes[selectedIndex]}${isTv ? ' inches' : ''}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Flexible(flex: 1, child: Container()),
                showSizes
                    ? const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 30,
                      )
                    : const Icon(
                        Icons.keyboard_arrow_up_rounded,
                        size: 30,
                      ),
              ],
            ),
          ),
          if (showSizes)
            const SizedBox(
              height: 10,
            ),
          if (showSizes)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 15,
                children: sizes.asMap().entries.map((entry) {
                  final index = entry.key;
                  final size = entry.value;

                  return InkWell(
                    onTap: () {
                      onSelectSizeIndex(id, index);
                    },
                    child: SizedBox(
                      width: 150,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: selectedIndex == index
                                ? const Color.fromARGB(255, 213, 80, 70)
                                : const Color.fromARGB(255, 210, 210, 210),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                              child: Text(
                                '$size${isTv ? ' inches' : ''}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 1,
                              height: 2,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (stocks[index] != 0)
                                    Text(
                                      Utils.getFormattedNumber(
                                          prices[index].toInt()),
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  if (stocks[index] == 0)
                                    const SizedBox(
                                      height: 26,
                                    ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  if (stocks[index] != 0)
                                    Image.asset(
                                      'assets/prime.png',
                                      height: 12,
                                    ),
                                  if (stocks[index] == 0)
                                    const SizedBox(
                                      height: 12,
                                    ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Utils.getStockStatus(stocks[index],
                                      stocks[index] == 0 ? 16 : 14),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
