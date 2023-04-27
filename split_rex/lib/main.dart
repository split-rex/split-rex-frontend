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


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ProviderScope(child:
    MaterialApp(
      title: 'Split-rex',
      theme: ThemeData(
        textTheme: GoogleFonts.manropeTextTheme().apply(
          bodyColor: const Color(0xFF4F4F4F),
          displayColor: const Color(0xFF4F4F4F),
        ),
      ),
      builder: EasyLoading.init(),
      initialRoute: '/sign_up',
      routes: {
        '/': (context) => const Home(),
        '/sign_up': (context) => const SignUpScreen(),
        '/sign_in': (context) => const SignInScreen(),
        '/group_list': (context) => const GroupList(),
        '/activity': (context) => const Activity(),
        '/account': (context) => const Account(),
        '/friend_requests': (context) => const FriendRequests(),
        '/friends': (context) => const Friends(),
        '/add_friends': (context) => const AddFriends(),
        '/add_expense': (context) => const AddExpense(),
        '/edit_items': (context) => const EditItems(),
        '/split_bill': (context) => const SplitBill(),
        '/new_group': (context) => const CreateNewGroup(),
        '/group_detail': (context) => const GroupDetail(),
        '/choose_friend': (context) => const ChooseFriend(),
        '/edit_account': (context) => const EditAccount(),
        '/change_password': (context) => const ChangePassword(),
        '/fill_username': (context) => const UsernameFill(),
        '/group_settings': (context) => const GroupSettings(),
        '/group_settings_edit': (context) => const GroupSettingsEdit(),
        '/choose_friend_group_settings': (context) => const ChooseFriendInGroupSetting(),
        '/scan_bill': (context) => const CameraPage(),
        '/preview_image': (context) => const PreviewPage(),
        '/settle_up': (context) => const SettleUp(),
        '/unsettled_payments': (context) => const UnsettledPayments(),
        '/transaction_detail': (context) => const TransactionDetail(),
        '/confirm_payment': (context) => const ConfirmPayment()
      },
    )),
  );
}
