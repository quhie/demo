import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetController extends GetxController {
  RxString hostFilter = 'All'.obs;
  RxString statusFilter = 'All'.obs;

  final List<String> hosts = ['Host 1', 'Host 2', 'Host 3', 'All'];

  void openBottomSheet() {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Wrap(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bộ lọc sự kiện',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      hostFilter.value = 'All';
                      statusFilter.value = 'All';
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Đặt lại',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: const Text('Hồ tổ chức'),
              subtitle: Obx(() => Text('Selected: ${hostFilter.value}')),
              onTap: () {
                openHostSelectionBottomSheet();
              },
            ),
            ListTile(
              leading: Icon(Icons.group_work),
              title: const Text('Trạng thái'),
              subtitle: Obx(() => Text('Selected: ${hostFilter.value}')),
              onTap: () {
                openHostSelectionBottomSheet();
              },
            ),
          ],
        ),
      ),
    );
  }

  void openHostSelectionBottomSheet() {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: hosts
                .map((host) => ListTile(
              title: Text(host),
              onTap: () {
                hostFilter.value = host;
                Get.back();
              },
            ))
                .toList(),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
