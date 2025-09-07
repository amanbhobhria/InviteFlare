import 'package:flutter_bloc/flutter_bloc.dart';


abstract class DrawerCommand {}

class DrawerIdle extends DrawerCommand {}
class DrawerOpenRequested extends DrawerCommand {}

class DrawerCubit extends Cubit<DrawerCommand> {
  DrawerCubit() : super(DrawerIdle());

  void requestOpen() => emit(DrawerOpenRequested());

  void reset() => emit(DrawerIdle());
}
