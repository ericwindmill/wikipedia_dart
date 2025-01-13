import 'package:flutter/material.dart';
import 'package:flutter_client/features/on_this_day/view_model.dart';

import 'widgets/list_item.dart';

const double sidebarWidthPercentage = .15;
const double mainColumnWidthPercentage = .85;

class OnThisDayView extends StatelessWidget {
  const OnThisDayView({super.key, required this.viewModel});

  final OnThisDayViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    var leftPad = MediaQuery.of(context).size.width * sidebarWidthPercentage;

    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            if (viewModel.hasError) {
              return Center(child: Text(viewModel.error!));
            }
            if (!viewModel.hasData && !viewModel.hasError) {
              return Center(child: CircularProgressIndicator.adaptive());
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.only(left: leftPad),
                  child: Text(
                    'On This Day',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: leftPad),
                  child: Text(
                    viewModel.readableDate,
                    style: TextTheme.of(context).titleLarge,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: leftPad),
                  child: Text(
                    '${viewModel.events.length} historic events'.toUpperCase(),
                    style: TextTheme.of(context).titleSmall,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: leftPad),
                  child: Text(
                    'from ${viewModel.readableYearRange}',
                    style: TextTheme.of(context).titleSmall,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.filter_alt_outlined),
                        onPressed:
                            () async => await showAdaptiveDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Filters'),
                                  content: Column(
                                    children: [
                                      CheckboxListTile.adaptive(
                                        title: Text('Featured'),
                                        value: false,
                                        onChanged: (value) => print(''),
                                      ),
                                      CheckboxListTile.adaptive(
                                        title: Text('Birthdays'),
                                        value: false,
                                        onChanged: (value) => print(''),
                                      ),
                                      CheckboxListTile.adaptive(
                                        title: Text('Notable Deaths'),
                                        value: false,
                                        onChanged: (value) => print(''),
                                      ),
                                      CheckboxListTile.adaptive(
                                        title: Text('Holidays'),
                                        value: false,
                                        onChanged: (value) => print(''),
                                      ),
                                      CheckboxListTile.adaptive(
                                        title: Text('Events'),
                                        value: false,
                                        onChanged: (value) => print(''),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed:
                                          () => Navigator.of(context).pop(),
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed:
                                          () => Navigator.of(context).pop(),
                                      child: Text('Save'),
                                    ),
                                  ],
                                );
                              },
                            ),
                      ),
                      IconButton(
                        icon: Icon(Icons.sort),
                        onPressed: () => print(''),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.events.length,
                    itemBuilder: (context, index) {
                      var event = viewModel.events[index];
                      return TimelineListItem(event: event);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
