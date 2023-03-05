import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:split_rex/main.dart';
import 'package:split_rex/src/widgets/auth.dart';


void main() {
  testWidgets('Sign Up Test - Email Validation', (WidgetTester tester) async {
    // build app and trigger a frame
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // verify in sign up page
    expect(find.byType(SignUpForm, skipOffstage: false), findsOneWidget);
    expect(find.byType(SignInForm), findsNothing);

    // initialize forms to be tested
    final email = find.byKey(const Key("E-mail"));

    // test frontend email validation
    await tester.enterText(email, "popolakamaka");
    await tester.pumpAndSettle();

    // should return corresponding error msg on submit
    await tester.tap(find.byType(SubmitBtn));
    await tester.pump(const Duration(seconds: 3));
    expect(find.text("Please Use Valid Email Address"), findsOneWidget);
  });

  testWidgets('Sign Up Test - Password Validation', (WidgetTester tester) async {
    // build app and trigger a frame
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // verify in sign up page
    expect(find.byType(SignUpForm, skipOffstage: false), findsOneWidget);
    expect(find.byType(SignInForm), findsNothing);

    // initialize forms to be tested
    final email = find.byKey(const Key("E-mail"));
    final pass = find.byKey(const Key("Password"));
    final confPass = find.byKey(const Key("Confirm Password"));

    // enter valid email
    await tester.enterText(email, "popolakamaka@gmail.com");

    // test frontend password & confirm password validation
    await tester.enterText(pass, "popolakamaka");
    await tester.pump();
    await tester.enterText(confPass, "popolakamaka22");
    await tester.pump();

    // should return corresponding error msg on submit
    await tester.tap(find.byType(SubmitBtn));
    await tester.pump(const Duration(seconds: 3));
    expect(find.text("Your password and confirmation does not match!"), findsOneWidget);
  });
}
