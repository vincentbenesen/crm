import 'package:crm/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomCheckBox extends StatefulWidget {
  CustomCheckBox(
      {super.key,
      required this.label,
      required this.padding,
      required this.optionsToAdd,
      required this.isRatings,
      this.rating,
      this.ratingsToAdd});

  final String label;
  final EdgeInsets padding;
  final List<String> optionsToAdd;
  final bool isRatings;
  final double? rating;
  final List<double>? ratingsToAdd;

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
                    if (widget.isRatings) {
                      widget.ratingsToAdd!.add(widget.rating!.toDouble());
                      print("Added");
                      print(widget.ratingsToAdd);
                    } else {
                      widget.optionsToAdd.add(widget.label);
                      print("Added");
                      print(widget.optionsToAdd);
                    }
                  } else {
                    value = newValue!;
                    widget.optionsToAdd.remove(widget.label);
                    print("Removed");
                    print(widget.optionsToAdd);
                  }
                });
              },
            ),
            widget.isRatings
                ? Expanded(
                    child: RatingBar.builder(
                    initialRating: widget.rating!.toDouble(),
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 20,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: kColorStar,
                    ),
                    ignoreGestures: true,
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ))
                : Expanded(
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
