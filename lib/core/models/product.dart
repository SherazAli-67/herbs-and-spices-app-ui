import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String image;
  final Color cardTint;
  final int? discountPercent;
  final String description;
  final List<String> details;
  final List<String> forms;
  final List<String> sizes;
  final String category;
  final List<String> cuisines;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.cardTint,
    this.discountPercent,
    required this.description,
    required this.details,
    required this.forms,
    required this.sizes,
    required this.category,
    required this.cuisines,
  });
}
