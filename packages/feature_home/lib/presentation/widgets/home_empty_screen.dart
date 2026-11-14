import 'package:core/theme/spacing.dart';
import 'package:feature_home/presentation/widgets/home_app_bar.dart';
import 'package:feature_home/presentation/widgets/record_fab.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/mascot.dart';

const _pagePadding = EdgeInsets.symmetric(horizontal: Spacing.m);
const _scrollEndSpacing = Spacing.xxxxxl;
const _backdropWidthFactor = 0.77;
const _plusSymbol = "+";
const _searchingMascotAspectRatio = 0.756;
const _mascotHeightFactor = 0.944;

class const HomeEmptyScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const HomeAppBar(),
      floatingActionButton: const RecordFab(),
      body: SafeArea(
        child: Padding(
          padding: _pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: Spacing.xxl),
              Text(
                context.s.homeLookAroundTitle,
                style: context.t.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Spacing.xl),
                  child: FractionallySizedBox(
                    widthFactor: _backdropWidthFactor,
                    child: Center(child: _SearchingMascot()),
                  ),
                ),
              ),
              const _AddFirstWordHint(),
              const SizedBox(height: _scrollEndSpacing),
            ],
          ),
        ),
      ),
    );
  }
}

class const _AddFirstWordHint() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final message = context.s.homeAddFirstWordMessage(_plusSymbol);
    final plusStart = message.indexOf(_plusSymbol);
    return Text.rich(
      plusStart < 0
          ? TextSpan(text: message)
          : TextSpan(
              children: [
                TextSpan(text: message.substring(0, plusStart)),
                TextSpan(
                  text: _plusSymbol,
                  style: TextStyle(fontWeight: FontWeight.bold, color: context.c.primary),
                ),
                TextSpan(text: message.substring(plusStart + _plusSymbol.length)),
              ],
            ),
      style: context.t.bodyLarge,
      textAlign: TextAlign.center,
    );
  }
}

class const _SearchingMascot() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _searchingMascotAspectRatio,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AspectRatio(
              aspectRatio: 1,
              child: DecoratedBox(
                decoration: ShapeDecoration(
                  color: context.mascot.backdrop,
                  shape: const CircleBorder(),
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: _mascotHeightFactor,
              child: Mascot(pose: MascotPose.search),
            ),
          ),
        ],
      ),
    );
  }
}
