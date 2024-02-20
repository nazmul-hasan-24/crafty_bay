import "package:carousel_slider/carousel_slider.dart";
import "package:crafty_bay/data/models/banner_item.dart";
import "package:crafty_bay/presentation/ui/utility/app_colors.dart";
import "package:flutter/material.dart";

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({
    super.key,
    this.height,
    required this.bannerList,
  });
  final double? height;
  final List<BannerItem> bannerList;
  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CarouselSlider(
          disableGesture: true,
          options: CarouselOptions(
            viewportFraction: 1,
            autoPlay: false,
            height: widget.height ?? MediaQuery.of(context).size.height * 0.25,
            onPageChanged: (index, reason) {
              _currentIndex.value = index;
            },
          ),
          items: widget.bannerList.map(
            (banner) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    padding: EdgeInsets.zero,
                    height: 400,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        alignment: const Alignment(8, 10),
                        fit: BoxFit.fill,
                        filterQuality: FilterQuality.high,
                        image: NetworkImage(
                          banner.image ?? '',
                        ),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0)
                          .copyWith(right: 150, top: 7, bottom: 7, left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            banner.title ?? '',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            banner.shortDes ?? '',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ).toList(),
        ),
        ValueListenableBuilder(
          valueListenable: _currentIndex,
          builder: (context, index, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < widget.bannerList.length; i++)
                  Container(
                    height: 14,
                    width: 14,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: i == index ? AppColors.primaryColor : Colors.white,
                      border: Border.all(
                          color: i == index
                              ? AppColors.primaryColor
                              : Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )
              ],
            );
          },
        )
      ],
    );
  }
}
