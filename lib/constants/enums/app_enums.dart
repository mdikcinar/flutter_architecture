enum GenderEnum {
  male,
  female,
}

extension GenderEnumExtension on GenderEnum {
  String get rawValue {
    switch (this) {
      case GenderEnum.male:
        return 'Male';
      case GenderEnum.female:
        return 'Female';
      default:
        return 'Male';
    }
  }
}

enum AppEnums {
  fontFamily,
}

extension AppEnumsExtension on AppEnums {
  String? get rawValue {
    switch (this) {
      case AppEnums.fontFamily:
        return 'Ubuntu';
      default:
        return null;
    }
  }
}
