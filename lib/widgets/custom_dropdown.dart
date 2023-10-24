import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({
    super.key,
    this.initialOption,
    this.hintText,
    required this.options,
    required this.onChanged,
    this.icon,
    this.width,
    this.height,
    this.fillColor,
    required this.textStyle,
    required this.elevation,
    required this.borderWidth,
    required this.borderRadius,
    required this.borderColor,
    required this.margin,
    this.hidesUnderline = false,
  });

  final String? initialOption;
  final String? hintText;
  final List<String> options;
  final Function(String?) onChanged;
  final Widget? icon;
  final double? width;
  final double? height;
  final Color? fillColor;
  final TextStyle textStyle;
  final double elevation;
  final double borderWidth;
  final double borderRadius;
  final Color borderColor;
  final EdgeInsetsGeometry margin;
  final bool hidesUnderline;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? dropDownValue;

  List<String> get effectiveOptions =>
      widget.options.isEmpty ? ['[Option]'] : widget.options;

  @override
  void initState() {
    super.initState();
    dropDownValue = widget.initialOption;
  }

  @override
  Widget build(BuildContext context) {
    final dropdownWidget = DropdownButton<String>(
      value: effectiveOptions.contains(dropDownValue) ? dropDownValue : null,
      hint: widget.hintText != null
          ? Text(widget.hintText!, style: widget.textStyle)
          : null,
      items: effectiveOptions
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e,
                style: widget.textStyle,
              ),
            ),
          )
          .toList(),
      elevation: widget.elevation.toInt(),
      onChanged: (value) {
        dropDownValue = value;
        widget.onChanged(value);
      },
      icon: widget.icon,
      isExpanded: true,
      dropdownColor: widget.fillColor,
      focusColor: Colors.transparent,
    );
    final childWidget = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: widget.borderColor,
          width: widget.borderWidth,
        ),
        color: widget.fillColor,
      ),
      child: Padding(
        padding: widget.margin,
        child: widget.hidesUnderline
            ? DropdownButtonHideUnderline(child: dropdownWidget)
            : dropdownWidget,
      ),
    );
    if (widget.height != null || widget.width != null) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: childWidget,
      );
    }
    return childWidget;
  }
}
