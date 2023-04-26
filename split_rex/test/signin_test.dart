// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:split_rex/main.dart';
// import 'package:split_rex/src/widgets/auth.dart';


// void main() {
//   testWidgets('Sign In Test - Successful Login', (WidgetTester tester) async {
//     // build app and trigger a frame
//     await tester.pumpWidget(const ProviderScope(child: MyApp()));

//     // verify in sign up page
//     expect(find.byType(SignUpForm, skipOffstage: false), findsOneWidget);
//     expect(find.byType(SignInForm), findsNothing);

//     // go to signin page
//     await tester.dragUntilVisible(
//       find.byKey(const Key("SignInPage")), 
//       find.byType(SingleChildScrollView),
//       const Offset(100, 50)
//     );
//     await tester.tap(find.byKey(const Key("SignInPage")));
//     await tester.pump(const Duration(seconds: 5));

//     // verify in sign in page
//     expect(find.byType(SignInForm, skipOffstage: false), findsOneWidget);
//     expect(find.byType(SignUpForm), findsNothing);

//     // initialize forms to be tested
//     final email = find.byKey(const Key("E-mail"));
//     final pass = find.byKey(const Key("Password"));

//     // test frontend email validation
//     await tester.enterText(email, "patrick@gmail.com");
//     await tester.enterText(pass, "patrick");
//     await tester.pumpAndSettle();

//     // should return corresponding error msg on submit
//     await tester.tap(find.byType(SubmitBtn));
//     await tester.pump(const Duration(seconds: 5));
//     expect(find.text("Welcome back,"), findsOneWidget);
//   });
// }
