import 'package:flutter/material.dart';
import 'package:flutter_app/ui/shared_widgets/timeline/timeline.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

import 'package:flutter_app/ui/shared_widgets/filter_dialog.dart';
import 'package:flutter_app/features/on_this_day/timeline_view_model.dart';

class TimelineView extends StatelessWidget {
  const TimelineView({super.key, required this.viewModel});

  final TimelineViewModel viewModel;

  @override
  Widget build(BuildContext context) {
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

            return CustomScrollView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  // TODO: if collapsed, only show filter and date select
                  // (also todo, date select)
                  expandedHeight: 240,
                  collapsedHeight: 240,
                  flexibleSpace: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: sidebarWidth / 2,
                        child: CustomPaint(
                          painter: TimelinePainter(dotRadius: 0),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: IconButton(
                          icon: Icon(Icons.home_rounded),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: sidebarWidth,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Text(
                              'On This Day',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            SizedBox(height: 20),
                            Text(
                              viewModel.readableDate,
                              style: TextTheme.of(context).headlineMedium,
                            ),
                            Text(
                              '${viewModel.filteredEvents.length} historic events'
                                  .toUpperCase(),
                              style: TextTheme.of(context).titleMedium,
                            ),
                            if (viewModel.readableYearRange != '')
                              Text(
                                'from ${viewModel.readableYearRange}',
                                style: TextTheme.of(context).titleMedium,
                              ),
                            SizedBox(height: 20),
                            IconButton(
                              icon: Icon(Icons.filter_alt_outlined),
                              onPressed:
                                  () async => await showAdaptiveDialog(
                                    context: context,
                                    builder: (context) {
                                      return FilterDialog<EventType>(
                                        options:
                                            viewModel.selectEventTypes.value,
                                        onSelectItem: (
                                          bool? checked,
                                          EventType type,
                                        ) {
                                          viewModel.toggleSelectedType(
                                            type,
                                            checked ?? false,
                                          );
                                        },
                                        onSubmit: viewModel.filterEvents,
                                      );
                                    },
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SliverList.builder(
                  itemCount: viewModel.filteredEvents.length,
                  itemBuilder: (context, index) {
                    var event = viewModel.filteredEvents[index];
                    return TimelineListItem(event: event);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
