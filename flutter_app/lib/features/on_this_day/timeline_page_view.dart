import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/on_this_day/timeline_view_model.dart';
import 'package:flutter_app/ui/app_localization.dart';
import 'package:flutter_app/ui/build_context_util.dart';
import 'package:flutter_app/ui/shared_widgets/filter_dialog.dart';
import 'package:flutter_app/ui/shared_widgets/timeline/timeline.dart';
import 'package:flutter_app/ui/theme/theme.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class TimelinePageView extends StatelessWidget {
  const TimelinePageView({required this.viewModel, super.key});

  final TimelineViewModel viewModel;

  List<Widget> actions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          color: AppColors.primary,
          context.isCupertino
              ? CupertinoIcons.slider_horizontal_3
              : Icons.filter_alt_outlined,
        ),
        onPressed:
            () async => showAdaptiveDialog(
              context: context,
              barrierColor: Colors.transparent,
              builder: (BuildContext context) {
                return FilterDialog<EventType>(
                  options: viewModel.selectEventTypes.value,
                  onSelectItem:
                      ({required EventType value, bool? isChecked}) =>
                          viewModel.toggleSelectedType(
                            isChecked: isChecked ?? false,
                            type: value,
                          ),
                  onSubmit: viewModel.filterEvents,
                );
              },
            ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (BuildContext context, _) {
        if (viewModel.hasError) {
          return Center(child: Text(viewModel.error!));
        }
        if (!viewModel.hasData && !viewModel.hasError) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        const double timelineCapHeight = 30;
        const double timelineCapStart = 200;
        return ColoredBox(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              // Title section
              SizedBox(
                height: 240,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: timelineCapStart,
                      bottom: timelineCapStart + timelineCapHeight,
                      left: sidebarWidth / 2,
                      child: CustomPaint(
                        painter: TimelineCapPainter(height: timelineCapHeight),
                      ),
                    ),
                    Positioned(
                      top: timelineCapStart + timelineCapHeight,
                      bottom: 0,
                      left: sidebarWidth / 2,
                      child: CustomPaint(
                        painter: TimelinePainter(dotRadius: 0),
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
                            style: context.headlineLarge,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            viewModel.readableDate,
                            style: context.titleMedium,
                          ),
                          Text(
                            AppStrings.historicEvents(
                              viewModel.filteredEvents.length.toString(),
                            ).toUpperCase(),
                            style: context.titleMedium,
                          ),
                          if (viewModel.readableYearRange != '')
                            Text(
                              AppStrings.yearRange(viewModel.readableYearRange),
                              style: context.titleMedium,
                            ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: viewModel.filteredEvents.length,
                itemBuilder: (BuildContext context, int index) {
                  final OnThisDayEvent event = viewModel.filteredEvents[index];
                  return TimelineListItem(event: event);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
