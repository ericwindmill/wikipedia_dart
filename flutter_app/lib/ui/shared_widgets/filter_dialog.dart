import 'package:flutter/material.dart';

class FilterDialog<T> extends StatefulWidget {
  const FilterDialog({
    super.key,
    required this.options,
    required this.onSelectItem,
    required this.onSubmit,
  });

  final Map<T, bool> options;
  final void Function(bool?, T) onSelectItem;
  final VoidCallback onSubmit;

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Filters'),
      children: [
        ...List.generate(widget.options.length, (idx) {
          var option = widget.options.keys.elementAt(idx);
          return CheckboxListTile.adaptive(
            title: Text(option.toString()),
            value: widget.options[option],
            onChanged: (value) {
              setState(() {
                widget.onSelectItem(value, widget.options[idx]);
              });
            },
          );
        }),
        TextButton(onPressed: widget.onSubmit, child: Text('Confirm choices')),
      ],
    );
  }
}
