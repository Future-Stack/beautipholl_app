import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/logging/logger.dart';
import '../data/models/profile_model_class.dart';

class CategoryController extends GetxController {
  final RxList<Data> categories = <Data>[].obs;
  final TextEditingController categoryController = TextEditingController();
  final String userId = 'user123';

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  @override
  void onClose() {
    categoryController.dispose();
    super.onClose();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://starrd-app.vercel.app/api/v1/categories/get-categories',
        ),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        final categoryData = GetCategory.fromJson(jsonData);
        categories.assignAll(categoryData.data ?? []);
      } else {
        AppLoggerHelper.error(
          'Failed to load categories: ${response.statusCode}',
        );
      }
    } catch (e) {
      AppLoggerHelper.error('Failed to load categories', e);
    }
  }

  void addCategory() {
    final name = categoryController.text.trim();
    if (name.isEmpty) return;

    categories.add(
      Data(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        categoryName: name,
        userId: userId,
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
      ),
    );
    categoryController.clear();
  }
}
