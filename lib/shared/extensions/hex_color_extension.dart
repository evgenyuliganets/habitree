// extension HexColor on Color {
//   /// Приймає “aabbcc”, “ffaabbcc” або "#aabbcc" і повертає Color
//   static Color fromHex(String hexString) {
//     final buffer = StringBuffer();
//     var hex = hexString.replaceFirst('#', '');
//     if (hex.length == 6) buffer.write('ff');
//     buffer.write(hex);
//     return Color(int.parse(buffer.toString(), radix: 16));
//   }
//
//   /// Повертає строку "#aarrggbb"
//   String toHex({bool leadingHashSign = true}) =>
//       '${leadingHashSign ? '#' : ''}'
//           '${a.toRadixString(16).padLeft(2, '0')}'
//           '${r.toRadixString(16).padLeft(2, '0')}'
//           '${g.toRadixString(16).padLeft(2, '0')}'
//           '${b.toRadixString(16).padLeft(2, '0')}';
// }
