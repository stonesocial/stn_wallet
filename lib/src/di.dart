import 'package:dependencies/dependencies.dart';

import 'di.config.dart';

@injectableInit
void configureDependencies() => locator.init();