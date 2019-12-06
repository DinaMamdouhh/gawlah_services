class Tour {
  final String name;
  final String description;
  final double rating;
  final String image;
  final String period;
  final int id;
  final List<String> tags;

  final String museum;
  //final String from;

  String get tour_image => image;
  String get tour_name => name;
  String get tour_description => description;
  String get tour_location => museum;
  String get tour_period => period;
  int get tour_id => id;
  double get tour_rating => rating;
  List<String> get tour_tags => tags;
  const Tour(
      {this.period,
      this.id,
      this.name,
      this.museum,
      this.rating,
      this.tags,
      this.description,
      this.image});

}


