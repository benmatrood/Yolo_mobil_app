// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

class Blog {
  final String name;
  final String images;
  final String title;
  final Text boby;

  Blog({required this.name, required this.images, required this.title, required this.boby});

  factory Blog.fromJson(dynamic json) {
    return Blog(
        name: json['name'] as String,
        images: json['url'] as String,
        title: json['title'] as String,
        boby: json['boby'] as Text);
  }

  static List<Blog> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Blog.fromJson(data);
    }).toList();
  }

  @override
  String toString(){
    return 'Blog {name: $name, image: $images, title: $title, boby: $boby}';
  }
}