import 'package:clean_flutter/domain/location/location_model.dart';

abstract class ILocationService {
  Stream<LocationModel> get positionStream;
}
