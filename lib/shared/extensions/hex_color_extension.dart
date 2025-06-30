import 'dart:ui';

/// final color = HexColor.fromHex("#00BFFF");     // ✅ Color(0xFF00BFFF)
/// final hex = color.toHex();                     // "#FF00BFFF"
/// final hexRgb = color.toHexRgb();               // "#00BFFF"
extension HexColor on Color {
  /// Converts a hex color string (e.g. "#RRGGBB" or "#AARRGGBB") into a
  /// [Color] object.
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    final cleanHex = hexString.replaceFirst('#', '');

    if (cleanHex.length == 6) {
      buffer.write('FF'); // Default alpha value (fully opaque)
    }

    buffer.write(cleanHex);
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Converts the [Color] object to a hex string in the format "#AARRGGBB"
  String toHex({bool leadingHashSign = true}) {
    return '${leadingHashSign ? '#' : ''}'
        '${value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  /// Converts the [Color] object to a hex string in the format "#RRGGBB"
  /// (without alpha)
  String toHexRgb({bool leadingHashSign = true}) {
    final rgb = value & 0x00FFFFFF;
    return '${leadingHashSign ? '#' : ''}'
        '${rgb.toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }
}
