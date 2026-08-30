import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:beautipholl/app.dart';
import 'package:beautipholl/core/services/storage_service.dart';
import 'package:beautipholl/core/utils/constants/app_texts.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Onboarding-1 matches Figma copy and actions', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await StorageService.init();

    await tester.binding.setSurfaceSize(const Size(402, 874));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const Beautipholl());
    await tester.pumpAndSettle();

    expect(find.text(AppText.onboardingTitle1), findsOneWidget);
    expect(find.text(AppText.onboardingSubtitle1), findsOneWidget);
    expect(find.text(AppText.skip), findsOneWidget);
  });
}
