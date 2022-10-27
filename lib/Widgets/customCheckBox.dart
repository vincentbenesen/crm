import 'package:crm/constant.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  CustomCheckBox(
      {super.key,
      required this.label,
      required this.padding,
      required this.optionsToAdd});

  final String label;
  final EdgeInsets padding;
  final List<String> optionsToAdd;

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: widget.padding,
        child: Row(
          children: <Widget>[
            Checkbox(
              value: value,
              checkColor: Colors.white,
              onChanged: (bool? newValue) {
                setState(() {
                  if (!value) {
                    value = newValue!;
                    widget.optionsToAdd.add(widget.label);
                    print("Added");
                    print(widget.optionsToAdd);
                  } else {
                    value = newValue!;
                    widget.optionsToAdd.remove(widget.label);
                    print("Removed");
                    print(widget.optionsToAdd);
                  }
                });
              },
            ),
            Expanded(
                child: Text(
              widget.label,
              style: kLeadFilterCityChoices,
            )),
          ],
        ),
      ),
    );
  }
}
