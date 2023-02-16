import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/auth.dart';
import '../services/auth.dart';

final userDataProvider = FutureProvider((ref) async {
  return ref.watch(userProvider);
});

