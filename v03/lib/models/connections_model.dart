class Connections {
   String? groupAffiliation;
   String? relatives;

  Connections({
     this.groupAffiliation,
     this.relatives,
  });

  factory Connections.fromJson(Map<String, dynamic>? json) {
    return Connections(
      groupAffiliation: json?['group-affiliation'],
      relatives: json?['relatives'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'group-affiliation': groupAffiliation,
      'relatives': relatives,
    };
  }
}
