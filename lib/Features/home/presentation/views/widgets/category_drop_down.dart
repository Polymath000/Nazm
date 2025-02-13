import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CategoryDropDown extends StatefulWidget {
  CategoryDropDown({
    super.key,
    required this.onCategorySelected,
  });
  final Function(String) onCategorySelected;

  @override
  State<CategoryDropDown> createState() => _CategoryDropDownState();
}

class _CategoryDropDownState extends State<CategoryDropDown> {
  MenuItem? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Icon(Icons.category_rounded),
        items: [
          ...MenuItems.firstItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
          DropdownMenuItem<MenuItem>(
            value: null,
            child: MenuItems.addCategory(),
          ),
        ],
        value: selectedValue,
        onChanged: (value) {
          if (value == null) {
            _handleAddCategory();
          } else {
            setState(() {
              selectedValue = value as MenuItem?;
              widget.onCategorySelected(value.text);
            });
          }
        },
        dropdownStyleData: DropdownStyleData(
          width: 170,
          direction: DropdownDirection.left,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.black,
          ),
          offset: const Offset(0, 8),
        ),
        menuItemStyleData: MenuItemStyleData(
          customHeights: List<double>.filled(
            MenuItems.firstItems.length + 1, // Include "Add category"
            48,
          ),
          padding: const EdgeInsets.only(left: 16, right: 16),
        ),
      ),
    );
  }

  void _handleAddCategory() {
    showDialog(
      context: context,
      builder: (context) {
        Color selectedColor = Colors.green;
        TextEditingController controller = TextEditingController();

        return AlertDialog(
          title: const Text('Add New Category'),
          scrollable: true,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Prevents infinite height
              children: [
                TextField(
                  controller: controller,
                  decoration:
                      const InputDecoration(hintText: 'Enter category name'),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  setState(() {
                    MenuItems.firstItems.add(
                      MenuItem(
                        text: controller.text,
                        color: selectedColor,
                      ),
                    );
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class MenuItem {
  const MenuItem({required this.text, required this.color});
  final Color color;
  final String text;
}

class MenuItems {
  static List<MenuItem> firstItems = [study, work, family];

  static const study = MenuItem(text: 'Personal', color: Colors.red);
  static const work = MenuItem(text: 'Work', color: Colors.yellow);
  static const family = MenuItem(text: 'Family', color: Colors.blue);

  static Widget addCategory() {
    return Row(
      children: [
        Icon(Icons.playlist_add, color: Colors.white),
        SizedBox(width: 10),
        Text(
          'Add category',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Text(
          item.text,
          style: TextStyle(color: item.color),
        ),
      ],
    );
  }
}
