import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

import 'package:crm/Api/emailApi.dart';

class ApiService {
  Handler get handler {
    final router = Router();
    router.mount('/email/', EmailApi().router);

    return router;
  }
}
