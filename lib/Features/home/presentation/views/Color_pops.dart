import 'package:flutter/material.dart';
import 'package:to_do/constants.dart';

class ColorItem extends StatelessWidget {
  const ColorItem({super.key, required this.isActive, required this.color});
  final bool isActive;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: isActive
          ? CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 22,
                backgroundColor: color,
              ),
            )
          : CircleAvatar(
              radius: 24,
              backgroundColor: color,
            ),
    );
  }
}

class ColorsListView extends StatefulWidget {
  const ColorsListView({
    super.key,
    required this.onColorChanged,
  });

  final ValueChanged<Color> onColorChanged;

  @override
  State<ColorsListView> createState() => _ColorsListViewState();
}

class _ColorsListViewState extends State<ColorsListView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Kcolors.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onColorChanged(Kcolors[index]);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: CircleAvatar(
                radius: selectedIndex == index ? 24 : 22,
                backgroundColor: Kcolors[index],
                child: selectedIndex == index
                    ? const Icon(Icons.check, color: Colors.white)
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
}
