import 'dart:math';

import '../../models/swipe_card.dart';
class SwipeService {
  var names = [
    "Ida",
    "Julie",
    "Peter",
    "Camilla",
    "Daniel",
    "Rene",
    "Lars",
    "Josefine"
  ];

  var images = [
    "https://scontent-cph2-1.cdninstagram.com/v/t51.2885-15/420504497_368961109191433_8385871411596550707_n.jpg?stp=dst-jpg_e35&efg=eyJ2ZW5jb2RlX3RhZyI6ImltYWdlX3VybGdlbi4xNDQweDE3OTQuc2RyIn0&_nc_ht=scontent-cph2-1.cdninstagram.com&_nc_cat=101&_nc_ohc=GUPCYUx7hrwAX_dH60p&edm=ACWDqb8BAAAA&ccb=7-5&ig_cache_key=MzI4NTIzMDAxNTk3NjExMTQzOQ%3D%3D.2-ccb7-5&oh=00_AfCI86b7_Sqo0iACOH2Zsu3JG1TPBwzUUU-FMAJOqS8lKQ&oe=65D074A3&_nc_sid=ee9879",
    "https://scontent-cph2-1.cdninstagram.com/v/t51.2885-15/364336263_1300075433967564_669161925182972415_n.jpg?stp=dst-jpg_e35&efg=eyJ2ZW5jb2RlX3RhZyI6ImltYWdlX3VybGdlbi4xNDQweDE4MDAuc2RyIn0&_nc_ht=scontent-cph2-1.cdninstagram.com&_nc_cat=100&_nc_ohc=zAggXAqvhGUAX_XoPdq&edm=ACWDqb8BAAAA&ccb=7-5&ig_cache_key=MzE2MDUyMDE0Mjc2ODg4NzI5Mw%3D%3D.2-ccb7-5&oh=00_AfDD1F3UQc7v6oVEbEomrW7u0EBjZ7ZiDePggOndWhazfA&oe=65CEBA4B&_nc_sid=ee9879",
  ];

  var descs = [
    "Du skal vist til venstre her",
    "Jeg kan verdens med din mor joke, swipe ja for at høre den"
  ];

  SwipeCard getDummySwipeCard() {
    var nameIndex = Random().nextInt(names.length - 1);
    var age = Random().nextInt(40);
    var imageIndex = Random().nextInt(1);
    var descIndex = Random().nextInt(1);
    return SwipeCard(name: names[nameIndex], age: age, imageUrl: images[imageIndex], description: descs[descIndex], uid: "du skal ikke bruge det her endnu");
  }
}
