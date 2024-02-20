import "package:carousel_slider/carousel_slider.dart";
import "package:crafty_bay/presentation/ui/utility/app_colors.dart";
import "package:flutter/material.dart";

class ProductDetailsImageCarousel extends StatefulWidget {
  const ProductDetailsImageCarousel({
    super.key,
    this.height,
    required this.urls,
  });
  final double? height;
  final List<String> urls;
  @override
  State<ProductDetailsImageCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<ProductDetailsImageCarousel> {
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          disableGesture: true,
          options: CarouselOptions(
            viewportFraction: 1,
            aspectRatio: 1.0,
            enlargeFactor: 0.3,
            autoPlay: false,
            height: widget.height ?? 200,
            onPageChanged: (index, reason) {
              _currentIndex.value = index;
            },
          ),
          items: widget.urls.map(
            (url) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.red,
                    ),
                    child: Image.network(
                      url,
                    ),
                  );
                },
              );
            },
          ).toList(),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: ValueListenableBuilder(
            valueListenable: _currentIndex,
            builder: (context, index, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < widget.urls.length; i++)
                    Container(
                      height: 14,
                      width: 14,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color:
                            i == index ? AppColors.primaryColor : Colors.white,
                        border: Border.all(
                            color: i == index
                                ? AppColors.primaryColor
                                : Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
