// extension ColorExtensions on Color {
//   /// Returns a new [Color] with inverted RGB values while preserving alpha
//   Color get inverted {
//     // Extract color components
//     final r = 255 - red;
//     final g = 255 - green;
//     final b = 255 - blue;

//     // Create new color with inverted RGB but same alpha
//     return Color.fromARGB(alpha, r, g, b);
//   }

//   /// Returns a new [Color] with inverted RGB values and optional alpha
//   Color invertWithAlpha([int? newAlpha]) {
//     return Color.fromARGB(
//       newAlpha ?? alpha,
//       255 - red,
//       255 - green,
//       255 - blue,
//     );
//   }
// }
