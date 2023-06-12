// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

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
          width: 50,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(
              0.1,
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
                      splashColor: Colors.black.withOpacity(
                        0.5,
                      ),
                      radius: 16,
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(
                          10,
                        ),
                      ),
                      onTap: () {
                        index == 0
                            ? widget._animateToListenable.value =
                                AnimateTo.userLocation
                            : widget._animateToListenable.value =
                                AnimateTo.thingLocation;
                      },
                      child: ValueListenableBuilder<AnimateTo?>(
                        valueListenable: widget._animateToListenable,
                        builder: (_, animateToValue, __) => Container(
                          width: 50,
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
                                      ? Colors.black.withOpacity(
                                          0.8,
                                        )
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
                            color: Colors.white.withOpacity(
                              0.7,
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
