// To parse this JSON data, do
//
//     final branchDetails = branchDetailsFromJson(jsonString);


class BranchDetailsModel {
  final List<BranchDetails> details;

  BranchDetailsModel({
    required this.details,
  });

  factory BranchDetailsModel.fromJson(
      List<dynamic> parsedJson) {
    List<BranchDetails> details;
    details = parsedJson.map((i) => BranchDetails.fromJson(i)).toList();

    return  BranchDetailsModel(details: details);
  }
}


class BranchDetails {
  String name;
  Commit commit;
  bool protected;

  BranchDetails({
    required this.name,
    required this.commit,
    required this.protected,
  });

  factory BranchDetails.fromJson(Map<String, dynamic> json) => BranchDetails(
    name: json["name"],
    commit: Commit.fromJson(json["commit"]),
    protected: json["protected"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "commit": commit.toJson(),
    "protected": protected,
  };
}

class Commit {
  String sha;
  String url;

  Commit({
    required this.sha,
    required this.url,
  });

  factory Commit.fromJson(Map<String, dynamic> json) => Commit(
    sha: json["sha"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "sha": sha,
    "url": url,
  };
}
