class AppURLs {
  /// URL to Terms & Conditions
  static const String tnc = "https://google.com"; //TODO

  /// URL to Privacy Policy
  static const String privacy = "https://google.com"; //TODO

  static const String supportEmail = "mailto:support@bitecope.in";

  // API URLs
  static const String baseAPI = "https://bitecope.co.in";
  static const String register = "$baseAPI/signup/";
  static const String login = "$baseAPI/login/";
  static const String logout = "$baseAPI/logout/";
  static const String accountStatus = "$baseAPI/account_status/";
  static const String deviceDetails = "$baseAPI/device_details/";
  static const String verifyEmail = "$baseAPI/signup_verify_mobile/";
  static const String resendOTP = "$baseAPI/regenerate_email_otp/";
  static const String redeemCode = "$baseAPI/redeem_code/";
  static const String workerInitialize = "$baseAPI/worker_insert/";
  static const String getSuppliers = "$baseAPI/supplier_view/";
  static const String addSupplier = "$baseAPI/add_supplier/";
  static const String editSupplier = "$baseAPI/update_supplier_description/";
  static const String deleteSupplier = "$baseAPI/remove_supplier/";
}
