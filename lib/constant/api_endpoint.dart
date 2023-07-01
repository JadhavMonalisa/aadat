class ApiEndpoint {
  ///Login
  static const String loginUrl = "http://adatapi.demofms.com/api/Users/Authenticate";
  ///home
  static const String firmListUrl = "http://adatapi.demofms.com/api/Users/GetFirmDetailsByClientID";
  ///customer
  static const String customerListUrl = "http://adatapi.demofms.com/api/Users/GetCustomerDetails";
  static const String weightListUrl = "http://adatapi.demofms.com/api/Users/GetWeightListRoughBillReport";
  static const String markWiseWeightListUrl = "http://adatapi.demofms.com/api/Users/GetMarkwiseWeightListReport";
  static const String customerLedgerShortReportListUrl = "http://adatapi.demofms.com/api/Users/GetCustomerLedgerShortReport";
  static const String customerLedgerSummaryReportListUrl = "http://adatapi.demofms.com/api/Users/GetCustomerLedgerSummaryReport";
  static const String customerLedgerReportListUrl = "http://adatapi.demofms.com/api/Users/GetCustomerDetailsFormatTwo";
  static const String customerLedgerBillListUrl = "http://adatapi.demofms.com/api/Users/GetCustomerReceipt";

  ///supplier
  static const String supplierListUrl = "http://adatapi.demofms.com/api/Users/GetSupplierDetails";
  static const String supplierLedgerReportUrl = "http://adatapi.demofms.com/api/Users/GetSupplierLegderReportFormateTwo";
  static const String supplierLedgerSummaryReportUrl = "http://adatapi.demofms.com/api/Users/GetSupplierLedgerSummaryReport";
  static const String supplierSearchUrl = "http://adatapi.demofms.com/api/Users/GetSupplierSelection";
  ///farmer
  static const String farmerPattiUrl = "http://adatapi.demofms.com/api/Users/GetFarmerReceipt";

}