import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSearchAppBar extends StatelessWidget {
  const CustomSearchAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBarController = Get.find<AppBarController>();
    final ScrollController _scrollController = ScrollController();

    // Callback function to handle scroll events
    void _onScroll() {
      double scrollOffset = _scrollController.hasClients ? _scrollController.offset : 0.0;

      // Calculate scroll percentage
      double scrollPercentage = scrollOffset / (200 - kToolbarHeight);
      bool isFullyCollapsed = scrollPercentage <= 0.0;

      // Update appbar state based on scroll position
      appBarController.toggleExpanded(!isFullyCollapsed);
    }

    _scrollController.addListener(_onScroll);

    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 10,
      floating: true,
      pinned: true,
      expandedHeight: 200,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double scrollPercentage =
              (constraints.biggest.height - kToolbarHeight) / (200 - kToolbarHeight);
          bool isFullyCollapsed = scrollPercentage <= 0.0;

          appBarController.toggleExpanded(!isFullyCollapsed);

          double width = 303 - (-40 * scrollPercentage);

          return AnimatedContainer(
            duration: Duration(milliseconds: 100),
            height: constraints.biggest.height,
            decoration: BoxDecoration(
              color: isFullyCollapsed ? Colors.transparent : Colors.green,
              image: isFullyCollapsed
                  ? DecorationImage(
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.cover,
              )
                  : null,
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 55,
                  left: 0,
                  right: 0,
                  child: Obx(
                        () => Visibility(
                      visible: appBarController.isFullyExpanded.value && !isFullyCollapsed,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios_new_outlined),
                              color: Colors.white,
                              onPressed: () {
                                // Handle back action
                              },
                            ),
                            const Text(
                              'Management Display',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (!isFullyCollapsed)
                              IconButton(
                                icon: const Icon(Icons.filter_alt_outlined),
                                color: Colors.white,
                                onPressed: () {
                                  // Handle more action
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: constraints.biggest.height - 55,
                  left: (MediaQuery.of(context).size.width - width) / 1.3,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    width: width.clamp(303, 343),
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: appBarController.isFullyCollapsed.value
                          ? Color(0x80D0D5DD)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search...",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        contentPadding: EdgeInsets.zero,
                        suffixIcon: appBarController.isFullyCollapsed.value
                            ? null
                            : IconButton(
                          icon: const Icon(Icons.filter_alt_outlined),
                          onPressed: () {
                            // Handle clear action
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class AppBarController {
  final isFullyCollapsed = false.obs;
  final isFullyExpanded = true.obs;

  void toggleExpanded(bool value) {
    isFullyCollapsed.value = !value;
    isFullyExpanded.value = value;
  }
}
