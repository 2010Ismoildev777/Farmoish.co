class AppLatLong {
  final double lat;
  final double long;

  const AppLatLong({
    required this.lat,
    required this.long,
  });
}

class DushanbeLocation extends AppLatLong {
  const DushanbeLocation({
    super.lat = 38.5598,
    super.long = 68.7870,
  });
}
