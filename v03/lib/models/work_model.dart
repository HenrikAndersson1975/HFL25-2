
class Work {
   String? occupation;
   String? base;

  Work({
     this.occupation,
     this.base,
  });

  factory Work.fromJson(Map<String, dynamic>? json) {
    return Work(
      occupation: json?['occupation'],
      base: json?['base'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'occupation': occupation,
      'base': base,
    };
  }
}