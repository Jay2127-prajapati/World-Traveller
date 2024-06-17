import 'dart:async';

import 'package:flutter/material.dart';
import 'package:world_traveller/colors/colors.dart';

class ImageSliderWidget extends StatefulWidget {
  final List<String> imagePaths;

  const ImageSliderWidget({Key? key, required this.imagePaths})
      : super(key: key);

  @override
  State<ImageSliderWidget> createState() => _ImageSliderWidgetState();
}

class _ImageSliderWidgetState extends State<ImageSliderWidget> {
  late List<Widget> _pages;
  int _activePage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pages = List.generate(
      widget.imagePaths.length,
      (index) => ImagePlaceHolder(imagePath: widget.imagePaths[index]),
    );
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.page == widget.imagePaths.length - 1) {
        _pageController.animateToPage(0,
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      } else {
        _pageController.nextPage(
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 4,
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.imagePaths.length,
                onPageChanged: (value) {
                  setState(() {
                    _activePage = value;
                  });
                },
                itemBuilder: (context, index) {
                  return _pages[index % _pages.length];
                },
              ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                    _pages.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: InkWell(
                        onTap: () {
                          _pageController.animateToPage(index,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                        child: CircleAvatar(
                          radius: 4,
                          backgroundColor: _activePage == index
                              ? primaryColorGrass
                              : secondaryColorWhite,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class ImagePlaceHolder extends StatelessWidget {
  final String imagePath;

  const ImagePlaceHolder({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
    );
  }
}
