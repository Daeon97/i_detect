// ignore_for_file: public_member_api_docs

abstract class LocationFailure {
  const LocationFailure({
    required this.message,
  });

  final String message;
}

class LocationServiceDisabledFailure extends LocationFailure {
  const LocationServiceDisabledFailure({
    required super.message,
  });
}

class LocationPermissionDeniedFailure extends LocationFailure {
  const LocationPermissionDeniedFailure({
    required super.message,
  });
}

class LocationPermissionDeniedForeverFailure extends LocationFailure {
  const LocationPermissionDeniedForeverFailure({
    required super.message,
  });
}

class LocationPermissionUnableToDetermineFailure extends LocationFailure {
  const LocationPermissionUnableToDetermineFailure({
    required super.message,
  });
}
