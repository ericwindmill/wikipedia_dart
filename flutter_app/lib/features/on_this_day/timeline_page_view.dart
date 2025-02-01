import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/on_this_day/timeline_view_model.dart';
import 'package:flutter_app/ui/app_localization.dart';
import 'package:flutter_app/ui/build_context_util.dart';
import 'package:flutter_app/ui/shared_widgets/adaptive/adaptive_app_bar.dart';
import 'package:flutter_app/ui/shared_widgets/filter_dialog.dart';
import 'package:flutter_app/ui/shared_widgets/timeline/timeline.dart';
import 'package:flutter_app/ui/theme/theme.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class TimelinePageView extends StatelessWidget {
  const TimelinePageView({required this.viewModel, super.key});

  final TimelineViewModel viewModel;

  List<Widget> actions(BuildContext context) {
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          context.isCupertino
              ? Colors.white
              : Theme.of(context).scaffoldBackgroundColor,
      appBar: AdaptiveAppBar(
        actions: [
          IconButton(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
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
        ],
      ),
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

            return ListView(
              children: <Widget>[
                // Title section
                SizedBox(
                  height: 240,
                  child: Stack(
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
                              style: context.textTheme.headlineMedium,
                            ),
                            Text(
                              AppStrings.historicEvents(
                                viewModel.filteredEvents.length.toString(),
                              ).toUpperCase(),
                              style: context.textTheme.titleMedium,
                            ),
                            if (viewModel.readableYearRange != '')
                              Text(
                                AppStrings.yearRange(
                                  viewModel.readableYearRange,
                                ),
                                style: context.textTheme.titleMedium,
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
