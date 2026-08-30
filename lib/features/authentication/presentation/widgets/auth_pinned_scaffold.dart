import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthPinnedScaffold extends StatelessWidget {
  const AuthPinnedScaffold({
    super.key,
    required this.backgroundColor,
    required this.header,
    required this.footer,
    this.middle,
    this.resizeToAvoidBottomInset = true,
  });

  final Color backgroundColor;
  final Widget header;
  final Widget footer;
  final Widget? middle;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final topPad = media.padding.top + 32.h;
    final bottomPad = media.padding.bottom + 16.h;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: EdgeInsets.fromLTRB(16.w, topPad, 16.w, 0),
              sliver: SliverToBoxAdapter(child: header),
            ),
            if (middle != null)
              SliverPadding(
                padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
                sliver: SliverToBoxAdapter(child: middle),
              ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(16.w, 40.h, 16.w, bottomPad),
              sliver: SliverFillRemaining(
                hasScrollBody: false,
                child: Column(children: [const Spacer(), footer]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
