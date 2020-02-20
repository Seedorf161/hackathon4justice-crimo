class SuspectAccount {
  String fullName;
  String address;
  DateTime dob;

  String arrestedDay;
  String arrestedMonth;
  String arrestedYear;

  String birthdayDay;
  String birthdayMonth;
  String birthdayYear;

  List<String> offences;
  List<String> officersInCharge;
  List<String> proofs;

  DateTime dateArrested;
  String caseSection;
  String caseNumber;

  String mugshot;

  String courtHouseID;
  String stationID;

  int caseSubmittedOn;
  int isCaseCompleted;

  int trialDate;
  String assignedJudge;

  SuspectAccount({
    this.fullName,
    this.address,
    this.dob,
    this.offences,
    this.dateArrested,
    this.caseSection,
    this.officersInCharge,
    this.proofs,
    this.caseNumber,
    this.mugshot,
    this.courtHouseID,
    this.stationID,
    this.caseSubmittedOn,
    this.arrestedDay,
    this.arrestedMonth,
    this.arrestedYear,
    this.birthdayDay,
    this.birthdayMonth,
    this.birthdayYear,
    this.trialDate,
    this.assignedJudge,
    this.isCaseCompleted,
  });

  SuspectAccount.fromJSON(Map<String, dynamic> json) {
    fullName = json["fullName"];
    address = json["address"];
    dob = json["dob"];
    offences = List<String>.from(json["offences"]);
    dateArrested = json["dateArrested"];
    caseSection = json["caseSection"];
    officersInCharge = List<String>.from(json["officersInCharge"]);
    proofs = List<String>.from(json["proofs"]);
    caseNumber = json["caseNumber"];
    mugshot = json["mugshot"];
    courtHouseID = json["courtHouseID"];
    stationID = json["stationID"];
    caseSubmittedOn = json["caseSubmittedOn"];

    arrestedDay = json["arrestedDay"];
    arrestedMonth = json["arrestedMonth"];
    arrestedYear = json["arrestedYear"];

    birthdayDay = json["birthdayDay"];
    birthdayMonth = json["birthdayMonth"];
    birthdayYear = json["birthdayYear"];

    assignedJudge = json["assignedJudge"];
    trialDate = json["trialDate"];
    isCaseCompleted = json["isCaseCompleted"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data["fullName"] = this.fullName;
    data["address"] = this.address;
    data["dob"] = this.dob;
    data["offences"] = this.offences;
    data["dateArrested"] = this.dateArrested;
    data["caseSection"] = this.caseSection;
    data["officersInCharge"] = this.officersInCharge;
    data["proofs"] = this.proofs;
    data["caseNumber"] = this.caseNumber;
    data["mugshot"] = this.mugshot;
    data["caseSubmittedOn"] = this.caseSubmittedOn;
    data["courtHouseID"] = this.courtHouseID;
    data["stationID"] = this.stationID;
    data["arrestedDay"] = this.arrestedDay;
    data["arrestedMonth"] = this.arrestedMonth;
    data["arrestedYear"] = this.arrestedYear;
    data["birthdayDay"] = this.birthdayDay;
    data["birthdayMonth"] = this.birthdayMonth;
    data["birthdayYear"] = this.birthdayYear;
    data["trialDate"] = this.trialDate;
    data["assignedJudge"] = this.assignedJudge;
    data["isCaseCompleted"] = this.isCaseCompleted;
    return data;
  }
}
