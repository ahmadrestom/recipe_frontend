import 'package:flutter/material.dart';

class TimeItem extends StatefulWidget {
  final String time;
  final String selectTime;
  final Function(String) onTimeSelected;

  const TimeItem({
    Key? key,
    required this.time,
    required this.selectTime,
    required this.onTimeSelected,
  }) : super(key: key);

  @override
  State<TimeItem> createState() => _TimeItemState();
}

class _TimeItemState extends State<TimeItem> {
  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.time == widget.selectTime;

    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: isSelected ? const Color.fromRGBO(18, 149, 117, 1) : const Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: const Color.fromRGBO(113, 177, 161, 1)),
      ),
      child: GestureDetector(
        onTap: () {
          if (!isSelected) {
            widget.onTimeSelected(widget.time);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            widget.time,
            style: TextStyle(
              color: isSelected ? const Color.fromRGBO(255, 255, 255, 1):const Color.fromRGBO(113, 177, 161, 1),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
