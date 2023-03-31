import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter_initicon/flutter_initicon.dart';

import '../common/functions.dart';
import '../providers/auth.dart';

class ModalColor extends StatefulWidget {
  final WidgetRef ref;
  const ModalColor({super.key, required this.ref});

  @override
  ModalColorState createState() => ModalColorState();
}

class ModalColorState extends State<ModalColor> {
  static Color red = profileColors[0].bgColor;
  static Color orange = profileColors[1].bgColor;
  static Color yellow = profileColors[2].bgColor;
  static Color blue = profileColors[3].bgColor;
  static Color teal = profileColors[4].bgColor;
  static Color green = profileColors[5].bgColor;
  static Color deepblue = profileColors[6].bgColor;
  static Color purple = profileColors[7].bgColor;
  static Color pink = profileColors[8].bgColor;

  final Map<ColorSwatch<Object>, String> colorsNameMap =
    <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(red): 'Base Red',
    ColorTools.createPrimarySwatch(orange): 'Base Orange',
    ColorTools.createPrimarySwatch(yellow): 'Base Yellow',
    ColorTools.createPrimarySwatch(blue): 'Base Blue',
    ColorTools.createPrimarySwatch(teal): 'Base Teal',
    ColorTools.createPrimarySwatch(green): 'Blue Green',
    ColorTools.createPrimarySwatch(deepblue): 'Base Blue Dark',
    ColorTools.createPrimarySwatch(purple): 'Base Purple',
    ColorTools.createPrimarySwatch(pink): 'Base Pink',
  };

  @override
  void initState() {
    widget.ref.read(authProvider).resetColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        int lastColor = widget.ref.watch(authProvider).newUserData.color;
        if (!(await colorPickerDialog(widget.ref))) {
          widget.ref.read(authProvider).changeUserColor(lastColor);
        }
      },
      child: Initicon(
        text: widget.ref.watch(authProvider).userData.name,
        size: 72,
        backgroundColor: getProfileBgColor(widget.ref.watch(authProvider).newUserData.color),
        style: TextStyle(
          color: getProfileTextColor(widget.ref.watch(authProvider).newUserData.color)
        ),
      ),
    );
  }

  Future<bool> colorPickerDialog(WidgetRef ref) async {
    return ColorPicker(
      crossAxisAlignment: CrossAxisAlignment.center,
      color: getProfileBgColor(ref.watch(authProvider).newUserData.color),
      onColorChanged: (Color color) {
        var colorCode = getProfileColorCode(color);
        ref.read(authProvider).changeUserColor(colorCode);
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
