class Review 
{
  String actor;
  String biography;
  double popularity;
  String birthday;

  Review
  ({
    required this.actor,
    required this.biography,
    required this.popularity, 
    required this.birthday,
  });

  factory Review.fromJson(Map<String, dynamic> map) 
  {
    return Review
    (
      actor: map['name'] ?? '',
      biography: map['biography'] ?? '',
      popularity: map['popularity']?.toDouble() ?? 0.0,
      birthday: map['birthday'] ?? '',
    );
  }
}
