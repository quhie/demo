import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'bottom_sheet_controller.dart';
import 'custom_search_app_bar.dart';

class ManagementDisplay extends StatelessWidget {
  const ManagementDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AppBarController());

    final ScrollController _scrollController = ScrollController();
    double _lastScrollPosition = 0;
    DateTime _lastScrollTime = DateTime.now();

    void _onScroll() {
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (_scrollController.offset > _lastScrollPosition) {
          if (DateTime.now().difference(_lastScrollTime) > const Duration(milliseconds: 200)) {
            Get.find<AppBarController>().toggleExpanded(false);
          }
        }
      } else {
        Get.find<AppBarController>().toggleExpanded(true);
      }

      _lastScrollPosition = _scrollController.offset;
      _lastScrollTime = DateTime.now();
    }

    _scrollController.addListener(_onScroll);

    return Scaffold(
      body: GetBuilder<BottomSheetController>(
        init: BottomSheetController(),
        builder: (controller) => CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            const CustomSearchAppBar(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
                childCount: 50,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.find<BottomSheetController>().openBottomSheet();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}