import 'package:authentication_repository/src/exceptions/exceptions.dart';

import '../models/token.dart';

typedef ApiResponse<E extends ApiException> = (Token? data, E? error);
