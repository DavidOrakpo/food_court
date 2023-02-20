import 'package:flutter/material.dart';
import 'package:food_court/presentation/styles/app_colors.dart';

class InfoDropDown extends StatefulWidget {
  const InfoDropDown(
      {Key? key,
      this.dropdownvalue,
      this.isExpanded = true,
      this.iconColor,
      this.hintText,
      this.height,
      this.borderColor,
      this.selectedItemBuilder,
      this.dropDownColor,
      this.hintColor,
      this.trailingWidget,
      this.items,
      required this.onChanged})
      : super(key: key);
  final String? dropdownvalue, hintText;
  final List<DropdownMenuItem<String>>? items;
  final bool? isExpanded;
  final Widget? trailingWidget;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;
  final Color? iconColor, borderColor, hintColor, dropDownColor;
  final void Function(String?)? onChanged;
  final double? height;
  @override
  State<InfoDropDown> createState() => _InfoDropDownState();
}

class _InfoDropDownState extends State<InfoDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 45,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: widget.borderColor ?? AppColors.gray,
        ),
      ),
      child: DropdownButton(
          value: widget.dropdownvalue,
          dropdownColor: widget.dropDownColor,
          focusColor: Colors.transparent,
          icon: widget.trailingWidget ?? const Icon(Icons.arrow_drop_down),
          hint: Text(
            widget.hintText ?? "Select",
            style: TextStyle(color: widget.hintColor ?? AppColors.gray),
          ),
          iconEnabledColor: widget.iconColor ?? AppColors.primaryGradient2,
          isExpanded: widget.isExpanded ?? true,
          underline: const SizedBox(),
          selectedItemBuilder: widget.selectedItemBuilder,
          style: const TextStyle(color: AppColors.white),
          items: widget.items ??
              const [
                DropdownMenuItem(
                  value: "Lagos",
                  child: Text("Lagos"),
                ),
              ],
          onChanged: widget.onChanged ?? (value) {}),
    );
  }
}
