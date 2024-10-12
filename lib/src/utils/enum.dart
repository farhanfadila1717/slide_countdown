/// {@template slide_direction}
/// An enum for representing the direction of a slide animation.
/// {@endtemplate}
enum SlideDirection {
  /// Represents the slide up animation.
  up,

  /// Represents the slide down animation.
  down,

  /// Represents the absence of a slide animation.
  none,
}

/// {@template separator_type}
/// An enum class to represent different types of separators.
/// {@endtemplate}
enum SeparatorType {
  /// Represents a separator with a symbol.
  symbol,

  /// Represents a separator with a title.
  title,
}

/// {@template time_unit}
/// An enum class to represent different time unit of item.
/// {@endtemplate}
enum TimeUnit {
  /// Represents days as a unit of time.
  days,

  /// Represents hours as a unit of time.
  hours,

  /// Represents minutes as a unit of time.
  minutes,

  /// Represents seconds as a unit of time.
  seconds,
}

/// {@template digit_type}
/// An enum class to represent digit types of item.
/// {@endtemplate}
enum DigitType {
  /// Represents the thousands digit for days.
  daysThousand,

  /// Represents the hundreds digit for days.
  daysHundred,

  /// Represents the first digit.
  first,

  /// Represents the second digit.
  second,
}
