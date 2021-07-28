class AccountStatusResponse {
  int? userType;
  bool? mailStatus;
  bool? activeStatus;
  int? ownerStatus;
  int? workerStatus;
  String? error;

  AccountStatusResponse({
    this.userType,
    this.mailStatus,
    this.activeStatus,
    this.ownerStatus,
    this.workerStatus,
    this.error,
  });

  factory AccountStatusResponse.fromMap(Map<String, dynamic> map) {
    return AccountStatusResponse(
      userType: map['User_Type'] as int?,
      mailStatus: map['Mail_Status'] as bool?,
      activeStatus: map['Active_Status'] as bool?,
      ownerStatus: _parseTypeStatus(map['Owner_Status']),
      workerStatus: _parseTypeStatus(map['Worker_Status']),
      error: map['Error'] as String?,
    );
  }

  static int? _parseTypeStatus(dynamic status) {
    if (status is bool) {
      return null;
    }
    return status as int;
  }
}
