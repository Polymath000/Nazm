import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class Priority extends StatefulWidget {
  const Priority({super.key, required this.onPrioritySelected});
  final Function(String) onPrioritySelected;

  @override
  State<Priority> createState() => _PriorityState();
}

class _PriorityState extends State<Priority> {
  Color color = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Icon(
          Icons.flag_outlined,
          color: color,
        ),
        items: [
          ...MenuItems.firstItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
        ],
        onChanged: (value) {
          setState(() {
            widget.onPrioritySelected(value!.text);

            color = MenuItems.onChanged(context, value);
          });
        },
        dropdownStyleData: DropdownStyleData(
          width: 160,
          direction: DropdownDirection.left,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.black,
          ),
          offset: const Offset(0, 8),
        ),
        menuItemStyleData: MenuItemStyleData(
          customHeights: List<double>.filled(MenuItems.firstItems.length, 48),
          padding: const EdgeInsets.only(left: 16, right: 16),
        ),
      ),
    );
  }
}

class MenuItem {
  const MenuItem({required this.text, required this.icon, required this.color});
  final Color color;
  final String text;
  final IconData icon;
}

class MenuItems {
  static const List<MenuItem> firstItems = [no, low, meduim, high];

  static const high = MenuItem(
      text: 'High Priority', icon: Icons.flag_outlined, color: Colors.red);
  static const meduim = MenuItem(
      text: 'Meduim Priority', icon: Icons.flag_outlined, color: Colors.yellow);
  static const low = MenuItem(
      text: 'Low Priority', icon: Icons.flag_outlined, color: Colors.blue);
  static const no = MenuItem(
      text: 'No Priority', icon: Icons.flag_outlined, color: Colors.grey);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(
          item.icon,
          size: 22,
          color: item.color,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: TextStyle(color: item.color),
          ),
        ),
      ],
    );
  }

  static Color onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.high:
        return Colors.red;
      case MenuItems.meduim:
        return Colors.yellow;
      case MenuItems.low:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
