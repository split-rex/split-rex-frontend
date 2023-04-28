// NANDO WAS HERE

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:split_rex/src/screens/account/account.dart';
import 'package:split_rex/src/screens/account/account_edit.dart';
import 'package:split_rex/src/screens/account/change_password.dart';
import 'package:split_rex/src/screens/activity.dart';
import 'package:split_rex/src/screens/auth/sign_in.dart';
import 'package:split_rex/src/screens/auth/sign_up.dart';
import 'package:split_rex/src/screens/auth/username_fill.dart';
import 'package:split_rex/src/screens/expense/add_expense.dart';
import 'package:split_rex/src/screens/expense/confirm_payment.dart';
import 'package:split_rex/src/screens/expense/edit_items.dart';
import 'package:split_rex/src/screens/expense/split_bill.dart';
import 'package:split_rex/src/screens/expense/transaction_detail.dart';
import 'package:split_rex/src/screens/friends/add_friends.dart';
import 'package:split_rex/src/screens/friends/choose_friend.dart';
import 'package:split_rex/src/screens/friends/friend_requests.dart';
import 'package:split_rex/src/screens/friends/friends.dart';
import 'package:split_rex/src/screens/groups/group_detail.dart';
import 'package:split_rex/src/screens/groups/group_list.dart';
import 'package:split_rex/src/screens/groups/group_setting.dart';
import 'package:split_rex/src/screens/groups/new_group.dart';
import 'package:split_rex/src/screens/home.dart';
import 'package:split_rex/src/screens/scan_bill.dart';
import 'package:split_rex/src/screens/settle/settle_up.dart';
import 'package:split_rex/src/screens/settle/unsettled_payments.dart';      
import 'package:firebase_core/firebase_core.dart';
import 'package:split_rex/src/services/notification.dart';

import 'src/screens/forgot_password/create_new_password.dart';
import 'src/screens/forgot_password/forgot_pasword.dart';
import 'src/screens/forgot_password/reset_password_sucess.dart';
import 'src/screens/forgot_password/verify_token.dart';
import 'src/screens/splashscreen.dart';
import 'src/screens/statistics.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().init();
  runApp(
    ProviderScope(
      child: MaterialApp(
        title: 'Split-rex',
        theme: ThemeData(
          textTheme: GoogleFonts.manropeTextTheme().apply(
            bodyColor: const Color(0xFF4F4F4F),
            displayColor: const Color(0xFF4F4F4F),
          ),
        ),
        initialRoute: "/",
        builder: EasyLoading.init(),
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case '/':
              builder = (BuildContext context) => const SplashScreen();
              break;
            case '/home':
              builder = (BuildContext context) => const Home();
              break;
            case '/sign_up':
              builder = (BuildContext context) => const SignUpScreen();
              break;
            case '/sign_in':
              builder = (BuildContext context) => const SignInScreen();
              break;
            case '/group_list':
              builder = (BuildContext context) => const GroupList();
              break;
            case '/activity':
              builder = (BuildContext context) => const Activity();
              break;
            case '/account':
              builder = (BuildContext context) => const Account();
              break;
            case '/friend_requests':
              builder = (BuildContext context) => const FriendRequests();
              break;
            case '/friends':
              builder = (BuildContext context) => const Friends();
              break;
            case '/add_friends':
              builder = (BuildContext context) => const AddFriends();
              break;
            case '/add_expense':
              builder = (BuildContext context) => const AddExpense();
              break;
            case '/edit_items':
              builder = (BuildContext context) => const EditItems();
              break;
            case '/split_bill':
              builder = (BuildContext context) => const SplitBill();
              break;
            case '/new_group':
              builder = (BuildContext context) => const CreateNewGroup();
              break;
            case '/group_detail':
              builder = (BuildContext context) => const GroupDetail();
              break;
            case '/choose_friend':
              builder = (BuildContext context) => const ChooseFriend();
              break;
            case '/edit_account':
              builder = (BuildContext context) => const EditAccount();
              break;
            case '/change_password':
              builder = (BuildContext context) => const ChangePassword();
              break;
            case '/fill_username':
              builder = (BuildContext context) => const UsernameFill();
              break;
            case '/group_settings':
              builder = (BuildContext context) => const GroupSettings();
              break;
            case '/group_settings_edit':
              builder = (BuildContext context) => const GroupSettingsEdit();
              break;
            case '/choose_friend_group_settings':
              builder = (BuildContext context) => const ChooseFriendInGroupSetting();
              break;
            case '/scan_bill':
              builder = (BuildContext context) => const CameraPage();
              break;
            case '/preview_image':
              builder = (BuildContext context) => const PreviewPage();
              break;
            case '/settle_up':
              builder = (BuildContext context) => const SettleUp();
              break;
            case '/unsettled_payments':
              builder = (BuildContext context) => const UnsettledPayments();
              break;
            case '/transaction_detail':
              builder = (BuildContext context) => const TransactionDetail();
              break;
            case '/confirm_payment':
              builder = (BuildContext context) => const ConfirmPayment();
              break;
            case '/statistics':
              builder = (BuildContext context) => const Statistics();
              break;
            case '/forgot_password':
              builder = (BuildContext context) => const ForgotPassword();
              break;
            case '/verify_token':
              builder = (BuildContext context) => const VerifyToken();
              break;
            case '/create_password':
              builder = (BuildContext context) => const CreateNewPassword();
              break;
            case '/reset_pass_success':
              builder = (BuildContext context) => const ResetPassSuccess();
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return builder(context);
            },
            transitionsBuilder: 
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child
            ) {
              if (settings.name == "/" || settings.arguments == "/") {
                return FadeTransition(opacity: animation, child: child);
              } else {
                return child;
              }
            }
            ,
            transitionDuration: 
            settings.name == "/" || settings.arguments == "/"
            ?
            const Duration(seconds: 2)
            :
            const Duration(milliseconds: 0),
          );
        },
      )
    ),
  );
}
