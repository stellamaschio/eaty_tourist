import 'package:eaty_tourist/models/foods.dart';
import 'package:eaty_tourist/models/restaurants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ListFoods {

  static const List<Foods> foodList = [
    Foods(name: 'APPLE', calories: 65, index: 1, icon: MdiIcons.foodApple,
      description: "The apple is a round fruit and can come in different colors, such as red, green or yellow. The skin of the apple is smooth and can be shiny. Inside, it has crisp and juicy flesh with a sweet and slightly pungent, sour taste. They are often eaten as a snack or used to make juices, pies, jams and other recipes. Apples are a good source of vitamins and fiber, which are important for the health of our bodies.",
      restaurants: [
        Restaurants(name: 'Sotto il Salone', 
          location: 'Piazza delle Erbe, 35, 35122 Padova PD', 
          description: 'Small grocery store under the colonnade of Padua\'s Palazzo della Ragione in Piazza delle Erbe.'), 
        Restaurants(name: 'Despar', 
          location: 'Via Stefano Breda, 16, 35139 Padova PD',
          description: 'Despar supermarket in the historic center of Padua.'),
      ],
    ),
    Foods(name: 'TOAST', calories: 150, index: 2, icon: MdiIcons.toaster,
      description: "A toast (or \"tost\" in Italian) is a toasted or toasted slice of bread. It is prepared by passing the bread through a heat source, such as a toaster or oven, until it becomes crisp and golden brown. Toast can be eaten simply as it is but is most often stuffed with sottiletta and ham. It is often served for breakfast or daily snacks. Toast is a common and widely appreciated food because of its simplicity and versatility. Its quick preparation and tasty nature make it a popular choice for a quick meal or snack.",
      restaurants: [
        Restaurants(name: 'Bar Margherita', 
          location: 'Piazza della Frutta, 44, 35122 Padova PD', 
          description: 'Bar with outdoor and indoor tables, overlooking Piazza dei Signori with excellent views of the Palazzo della Ragione. The walls have large windows to enjoy the view of the square even from inside.',
        ),
        Restaurants(name: 'Bar Tre Scalini', 
          location: 'Via Venezia, 2, 35131 Padova PD', 
          description: 'A bar in the university area of Padua, it overlooks Porta Portello, an area convenient to students, with the presence of a beautiful historic avenue: Via del Portello. It is frequented by hundreds of students every day, space is abundant, especially outside. The presnce of the river moves the buildings away from the esplanade and allows the eye to wander, a relaxing feeling to many.',
        ),
      ],
    ),
    Foods(name: 'ICECREAM', calories: 247, index: 3, icon: MdiIcons.iceCream,
      description: "Ice cream is a cold, creamy dessert that is made with ingredients such as milk, sugar and various flavorings. There are many different flavors of ice cream, such as chocolate, vanilla, strawberry, mint and many others. In addition, ice cream can be enriched by adding fruit, chocolate, nuts or other ingredients to give more variety of flavors. Ice cream is generally served in a cup or on a cone and is very popular during hot days. It is a dessert loved by people of all ages.",
      restaurants: [
        Restaurants(name: 'Venchi Cioccolato e Gelato', 
          location: 'Via Roma, 1, 35122 Padova PD', 
          description: 'Famous chain of ice cream shops, very popular and appreciated. In the historic center of Padua.',
        ),
        Restaurants(name: 'GROM', 
          location: 'Piazza dei Signori, 33, 35139 Padova PD', 
          description: 'Famous chain of ice cream shops, known for using natural products to make ice cream. Located in Piazza dei Signori, ideal for getting an ice cream while enjoying the square.',
        ),
      ],
    ),
    Foods(name: 'PASTA', calories: 360, index: 4, icon: MdiIcons.pasta,
      description: "Pasta is a food made from flour and water, which is kneaded to create a solid mass. Pasta can come in different shapes, such as spaghetti, penne, fusilli, linguine, and many other types. It is cooked by soaking it in boiling water until tender or more \"al dente\". Pasta is a very versatile food and can be combined with a variety of sauces, such as tomato sauce, pesto, ragù, carbonara, and more. It can also be used as a base for cold dishes, such as pasta salads. Pasta is a staple of Italian cuisine. It is nutritious, rich in carbohydrates and can be enriched with ingredients such as vegetables, meat, fish or cheese to create tasty and satisfying dishes.",
      restaurants: [
        Restaurants(name: 'Osteria L\'Anfora', 
          location: 'Via Soncin, 13, 35121 Padova PD',   
          description: 'Simple and cozy Osteria, where you can enjoy good meals and relax with friends. In the historic center of Padua, near Piazza dei Signori.',
        ),
        Restaurants(name: 'Marechiaro Ristorante Pizzeria', 
          location: 'Via Daniele Manin, 37, 35122 Padova PD', 
          description: 'Pizzeria restaurant, also with outdoor seating in a pretty little courtyard surrounded by historic houses, a stone\'s throw from Piazza dei Signori. Great reviews for pasta and pizza!',
        ),
      ],
    ),
    Foods(name: 'CAKE', calories: 450, index: 5, icon: MdiIcons.cupcake,
      description: "A cake is a dessert that is made by combining ingredients such as flour, sugar, eggs and butter. The consistency of the cake may vary depending on the recipe, but it is usually soft and tender. The cake is baked in the oven until it becomes golden brown and firm. It can be enriched with various ingredients, such as fruit, chocolate, vanilla or spices, to give different flavors. Once cooled, the cake can be decorated with frosting, powdered sugar or other fillings. Cakes are often served as desserts or during celebrations, such as birthdays or weddings. They are a sweet and tasty treat to share with friends and family.",
      restaurants: [
        Restaurants(name: 'Osteria L\'Anfora', 
          location: 'Via Soncin, 13, 35121 Padova PD',   
          description: 'Simple and cozy Osteria, where you can enjoy good meals and relax with friends. In the historic center of Padua, near Piazza dei Signori.',
        ),
        Restaurants(name: 'Caffè Pedrocchi', 
          location: 'Via VIII Febbraio, 15, 35122 Padova PD', 
          description: 'Historic café in Padua, one of the most famous in Veneto and Italy. Located next to the historic seat of the University of Padua, with elegant and refined furnishings. It also has a pastry shop communicating with the coffee lounge.',
        ),
      ],
    ),
    Foods(name: 'STEAK', calories: 630, index: 6, icon: MdiIcons.foodSteak,
      description: "A steak is a cut of meat, usually from animals such as cattle, pigs or lambs. It is a thick slice of meat that is usually cooked on a grill, griddle, or skillet. Steak has a juicy texture and can vary depending on the cut of meat and the degree of cooking desired. Some popular cuts of steak include filet, rib eye, and sirloin. Each cut has its own specific characteristics in terms of tenderness, flavor and presence of fat. Steak can be seasoned with salt, pepper or other spices to enhance the natural flavor of the meat. It is served as a second course, accompanied by side dishes such as potatoes, vegetables, salad or sauce. Steak is prized for its juicy texture and intense flavor and is often associated with hearty and tasty meals.",
      restaurants: [
        Restaurants(name: 'Osteria L\'Anfora', 
          location: 'Via Soncin, 13, 35121 Padova PD',   
          description: 'Simple and cozy Osteria, where you can enjoy good meals and relax with friends. In the historic center of Padua, near Piazza dei Signori.',
        ),
        Restaurants(name: 'Vecchia Padova', 
          location: 'Via Cesare Battisti, 37, 35121 Padova PD', 
          description: 'Historic trattoria with tasty and genuine dishes, with excellent interior decor. The dishes are all typical of the Veneto tradition.',
        ),
      ],
    ),
    Foods(name: 'PIZZA', calories: 700, index: 7, icon: MdiIcons.pizza,
     description: "Pizza is a dish originating in Italy, consisting of a leavened dough base, called dough, which is rolled out in a circular shape. The dough is usually made with flour, water, yeast and salt. The pizza base is then topped with a tomato sauce and covered with a variety of ingredients such as cheese (usually mozzarella), cold cuts, vegetables, mushrooms, seafood, and other additions as desired. Once the pizza has been topped, it is baked in a hot oven until the dough becomes golden brown and crispy. The result is a warm, fragrant pizza with a thin or thicker base, depending on the style preferred. Pizza is a popular and beloved dish all over the world. It can be eaten as a main meal, often shared among friends or family. It is a versatile dish, as there are many types of pizzas with different flavors, allowing it to satisfy a wide range of culinary preferences.",
      restaurants: [
        Restaurants(name: 'Marechiaro Ristorante Pizzeria', 
          location: 'Via Daniele Manin, 37, 35122 Padova PD',   
          description: 'Pizzeria restaurant, also with outdoor seating in a pretty little courtyard surrounded by historic houses, a stone\'s throw from Piazza dei Signori. Great reviews for pasta and pizza!',

        ),
        Restaurants(name: 'Forbici Pizza', 
          location: 'Via S. Francesco, 28, 35123 Padova PD',
          description: 'Popular and well-reviewed establishment, for lovers of high dough pizza!',

        ),
      ],
    ),
  ];

}