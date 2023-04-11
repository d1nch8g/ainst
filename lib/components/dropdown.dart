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
  var controller = TextEditingController();

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
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Select Item',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
            items: widget.items
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
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
              height: 40,
              width: 240,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: primaryColor),
              ),
              overlayColor: const MaterialStatePropertyAll(secondaryColor),
            ),
            dropdownStyleData: const DropdownStyleData(
              maxHeight: 260,
              decoration: BoxDecoration(
                color: backgroundColor,
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              overlayColor: MaterialStatePropertyAll(secondaryColor),
            ),
            dropdownSearchData: DropdownSearchData(
              searchController: controller,
              searchInnerWidgetHeight: 50,
              searchInnerWidget: Container(
                height: 50,
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  right: 8,
                  left: 8,
                ),
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  autofocus: true,
                  controller: controller,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    focusColor: primaryColor,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: 'Search for an item...',
                    hintStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                return (item.value.toString().contains(searchValue));
              },
            ),
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                controller.clear();
              }
            },
          ),
        ),
      ],
    );
  }
}

class FleuBaseDropdown extends StatefulWidget {
  final String label;
  final List<String> items;
  final void Function(String) onChanged;
  const FleuBaseDropdown({
    super.key,
    required this.items,
    required this.label,
    required this.onChanged,
  });

  @override
  State<FleuBaseDropdown> createState() => _FleuBaseDropdownState();
}

class _FleuBaseDropdownState extends State<FleuBaseDropdown> {
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
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Select item',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
            items: widget.items
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
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
              height: 40,
              width: 240,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: primaryColor),
              ),
              overlayColor: const MaterialStatePropertyAll(secondaryColor),
            ),
            dropdownStyleData: const DropdownStyleData(
              maxHeight: 260,
              decoration: BoxDecoration(
                color: backgroundColor,
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              overlayColor: MaterialStatePropertyAll(secondaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
