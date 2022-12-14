part of 'application_life_cycle_cubit.dart';

@freezed
class ApplicationLifeCycleState with _$ApplicationLifeCycleState {
  const factory ApplicationLifeCycleState.resumed() = _Resumed;
  const factory ApplicationLifeCycleState.inactive() = _Inactive;
  const factory ApplicationLifeCycleState.paused() = _Paused;
  const factory ApplicationLifeCycleState.detached() = _Detached;

  const ApplicationLifeCycleState._();

  bool get isResumed => maybeWhen(resumed: () => true, orElse: () => false);
}
