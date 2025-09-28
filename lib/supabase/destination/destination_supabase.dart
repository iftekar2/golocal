class DestinationSupabase {
  int? id;
  String? locationName;
  String? city;
  String? country;
  String? continent;
  String? description;
  String? imageUrl;
  double? rating;
  int? numRatings;

  DestinationSupabase({
    this.id,
    this.locationName,
    this.city,
    this.country,
    this.continent,
    this.description,
    this.imageUrl,
    this.rating,
    this.numRatings,
  });

  factory DestinationSupabase.fromMap(Map<String, dynamic> map) {
    return DestinationSupabase(
      id: map['id'] as int?,
      locationName: map['location_name'] as String?,
      city: map['city'] as String?,
      country: map['country'] as String?,
      continent: map['continent'] as String?,
      description: map['description'] as String?,
      imageUrl: map['image_url'] as String?,
      rating: (map['rating'] as num?)?.toDouble(),
      numRatings: map['num_ratings'] as int?,
    );
  }
}
