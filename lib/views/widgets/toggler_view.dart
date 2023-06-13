// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_detect/cubits/details_cubit/details_cubit.dart';

enum AnimateTo { userLocation, thingLocation }

class TogglerView extends StatefulWidget {
  const TogglerView({
    required ValueNotifier<AnimateTo?> animateToListenable,
    super.key,
  }) : _animateToListenable = animateToListenable;

  final ValueNotifier<AnimateTo?> _animateToListenable;

  @override
  State<TogglerView> createState() => _TogglerViewState();
}

class _TogglerViewState extends State<TogglerView> {
  @override
  void dispose() {
    widget._animateToListenable.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          width: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(
              0.5,
            ),
            borderRadius: BorderRadiusDirectional.circular(
              10,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: List<Widget>.generate(
              3,
              (index) => index == 0 || index == 2
                  ? InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(
                          10,
                        ),
                      ),
                      onTap: () {
                        if (index == 0) {
                          widget._animateToListenable.value =
                              AnimateTo.userLocation;
                        } else if (index == 2) {
                          final detailsState =
                              BlocProvider.of<DetailsCubit>(context).state;
                          if (detailsState is LoadedDetailsState) {
                            widget._animateToListenable.value =
                                AnimateTo.thingLocation;
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                dismissDirection: DismissDirection.startToEnd,
                                backgroundColor:
                                    detailsState is FailedToLoadDetailsState
                                        ? Colors.red
                                        : Colors.blue,
                                content: Text(
                                  detailsState is FailedToLoadDetailsState
                                      ? detailsState.errorMessage
                                      : 'It is either data is still loading or there is no data',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }
                        }
                      },
                      child: ValueListenableBuilder<AnimateTo?>(
                        valueListenable: widget._animateToListenable,
                        builder: (_, animateToValue, __) => Container(
                          width: 40,
                          padding: const EdgeInsetsDirectional.symmetric(
                            vertical: 8,
                          ),
                          decoration: animateToValue != null
                              ? BoxDecoration(
                                  color: index == 0 &&
                                              animateToValue ==
                                                  AnimateTo.userLocation ||
                                          index == 2 &&
                                              animateToValue ==
                                                  AnimateTo.thingLocation
                                      ? Colors.blue
                                      : null,
                                  borderRadius: index == 0
                                      ? const BorderRadiusDirectional.vertical(
                                          top: Radius.circular(
                                            10,
                                          ),
                                        )
                                      : const BorderRadiusDirectional.vertical(
                                          bottom: Radius.circular(
                                            10,
                                          ),
                                        ),
                                )
                              : null,
                          child: Icon(
                            index == 0 ? Icons.person : Icons.account_tree,
                            size: 28,
                            color: index == 0 &&
                                        animateToValue ==
                                            AnimateTo.userLocation ||
                                    index == 2 &&
                                        animateToValue ==
                                            AnimateTo.thingLocation
                                ? Colors.white.withOpacity(
                                    0.7,
                                  )
                                : Colors.black.withOpacity(
                                    0.8,
                                  ),
                          ),
                        ),
                      ),
                    )
                  : const Divider(
                      height: 1,
                      thickness: 1,
                    ),
            ),
          ),
        ),
      );
}
