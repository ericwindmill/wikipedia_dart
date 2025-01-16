import 'package:flutter/material.dart';

import 'view_model.dart';
import 'widgets/filter_dialog.dart';
import 'widgets/list_item.dart';

const double sidebarWidthPercentage = .15;
const double mainColumnWidthPercentage = .85;

class OnThisDayView extends StatelessWidget {
  const OnThisDayView({
    super.key,
    required this.viewModel,
    required this.toggleDarkMode,
  });

  final OnThisDayViewModel viewModel;
  final VoidCallback toggleDarkMode;

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

            var width = MediaQuery.of(context).size.width;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 200,
                  collapsedHeight: 200,
                  flexibleSpace: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: width * sidebarWidthPercentage / 2,
                        child: CustomPaint(
                          painter: TimelinePainter(dotRadius: 0),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: width * sidebarWidthPercentage,
                        right: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'On This Day',
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      viewModel.readableDate,
                                      style: TextTheme.of(context).titleLarge,
                                    ),
                                    Text(
                                      '${viewModel.filteredEvents.length} historic events'
                                          .toUpperCase(),
                                      style: TextTheme.of(context).titleSmall,
                                    ),
                                    if (viewModel.readableYearRange != '')
                                      Text(
                                        'from ${viewModel.readableYearRange}',
                                        style: TextTheme.of(context).titleSmall,
                                      ),
                                  ],
                                ),
                                Spacer(flex: 10),
                                IconButton(
                                  icon: Icon(Icons.light_mode),
                                  onPressed: toggleDarkMode,
                                ),
                                IconButton(
                                  icon: Icon(Icons.filter_alt_outlined),
                                  onPressed:
                                      () async => await showAdaptiveDialog(
                                        context: context,
                                        builder: (context) {
                                          return FilterDialog(
                                            viewModel: viewModel,
                                          );
                                        },
                                      ),
                                ),
                              ],
                            ),

                            SizedBox(height: 20),
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
