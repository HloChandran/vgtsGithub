// To parse this JSON data, do
//
//     final branchcommitDetails = branchcommitDetailsFromJson(jsonString);

import 'dart:convert';
class BranchcommitDetailsModel {
  final List<BranchcommitDetails> details;

  BranchcommitDetailsModel({
    required this.details,
  });

  factory BranchcommitDetailsModel.fromJson(
      List<dynamic> parsedJson) {
    List<BranchcommitDetails> details;
    details = parsedJson.map((i) => BranchcommitDetails.fromJson(i)).toList();

    return  BranchcommitDetailsModel(details: details);
  }
}



class BranchcommitDetails {
  String sha;
  String nodeId;
  Commit commit;
  String url;
  String htmlUrl;
  String commentsUrl;
  BranchcommitDetailsAuthor author;
  BranchcommitDetailsAuthor committer;
  List<Parent> parents;
  Stats stats;
  List<FileElement> files;

  BranchcommitDetails({
    required this.sha,
    required this.nodeId,
    required this.commit,
    required this.url,
    required this.htmlUrl,
    required this.commentsUrl,
    required this.author,
    required this.committer,
    required this.parents,
    required this.stats,
    required this.files,
  });

  factory BranchcommitDetails.fromJson(Map<String, dynamic> json) => BranchcommitDetails(
    sha: json["sha"],
    nodeId: json["node_id"],
    commit: Commit.fromJson(json["commit"]),
    url: json["url"],
    htmlUrl: json["html_url"],
    commentsUrl: json["comments_url"],
    author: BranchcommitDetailsAuthor.fromJson(json["author"]),
    committer: BranchcommitDetailsAuthor.fromJson(json["committer"]),
    parents: List<Parent>.from(json["parents"].map((x) => Parent.fromJson(x))),
    stats: Stats.fromJson(json["stats"]),
    files: List<FileElement>.from(json["files"].map((x) => FileElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sha": sha,
    "node_id": nodeId,
    "commit": commit.toJson(),
    "url": url,
    "html_url": htmlUrl,
    "comments_url": commentsUrl,
    "author": author.toJson(),
    "committer": committer.toJson(),
    "parents": List<dynamic>.from(parents.map((x) => x.toJson())),
    "stats": stats.toJson(),
    "files": List<dynamic>.from(files.map((x) => x.toJson())),
  };
}

class BranchcommitDetailsAuthor {
  String login;
  int id;
  String nodeId;
  String avatarUrl;
  String gravatarId;
  String url;
  String htmlUrl;
  String followersUrl;
  String followingUrl;
  String gistsUrl;
  String starredUrl;
  String subscriptionsUrl;
  String organizationsUrl;
  String reposUrl;
  String eventsUrl;
  String receivedEventsUrl;
  String type;
  bool siteAdmin;

  BranchcommitDetailsAuthor({
    required this.login,
    required this.id,
    required this.nodeId,
    required this.avatarUrl,
    required this.gravatarId,
    required this.url,
    required this.htmlUrl,
    required this.followersUrl,
    required this.followingUrl,
    required this.gistsUrl,
    required this.starredUrl,
    required this.subscriptionsUrl,
    required this.organizationsUrl,
    required this.reposUrl,
    required this.eventsUrl,
    required this.receivedEventsUrl,
    required this.type,
    required this.siteAdmin,
  });

  factory BranchcommitDetailsAuthor.fromJson(Map<String, dynamic> json) => BranchcommitDetailsAuthor(
    login: json["login"],
    id: json["id"],
    nodeId: json["node_id"],
    avatarUrl: json["avatar_url"],
    gravatarId: json["gravatar_id"],
    url: json["url"],
    htmlUrl: json["html_url"],
    followersUrl: json["followers_url"],
    followingUrl: json["following_url"],
    gistsUrl: json["gists_url"],
    starredUrl: json["starred_url"],
    subscriptionsUrl: json["subscriptions_url"],
    organizationsUrl: json["organizations_url"],
    reposUrl: json["repos_url"],
    eventsUrl: json["events_url"],
    receivedEventsUrl: json["received_events_url"],
    type: json["type"],
    siteAdmin: json["site_admin"],
  );

  Map<String, dynamic> toJson() => {
    "login": login,
    "id": id,
    "node_id": nodeId,
    "avatar_url": avatarUrl,
    "gravatar_id": gravatarId,
    "url": url,
    "html_url": htmlUrl,
    "followers_url": followersUrl,
    "following_url": followingUrl,
    "gists_url": gistsUrl,
    "starred_url": starredUrl,
    "subscriptions_url": subscriptionsUrl,
    "organizations_url": organizationsUrl,
    "repos_url": reposUrl,
    "events_url": eventsUrl,
    "received_events_url": receivedEventsUrl,
    "type": type,
    "site_admin": siteAdmin,
  };
}

class Commit {
  CommitAuthor author;
  CommitAuthor committer;
  String message;
  Tree tree;
  String url;
  int commentCount;
  Verification verification;

  Commit({
    required this.author,
    required this.committer,
    required this.message,
    required this.tree,
    required this.url,
    required this.commentCount,
    required this.verification,
  });

  factory Commit.fromJson(Map<String, dynamic> json) => Commit(
    author: CommitAuthor.fromJson(json["author"]),
    committer: CommitAuthor.fromJson(json["committer"]),
    message: json["message"],
    tree: Tree.fromJson(json["tree"]),
    url: json["url"],
    commentCount: json["comment_count"],
    verification: Verification.fromJson(json["verification"]),
  );

  Map<String, dynamic> toJson() => {
    "author": author.toJson(),
    "committer": committer.toJson(),
    "message": message,
    "tree": tree.toJson(),
    "url": url,
    "comment_count": commentCount,
    "verification": verification.toJson(),
  };
}

class CommitAuthor {
  String name;
  String email;
  DateTime date;

  CommitAuthor({
    required this.name,
    required this.email,
    required this.date,
  });

  factory CommitAuthor.fromJson(Map<String, dynamic> json) => CommitAuthor(
    name: json["name"],
    email: json["email"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "date": date.toIso8601String(),
  };
}

class Tree {
  String sha;
  String url;

  Tree({
    required this.sha,
    required this.url,
  });

  factory Tree.fromJson(Map<String, dynamic> json) => Tree(
    sha: json["sha"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "sha": sha,
    "url": url,
  };
}

class Verification {
  bool verified;
  String reason;
  dynamic signature;
  dynamic payload;

  Verification({
    required this.verified,
    required this.reason,
    required this.signature,
    required this.payload,
  });

  factory Verification.fromJson(Map<String, dynamic> json) => Verification(
    verified: json["verified"],
    reason: json["reason"],
    signature: json["signature"],
    payload: json["payload"],
  );

  Map<String, dynamic> toJson() => {
    "verified": verified,
    "reason": reason,
    "signature": signature,
    "payload": payload,
  };
}

class FileElement {
  String sha;
  String filename;
  String status;
  int additions;
  int deletions;
  int changes;
  String blobUrl;
  String rawUrl;
  String contentsUrl;
  String patch;

  FileElement({
    required this.sha,
    required this.filename,
    required this.status,
    required this.additions,
    required this.deletions,
    required this.changes,
    required this.blobUrl,
    required this.rawUrl,
    required this.contentsUrl,
    required this.patch,
  });

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
    sha: json["sha"],
    filename: json["filename"],
    status: json["status"],
    additions: json["additions"],
    deletions: json["deletions"],
    changes: json["changes"],
    blobUrl: json["blob_url"],
    rawUrl: json["raw_url"],
    contentsUrl: json["contents_url"],
    patch: json["patch"],
  );

  Map<String, dynamic> toJson() => {
    "sha": sha,
    "filename": filename,
    "status": status,
    "additions": additions,
    "deletions": deletions,
    "changes": changes,
    "blob_url": blobUrl,
    "raw_url": rawUrl,
    "contents_url": contentsUrl,
    "patch": patch,
  };
}

class Parent {
  String sha;
  String url;
  String htmlUrl;

  Parent({
    required this.sha,
    required this.url,
    required this.htmlUrl,
  });

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
    sha: json["sha"],
    url: json["url"],
    htmlUrl: json["html_url"],
  );

  Map<String, dynamic> toJson() => {
    "sha": sha,
    "url": url,
    "html_url": htmlUrl,
  };
}

class Stats {
  int total;
  int additions;
  int deletions;

  Stats({
    required this.total,
    required this.additions,
    required this.deletions,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
    total: json["total"],
    additions: json["additions"],
    deletions: json["deletions"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "additions": additions,
    "deletions": deletions,
  };
}

