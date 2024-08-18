
import '../../../helper/appimage.dart';

class ReviewModel {
  static final items = [
    Item(
        id: 1,
        name: "Aarav Singh",
        date: "16 Jan 2024",
        time: "04.40 PM",
        review: "Absolutely loved the experience! The staff was friendly and skilled, and the ambiance was delightful.",
        rating : "4.5",
        image: AppImages.photoOne),

    Item(
        id: 1,
        name: "Nandini Gupta",
        date: "18 Jan 2024",
        time: "12.40 PM",
        review: "Highly impressed with the service! The Business has become my go-to for all beauty needs.",
        rating : "4.0",
        image: AppImages.photoTwo),

    Item(
        id: 1,
        name: "Arjun Sharma",
        date: "23 Jan 2024",
        time: "02.12 PM",
        review: "Had a wonderful experience at the Business. The hairstylist understood exactly what I wanted and delivered beyond expectations.",
        rating : "4.1",
        image: AppImages.photoOne),

    Item(
        id: 1,
        name: "Riya Patel",
        date: "28 Jan 2024",
        time: "10.40 AM",
        review: "Fantastic service! The Business staff made me feel comfortable and pampered throughout my visit.",
        rating : "4.7",
        image: AppImages.photoTwo),

    Item(
        id: 1,
        name: "Rahul Kapoor",
        date: "30 Jan 2024",
        time: "03.20 PM",
        review: "Great atmosphere and excellent service! I would recommend this salon to anyone looking for quality beauty treatments.",
        rating : "5.0",
        image: AppImages.photoOne),

    Item(
        id: 1,
        name: "Ananya Verma",
        date: "2 Feb 2024",
        time: "04.24 PM",
        review: "The Business exceeded my expectations. The staff was professional, and I left feeling refreshed and rejuvenated.",
        rating : "4.8",
        image: AppImages.photoTwo),

  ];
}
class Item {
  final int id;
  final String name;
  final String date;
  final String time;
  final String review;
  final String rating;
  final String image;

  Item(
      {required this.id,
      required this.name,
      required this.date,
      required this.time,
      required this.review,
      required this.rating,
      required this.image});
}
