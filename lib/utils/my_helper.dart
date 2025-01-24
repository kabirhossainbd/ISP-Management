import 'package:flutter/material.dart';
import 'package:isp_management/src/view/screens/active_user/active_user_screen.dart';
import 'package:isp_management/src/view/screens/active_user/all_active_user.dart';
import 'package:isp_management/src/view/screens/customer/customer_screen.dart';
import 'package:isp_management/src/view/screens/due_payment/due_payment_screen.dart';
import 'package:isp_management/src/view/screens/employee_list/employe_list_screen.dart';
import 'package:isp_management/src/view/screens/package/package_list.dart';
import 'package:isp_management/src/view/screens/support_request/support_request_screen.dart';
import 'package:isp_management/src/view/screens/transaction_history/transaction_history_screen.dart';

final List<Widget> screenList = [
  const CustomerScreen(),
  const ActiveUserScreen(),
  const AllActiveUserScreen(),
  const DuePaymentScreen(),
  const PackageList(),
  const SupportRequestScreen(),
  const TransactionHistoryScreen(),
  const EmployeeListScreen(),
];