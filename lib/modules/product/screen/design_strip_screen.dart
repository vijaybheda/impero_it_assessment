import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:impero_it_assessment/core/constants/app_colors.dart';
import 'package:impero_it_assessment/core/constants/app_strings.dart';
import 'package:impero_it_assessment/modules/product/provider/design_strip_controller.dart';
import 'package:impero_it_assessment/modules/product/screen/home_screen.dart';

class DesignStripScreen extends StatelessWidget {
  const DesignStripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DesignStripController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          AppStrings.testStrip,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.text,
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: ElevatedButton(
              onPressed: () {
                Get.offAll(() => HomeScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.textTertiary,
                foregroundColor: AppColors.textSecondary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
              ),
              child: Text(AppStrings.next, style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          // Left vertical color bar
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
            width: 40,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.textTertiary, width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: List.generate(6, (index) {
                return Expanded(
                  child: Obx(() {
                    final color =
                        controller.selectedColors[index] ?? controller.getDefaultColor(index);
                    return Center(
                      child: Container(
                        width: 35,
                        height: 30,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  }),
                );
              }),
            ),
          ),

          // Right side content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildParameterRow(
                  parameterName: AppStrings.totalHardness,
                  unit: AppStrings.ppm,
                  colors: [
                    {'color': AppColors.hardnessColor1, 'value': '0'},
                    {'color': AppColors.hardnessColor2, 'value': '110'},
                    {'color': AppColors.hardnessColor3, 'value': '250'},
                    {'color': AppColors.hardnessColor4, 'value': '500'},
                    {'color': AppColors.hardnessColor5, 'value': '1000'},
                  ],
                  index: 0,
                  controller: controller,
                ),
                const SizedBox(height: 24),
                _buildParameterRow(
                  parameterName: AppStrings.totalChlorine,
                  unit: AppStrings.ppm,
                  colors: [
                    {'color': AppColors.chlorineColor1, 'value': '0'},
                    {'color': AppColors.chlorineColor2, 'value': '1'},
                    {'color': AppColors.chlorineColor3, 'value': '3'},
                    {'color': AppColors.chlorineColor4, 'value': '5'},
                    {'color': AppColors.chlorineColor5, 'value': '10'},
                  ],
                  index: 1,
                  controller: controller,
                ),
                const SizedBox(height: 24),
                _buildParameterRow(
                  parameterName: AppStrings.freeChlorine,
                  unit: AppStrings.ppm,
                  colors: [
                    {'color': AppColors.freeChlorineColor1, 'value': '0'},
                    {'color': AppColors.freeChlorineColor2, 'value': '1'},
                    {'color': AppColors.freeChlorineColor3, 'value': '3'},
                    {'color': AppColors.freeChlorineColor4, 'value': '5'},
                    {'color': AppColors.freeChlorineColor5, 'value': '10'},
                  ],
                  index: 2,
                  controller: controller,
                ),
                const SizedBox(height: 24),
                _buildParameterRow(
                  parameterName: AppStrings.pH,
                  unit: AppStrings.ppm,
                  colors: [
                    {'color': AppColors.pHColor1, 'value': '6.2'},
                    {'color': AppColors.pHColor2, 'value': '6.8'},
                    {'color': AppColors.pHColor3, 'value': '7.2'},
                    {'color': AppColors.pHColor4, 'value': '7.8'},
                    {'color': AppColors.pHColor5, 'value': '8.4'},
                  ],
                  index: 3,
                  controller: controller,
                ),
                const SizedBox(height: 24),
                _buildParameterRow(
                  parameterName: AppStrings.totalAlkalinity,
                  unit: AppStrings.ppm,
                  colors: [
                    {'color': AppColors.alkalinityColor1, 'value': '0'},
                    {'color': AppColors.alkalinityColor2, 'value': '40'},
                    {'color': AppColors.alkalinityColor3, 'value': '120'},
                    {'color': AppColors.alkalinityColor4, 'value': '180'},
                    {'color': AppColors.alkalinityColor5, 'value': '240'},
                  ],
                  index: 4,
                  controller: controller,
                ),
                const SizedBox(height: 24),
                _buildParameterRow(
                  parameterName: AppStrings.cyanuricAcid,
                  unit: AppStrings.ppm,
                  colors: [
                    {'color': AppColors.cyanuricColor1, 'value': '0'},
                    {'color': AppColors.cyanuricColor2, 'value': '50'},
                    {'color': AppColors.cyanuricColor3, 'value': '100'},
                    {'color': AppColors.cyanuricColor4, 'value': '150'},
                    {'color': AppColors.cyanuricColor5, 'value': '300'},
                  ],
                  index: 5,
                  controller: controller,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParameterRow({
    required String parameterName,
    required String unit,
    required List<Map<String, dynamic>> colors,
    required int index,
    required DesignStripController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Parameter name and input field
        Row(
          children: [
            Expanded(
              child: Text(
                '$parameterName ($unit)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            Container(
              width: 80,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.textTertiary),
              ),
              child: TextField(
                controller: controller.getController(index),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  LengthLimitingTextInputFormatter(10), // Limit input length
                ],
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  // Validate input before processing
                  if (value.isEmpty) return;
                  
                  // Check if value is a valid number
                  final double? numericValue = double.tryParse(value);
                  if (numericValue == null) return;
                  
                  // Limit to reasonable range (0-10000)
                  if (numericValue < 0 || numericValue > 10000) return;
                  
                  controller.updateColorFromValue(index, value, colors);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Horizontal color swatches
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:
              colors.asMap().entries.map((entry) {
                final color = entry.value;

                return Obx(() {
                  final isSelected = controller.selectedColors[index] == color['color'];

                  return GestureDetector(
                    onTap: () {
                      controller.selectColor(
                        index,
                        color['color'] as Color,
                        color['value'] as String,
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 40,
                          height: 30,
                          decoration: BoxDecoration(
                            color: color['color'] as Color,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: isSelected ? AppColors.primary : AppColors.textTertiary,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child:
                              isSelected
                                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                                  : null,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          color['value'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  );
                });
              }).toList(),
        ),
      ],
    );
  }
}
