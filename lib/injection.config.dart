// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:clean_flutter/application/application_life_cycle/application_life_cycle_cubit.dart'
    as _i3;
import 'package:clean_flutter/application/location/location_cubit.dart' as _i9;
import 'package:clean_flutter/application/permission/permission_cubit.dart'
    as _i8;
import 'package:clean_flutter/domain/location/i_location_service.dart' as _i4;
import 'package:clean_flutter/domain/permission/i_permission_service.dart'
    as _i6;
import 'package:clean_flutter/infrastructure/location/geolocator_location_service.dart'
    as _i5;
import 'package:clean_flutter/infrastructure/permission/permission_service.dart'
    as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.ApplicationLifeCycleCubit>(
        () => _i3.ApplicationLifeCycleCubit());
    gh.factory<_i4.ILocationService>(() => _i5.GeolocatorLocationService());
    gh.lazySingleton<_i6.IPermissionService>(() => _i7.PermissionService());
    gh.lazySingleton<_i8.PermissionCubit>(() => _i8.PermissionCubit(
          gh<_i6.IPermissionService>(),
          gh<_i3.ApplicationLifeCycleCubit>(),
        ));
    gh.factory<_i9.LocationCubit>(() => _i9.LocationCubit(
          gh<_i4.ILocationService>(),
          gh<_i8.PermissionCubit>(),
        ));
    return this;
  }
}
