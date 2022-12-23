import 'package:flutter_utils/core/utils/annotations/int_def.dart';

@IntDef([
  ReplacerType.NONE,
  ReplacerType.INSERT,
  ReplacerType.DELETE,
  ReplacerType.RELOAD,
  ReplacerType.UPDATE,
  ReplacerType.RELOAD_RECENT_SEARCH_ITEMS
])
class ReplacerType {
  static const int NONE = 15000;
  static const int DELETE = 15001;
  static const int INSERT = 15002;
  static const int RELOAD = 15003;
  static const int UPDATE = 15004;
  static const int RELOAD_RECENT_SEARCH_ITEMS = 16001;
}
