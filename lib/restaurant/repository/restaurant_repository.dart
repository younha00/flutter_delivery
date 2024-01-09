import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_delivery/common/model/cursor_pagination_model.dart';
import 'package:flutter_delivery/restaurant/model/restaurant_detail_model.dart';
import 'package:retrofit/http.dart';

import '../model/restaurant_model.dart';
part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  // http://$ip/restaurant
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  // http://$ip/restaurant/
  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<RestaurantModel>> paginate();

  // http://$ip/restaurant/:id
  @GET('/{id}')
  @Headers({
    'accessToken': 'true',
  })
  // 실제로 반환되는 자료형이 들어가야함
  Future<RestaurantDetailModel> getRestaurantDetail({
    // 파라미터의 id가 /{id}로 들어감
    @Path() required String id,
  });
}
