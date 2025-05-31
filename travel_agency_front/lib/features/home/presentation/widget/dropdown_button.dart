import 'package:flutter/material.dart';

class DropdownItem extends StatelessWidget {
  final String title;
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?>? onChanged;

  const DropdownItem({
    super.key,
    required this.title,
    required this.items,
    this.selectedItem,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(.3)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(title),
          value: selectedItem,
          onChanged: onChanged,
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
