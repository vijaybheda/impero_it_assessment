import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:impero_it_assessment/core/constants/app_colors.dart';

class DesignStripController extends GetxController {
  final Map<int, TextEditingController> _controllers = {};
  final RxMap<int, Color> selectedColors = <int, Color>{}.obs;
  final RxMap<int, String> selectedValues = <int, String>{}.obs;

  @override
  void onClose() {
    // Dispose all controllers to prevent memory leaks
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();
    super.onClose();
  }

  TextEditingController getController(int index) {
    if (!_controllers.containsKey(index)) {
      _controllers[index] = TextEditingController(text: '0');
    }
    return _controllers[index]!;
  }

  Color getDefaultColor(int index) {
    switch (index) {
      case 0:
        return AppColors.hardnessColor1;
      case 1:
        return AppColors.chlorineColor1;
      case 2:
        return AppColors.freeChlorineColor1;
      case 3:
        return AppColors.pHColor1;
      case 4:
        return AppColors.alkalinityColor1;
      case 5:
        return AppColors.cyanuricColor1;
      default:
        return AppColors.primary;
    }
  }

  void selectColor(int index, Color color, String value) {
    selectedColors[index] = color;
    selectedValues[index] = value;
    getController(index).text = value;
  }

  void updateColorFromValue(int index, String value, List<Map<String, dynamic>> colors) {
    // Find the color that matches the input value
    for (final color in colors) {
      if (color['value'] == value) {
        selectedColors[index] = color['color'] as Color;
        break;
      }
    }
  }
}
