import 'package:flutter/material.dart';

class ColorList extends StatelessWidget {
  final int id;
  final bool showColors;
  final List<String> colors;
  final int selectedColorIndex;
  final void Function(int) onToggleColor;
  final Map<String, List<String>> imageUrls;
  final void Function(int, int) onSelectColorIndex;
  const ColorList({
    super.key,
    required this.id,
    required this.imageUrls,
    required this.colors,
    required this.selectedColorIndex,
    required this.onToggleColor,
    required this.onSelectColorIndex,
    required this.showColors,
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
              onToggleColor(id);
            },
            child: Row(
              children: [
                const Text(
                  "Colour:",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '  ${colors[selectedColorIndex]}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Flexible(flex: 1, child: Container()),
                showColors
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
          if (showColors)
            const SizedBox(
              height: 10,
            ),
          if (showColors)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 15,
                children: colors.asMap().entries.map((e) {
                  final index = e.key;
                  final color = e.value;
                  return InkWell(
                    onTap: () {
                      onSelectColorIndex(id, index);
                    },
                    child: SizedBox(
                      width: 160,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: selectedColorIndex == index
                                ? const Color.fromARGB(255, 213, 80, 70)
                                : const Color.fromARGB(255, 210, 210, 210),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                imageUrls[color]![0],
                                height: 150,
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
                              child: Text(
                                color,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
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
