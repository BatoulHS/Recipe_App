// import 'package:flutter/material.dart';

// class FavoriteButton extends StatefulWidget {
//   const FavoriteButton({super.key, required this.recipeId, required this.isFavorite, required this.onFavoriteToggle});
//   final String recipeId;
//   final bool isFavorite;
//   final Function(bool) onFavoriteToggle;

//   @override
//   State<FavoriteButton> createState() => _FavoriteButtonState();
// }
// class _FavoriteButtonState extends State<FavoriteButton> {
//   bool isFavorite = false;

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       icon: Icon(
//         isFavorite ? Icons.favorite : Icons.favorite_border,
//         color: isFavorite ? Colors.red : Colors.grey,
//       ),
//       onPressed: () {
//        onFavoriteToggle(!isFavorite);
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  final bool isFavorite;
  final Function(bool) onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.grey,
      ),
      onPressed: () {
        onFavoriteToggle(!isFavorite);
      },
    );
  }
}