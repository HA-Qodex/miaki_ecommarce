import 'package:ecommarce/data/models/product_model.dart';

import 'api_request_service.dart';

class ProductService {

  void getProduct({
    Function()? beforeSend,
    Function(List<ProductModel> data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    const String url = "/products";
    APIRequest(url: url).get(
        beforeSend: () => {
          if (beforeSend != null) beforeSend(),
        },
        onSuccess: (data) => {
          onSuccess!((data as List)
              .map((e) => ProductModel.fromJson(e))
              .toList())
        },
        onError: (error) => {
          if (error != null)
            {
              onError!(error),
            }
        });
  }
}