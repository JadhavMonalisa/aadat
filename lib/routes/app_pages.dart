
import 'package:adat/screens/common/splash_screen.dart';
import 'package:adat/screens/customer/pdf/bill_report_pdf.dart';
import 'package:adat/screens/customer/customer_bill_report.dart';
import 'package:adat/screens/customer/customer_ledger_short_report.dart';
import 'package:adat/screens/customer/customer_ledger_summary_report.dart';
import 'package:adat/screens/customer/customer_ledger_report.dart';
import 'package:adat/screens/customer/customer_weight_list_pdf.dart';
import 'package:adat/screens/customer/ledger_short_report_result_screen.dart';
import 'package:adat/screens/customer/mark_wise_result_screen.dart';
import 'package:adat/screens/customer/mark_wise_weight_list_report.dart';
import 'package:adat/screens/customer/mark_wise_weight_list_report_result.dart';
import 'package:adat/screens/customer/receipt.dart';
import 'package:adat/screens/customer/result_screen.dart';
import 'package:adat/screens/customer/weight_list.dart';
import 'package:adat/screens/farmer/farmer_receipt.dart';
import 'package:adat/screens/home/home_binding.dart';
import 'package:adat/screens/home/home_screen.dart';
import 'package:adat/screens/login/forgot_password.dart';
import 'package:adat/screens/login/login_binding.dart';
import 'package:adat/screens/login/login_screen.dart';
import 'package:adat/screens/supplier/supplier_ledger_report.dart';
import 'package:adat/screens/supplier/supplier_ledger_summary_report.dart';
import 'package:adat/screens/supplier/supplier_result_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.defaultRoute;

  static final all = [
    GetPage(
      name: AppRoutes.defaultRoute,
      page: () => const SplashScreen(),
    ),

    ///user basics
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPassword(),
      binding: LoginBinding(),
    ),

    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),

    ///customer
    GetPage(
      name: AppRoutes.customerLedgerReport,
      page: () => const CustomerLedgerReport(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.customerLedgerReportResultScreen,
      page: () => const ResultScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.customerWightListScreen,
      page: () => const WeightListScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.customerWeightListExportScreen,
      page: () => const CustomerWeightListExportScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.customerBillReportScreen,
      page: () => const BillReportScreen(),
      binding: HomeBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.customerBillReportExport,
    //   page: () =>  BillReportExportScreen(),
    //   binding: HomeBinding(),
    // ),
    GetPage(
      name: AppRoutes.customerReceipt,
      page: () => const CustomerReceipt(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.customerLedgerShortReport,
      page: () => const CustomerLedgerShortReport(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.customerLedgerShortReportResult,
      page: () => const CustomerLedgerShortReportResultScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.customerLedgerSummaryReport,
      page: () => const CustomerLedgerSummaryReport(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.customerMarkWiseWeightListReportScreen,
      page: () => const MarkWiseWeightListReportScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.markWiseResultScreen,
      page: () => const MarkWiseResultScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.markWiseWeightListResultReport,
      page: () => const MarkWiseWeightListResultReport(),
      binding: HomeBinding(),
    ),

    GetPage(
      name: AppRoutes.supplierLedgerReport,
      page: () => const SupplierLedgerReport(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.supplierLedgerSummaryReport,
      page: () => const SupplierSummaryReport(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.supplierResult,
      page: () => const SupplierResultScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.farmerReceipt,
      page: () => const FarmerReceipt(),
      binding: HomeBinding(),
    ),
  ];
}
