import '../enums/data_type.dart';

class Value<T> {
  final String mScreenName;
  final DataType mDataType;
  final T? mData;

  const Value(this.mScreenName, this.mDataType, [this.mData]);
}
