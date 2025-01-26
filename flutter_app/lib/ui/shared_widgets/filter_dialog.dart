import 'package:flutter/material.dart';

class FilterDialog<T> extends StatefulWidget {
  const FilterDialog({
    required this.options,
    required this.onSelectItem,
    required this.onSubmit,
    super.key,
  });

  final Map<T, bool> options;
  final void Function(bool?, T) onSelectItem;
  final VoidCallback onSubmit;

  @override
  State<FilterDialog<T>> createState() => _FilterDialogState<T>();
}

class _FilterDialogState<T> extends State<FilterDialog<T>> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Filters'),
      children: <Widget>[
        ...List<Widget>.generate(widget.options.length, (int idx) {
          final T option = widget.options.keys.elementAt(idx);
          return CheckboxListTile.adaptive(
            title: Text(option.toString()),
            value: widget.options[option],
            onChanged: (bool? value) {
              setState(() {
                widget.onSelectItem(value, widget.options[idx] as T);
              });
            },
          );
        }),
        TextButton(
          onPressed: widget.onSubmit,
          child: const Text('Confirm choices'),
        ),
      ],
    );
  }
}
