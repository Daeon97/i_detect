// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_detect/cubits/efotainer_history_cubit/efotainer_history_cubit.dart';
import 'package:i_detect/models/efotainer.dart';
import 'package:i_detect/resources/colors.dart';
import 'package:i_detect/resources/numbers.dart';
import 'package:i_detect/resources/strings.dart';
import 'package:i_detect/views/widgets/battery_level_icon_widget.dart';

class ParamsDisplayWidget extends StatelessWidget {
  const ParamsDisplayWidget({
    required ValueNotifier<Efotainer?> selected,
    super.key,
  })  :
        _selected = selected;

  final ValueNotifier<Efotainer?> _selected;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Align(
          alignment: AlignmentDirectional.topCenter,
          child: Wrap(
            alignment: WrapAlignment.center,
            children: List<Widget>.generate(
              paramsDisplayWidgetCardCount,
              (index) => Padding(
                padding: const EdgeInsetsDirectional.all(
                  tinySpacing + tinySpacing,
                ),
                child: Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                    vertical: smallSpacing,
                    horizontal: spacing,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadiusDirectional.circular(
                      paramsDisplayWidgetCardCornerRadius,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: paramsDisplayWidgetCardShadowColor,
                        blurRadius: paramsDisplayWidgetCardBlurRadius,
                        offset: Offset(
                          paramsDisplayWidgetCardShadowOffsetX,
                          paramsDisplayWidgetCardShadowOffsetY,
                        ),
                      ),
                    ],
                  ),
                  child:
                      BlocBuilder<EfotainerHistoryCubit, EfotainerHistoryState>(
                    builder: (_, efotainerHistoryState) =>
                        ValueListenableBuilder(
                      valueListenable: _selected,
                      builder: (__, selectedValue, ___) => RichText(
                        text: TextSpan(
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: paramsDisplayWidgetTextColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: paramsDisplayWidgetFontSize,
                                  ),
                          children: switch (index) {
                            paramsDisplayWidgetFirstCardIndex => [
                                TextSpan(
                                  text:
                                      '${efotainerHistoryState is LoadedEfotainerHistoryState ? selectedValue?.temperature ?? efotainerHistoryState.efotainerHistory.last.temperature! : zero}',
                                ),
                                const TextSpan(
                                  text: whiteSpace,
                                ),
                                const TextSpan(
                                  text: degreeCelcius,
                                ),
                              ],
                            paramsDisplayWidgetSecondCardIndex => [
                                const TextSpan(
                                  text: humidity,
                                ),
                                const TextSpan(
                                  text: whiteSpace,
                                ),
                                TextSpan(
                                  text:
                                      '${efotainerHistoryState is LoadedEfotainerHistoryState ? selectedValue?.humidity ?? efotainerHistoryState.efotainerHistory.last.humidity! : zero}',
                                ),
                                const TextSpan(
                                  text: percentage,
                                ),
                              ],
                            _ => [
                                TextSpan(
                                  text:
                                      '${efotainerHistoryState is LoadedEfotainerHistoryState ? selectedValue?.battery ?? efotainerHistoryState.efotainerHistory.last.battery! : zero}',
                                ),
                                const TextSpan(
                                  text: percentage,
                                ),
                                const TextSpan(
                                  text: whiteSpace,
                                ),
                                WidgetSpan(
                                  child: BatteryLevelIconWidget(
                                    batteryLevel: efotainerHistoryState
                                            is LoadedEfotainerHistoryState
                                        ? selectedValue?.battery ??
                                            efotainerHistoryState
                                                .efotainerHistory.last.battery!
                                        : zero,
                                  ),
                                ),
                              ],
                          },
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
