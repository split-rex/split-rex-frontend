import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter_initicon/flutter_initicon.dart';

import '../providers/auth.dart';

class ModalColor extends StatefulWidget {
  final WidgetRef ref;
  const ModalColor({super.key, required this.ref});

  @override
  ColorPickerDemoState createState() => ColorPickerDemoState();
}

class ColorPickerDemoState extends State<ModalColor> {
  late Color dialogPickerColor = yellow;
  static const Color red = Color(0xFFFFD4D4);
  static const Color purple = Color(0xFFF3E0FF);
  static const Color yellow = Color(0xFFFFEEC1);
  static const Color blue = Color(0xFFC1E9FF);
  static const Color green = Color(0xFFD3FFFC);
  static const Color pink = Color(0xFFFFE0F8);
  static const Color orange = Color(0xFFFDE4DA);

  final Map<ColorSwatch<Object>, String> colorsNameMap =
    <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(red): 'Base Red',
    ColorTools.createPrimarySwatch(purple): 'Base Purple',
    ColorTools.createPrimarySwatch(yellow): 'Base Yellow',
    ColorTools.createPrimarySwatch(blue): 'Base Blue',
    ColorTools.createPrimarySwatch(green): 'Blue Green',
    ColorTools.createPrimarySwatch(pink): 'Base Pink',
    ColorTools.createPrimarySwatch(orange): 'Blue Orange',
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Store current color before we open the dialog.
        final Color colorBeforeDialog = dialogPickerColor;
        // Wait for the picker to close, if dialog was dismissed,
        // then restore the color we had before it was opened.
        if (!(await colorPickerDialog(widget.ref))) {
          setState(() {
            dialogPickerColor = colorBeforeDialog;
          });
        }
      },
      child: Initicon(
        text: widget.ref.watch(authProvider).userData.name,
        size: 72,
      ),
    );
  }

  Future<bool> colorPickerDialog(WidgetRef ref) async {
    return ColorPicker(
      crossAxisAlignment: CrossAxisAlignment.center,
      color: dialogPickerColor,
      onColorChanged: (Color color) {
          setState(() => dialogPickerColor = color);
      },
      width: 65,
      height: 65,
      borderRadius: 48,
      spacing: 10,
      runSpacing: 10,
      enableShadesSelection: false,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      showColorName: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: false,
        ColorPickerType.accent: false,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: false,
      },
      customColorSwatchesAndNames: colorsNameMap,
    ).showPickerDialog(
      context,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      constraints:
          const BoxConstraints(minHeight: 160, minWidth: 300, maxWidth: 320),
    );
  }
}
