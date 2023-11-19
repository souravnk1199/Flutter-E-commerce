import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex = 0;

  const ImageCarousel({super.key, required this.imageUrls});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            itemCount: widget.imageUrls.length,
            controller: PageController(initialPage: currentIndex),
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.network(widget.imageUrls[index]);
            },
          ),
          // Navigation Circles
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.imageUrls.map((url) {
              int index = widget.imageUrls.indexOf(url);
              return Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index == currentIndex
                      ? const Color.fromARGB(255, 8, 141, 96)
                      : const Color.fromARGB(255, 143, 139, 139),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
