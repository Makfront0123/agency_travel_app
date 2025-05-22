import 'package:flutter/material.dart';

class DropdownItem extends StatelessWidget {
  const DropdownItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      height: 50, // Alto del dropdown
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(.3)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          dropdownColor: Colors.white,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          value: 'All',
          onChanged: (value) {},
          items: const [
            DropdownMenuItem(
              value: 'All',
              child: Text('From'),
            ),
            DropdownMenuItem(
              value: 'One',
              child: Text('One'),
            ),
            DropdownMenuItem(
              value: 'Two',
              child: Text('Two'),
            ),
            DropdownMenuItem(
              value: 'Three',
              child: Text('Three'),
            ),
          ],
        ),
      ),
    );
  }
}
