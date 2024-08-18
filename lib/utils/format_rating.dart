String formatRating(dynamic rating)   {
  if (rating == null) {
    return "0.0";
  } else if (int.parse(rating.toString()) is int) {
    return "$rating.0";
  } else if (double.parse(rating.toString()) is double) {
    return rating.toString();
  } else {
    return "0.0"; // Default value if the type is unexpected
  }
}
