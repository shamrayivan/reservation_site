import 'package:mwwm/mwwm.dart';
import 'package:reservation_site/dio/standart_error_handler.dart';

class WidgetModelStandard extends WidgetModel {
  WidgetModelStandard()
      : super(
          WidgetModelDependencies(
            errorHandler: StandardErrorHandler(),
          ),
        );
}
