typedef JsonData = Map<String, dynamic>;

typedef FromJsonGenericFunction<T> = T Function(dynamic value);

typedef ToJsonGenericFunction<T> = Object? Function(T value);
