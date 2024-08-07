import 'package:e_commerce_app/features/product/data/data_sources/remote/remote_data_source.dart';
import 'package:e_commerce_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:e_commerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:e_commerce_app/features/product/domain/usecases/get_product.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    ProductRepository,
    GetProductUseCase,
    RemoteDataSource,
    ProductRepositoryImpl,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
