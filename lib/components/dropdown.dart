import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:installer/constants.dart';

class SearchDropdown extends StatefulWidget {
  final String label;
  final List<String> items;
  final void Function(String) onChanged;
  const SearchDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    required this.label,
  });

  @override
  State<SearchDropdown> createState() => _SearchDropdownState();
}

class _SearchDropdownState extends State<SearchDropdown> {
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
                'Выберите элемент',
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
                    hintText: 'Поиск по значениям...',
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
                return (item.value
                    .toString()
                    .toLowerCase()
                    .contains(searchValue.toLowerCase()));
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

class BaseDropdown extends StatefulWidget {
  final String label;
  final List<String> items;
  final void Function(String) onChanged;
  const BaseDropdown({
    super.key,
    required this.items,
    required this.label,
    required this.onChanged,
  });

  @override
  State<BaseDropdown> createState() => _BaseDropdownState();
}

class _BaseDropdownState extends State<BaseDropdown> {
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
                'Выберите элемент',
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
