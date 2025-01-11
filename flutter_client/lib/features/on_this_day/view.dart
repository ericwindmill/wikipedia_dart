import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_client/features/on_this_day/view_model.dart';

class OnThisDayView extends StatelessWidget {
  const OnThisDayView({super.key, required this.viewModel});

  final OnThisDayViewModel viewModel;

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
              return CircularProgressIndicator.adaptive();
            }

            return ListView.builder(
              reverse: true,
              itemCount: viewModel.events.length,
              itemBuilder: (context, index) {
                var event = viewModel.events[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 16.0,
                  ),
                  child: Text('${event.year} - ${event.text}'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
