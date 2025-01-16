import 'package:flutter/material.dart';

import '../view_model.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key, required this.viewModel});

  final OnThisDayViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return SimpleDialog(
          title: Text('Filters'),
          children: [
            ...List.generate(viewModel.selectEventTypes.value.length, (idx) {
              var eventType = viewModel.selectEventTypes.value.keys.elementAt(
                idx,
              );
              return CheckboxListTile.adaptive(
                title: Text(eventType.name),
                value: viewModel.selectEventTypes.value[eventType],
                onChanged:
                    (value) => viewModel.toggleSelectedType(eventType, value!),
              );
            }),
            TextButton(
              onPressed: () {
                viewModel.filterEvents();
                Navigator.of(context).pop();
              },
              child: Text('Confirm choices'),
            ),
          ],
        );
      },
    );
  }
}
