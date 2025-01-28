import 'package:flutter/material.dart';
import 'package:flutter_app/features/on_this_day/timeline_view_model.dart';
import 'package:flutter_app/ui/app_localization.dart';
import 'package:flutter_app/ui/shared_widgets/filter_dialog.dart';
import 'package:flutter_app/ui/shared_widgets/timeline/timeline.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class TimelineView extends StatelessWidget {
  const TimelineView({required this.viewModel, super.key});

  final TimelineViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (BuildContext context, _) {
            if (viewModel.hasError) {
              return Center(child: Text(viewModel.error!));
            }
            if (!viewModel.hasData && !viewModel.hasError) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            return CustomScrollView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  // TODO(ewindmill): if collapsed, only show filter
                  //  and date select
                  expandedHeight: 240,
                  collapsedHeight: 240,
                  flexibleSpace: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        bottom: 10,
                        left: sidebarWidth / 2,
                        child: CustomPaint(
                          painter: TimelineCapPainter(height: 10),
                        ),
                      ),
                      Positioned(
                        top: 10,
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
                          icon: const Icon(Icons.home_rounded),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 50,
                        child: IconButton(
                          icon: const Icon(Icons.filter_alt_outlined),
                          onPressed:
                              () async => showAdaptiveDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return FilterDialog<EventType>(
                                    options: viewModel.selectEventTypes.value,
                                    onSelectItem:
                                        ({
                                          required EventType value,
                                          bool? isChecked,
                                        }) => viewModel.toggleSelectedType(
                                          isChecked: isChecked ?? false,
                                          type: value,
                                        ),
                                    onSubmit: viewModel.filterEvents,
                                  );
                                },
                              ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: sidebarWidth,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 20),
                            Text(
                              AppStrings.onThisDay,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              viewModel.readableDate,
                              style: TextTheme.of(context).headlineMedium,
                            ),
                            Text(
                              AppStrings.historicEvents(
                                viewModel.filteredEvents.length.toString(),
                              ).toUpperCase(),
                              style: TextTheme.of(context).titleMedium,
                            ),
                            if (viewModel.readableYearRange != '')
                              Text(
                                AppStrings.yearRange(
                                  viewModel.readableYearRange,
                                ),
                                style: TextTheme.of(context).titleMedium,
                              ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SliverList.builder(
                  itemCount: viewModel.filteredEvents.length,
                  itemBuilder: (BuildContext context, int index) {
                    final OnThisDayEvent event =
                        viewModel.filteredEvents[index];
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
