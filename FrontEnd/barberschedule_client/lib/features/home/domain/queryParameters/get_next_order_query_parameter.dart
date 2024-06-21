class GetNextOrderQueryParameter {
  String userId;
  GetNextOrderQueryParameter({
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'UserId': userId,
    };
  }
}
