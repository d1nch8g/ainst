import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:installer/constants.dart';

class FleuDropdown extends StatefulWidget {
  final String label;
  final List<String> items;
  final void Function(String) onChanged;
  const FleuDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    required this.label,
  });

  @override
  State<FleuDropdown> createState() => _FleuDropdownState();
}

class _FleuDropdownState extends State<FleuDropdown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            hint: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.items[0],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: widget.items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value as String;
              });
              widget.onChanged(value!);
            },
            buttonStyleData: ButtonStyleData(
              height: 50,
              width: 160,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.black26,
                ),
                color: primaryColor,
              ),
              elevation: 2,
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              iconSize: 14,
              iconEnabledColor: Colors.white,
              iconDisabledColor: primaryColor,
            ),
            dropdownStyleData: DropdownStyleData(
                maxHeight: 200,
                width: 200,
                padding: null,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: primaryColor,
                ),
                elevation: 8,
                offset: const Offset(-20, 0),
                scrollbarTheme: ScrollbarThemeData(
                  radius: const Radius.circular(40),
                  thickness: MaterialStateProperty.all(6),
                  thumbVisibility: MaterialStateProperty.all(true),
                )),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
          ),
        ),
      ],
    );
  }
}
