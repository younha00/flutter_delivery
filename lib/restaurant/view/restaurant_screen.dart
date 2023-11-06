// ignore_for_file: avoid_unnecessary_containers

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery/common/const/data.dart';
import 'package:flutter_delivery/common/dio/dio.dart';
import 'package:flutter_delivery/restaurant/component/restaurant_card.dart';
import 'package:flutter_delivery/restaurant/model/restaurant_model.dart';
import 'package:flutter_delivery/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_delivery/restaurant/view/restaurant_detail_screen.dart';
import 'package:gap/gap.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List<RestaurantModel>> paginateRestaurant() async {
    final dio = Dio();
    dio.interceptors.add(CustomInterceptor(storage: storage),);

    // response는 CursorPagination 클래스의 인스턴스인데, 데이터를 가져오면 리스트로 된 걸 갖고오기 때문
    final response = await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant',).paginate();

    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder<List<RestaurantModel>>(
            future: paginateRestaurant(),
            builder: (context, AsyncSnapshot<List> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.separated(
                separatorBuilder: (_, index) => const Gap(16),
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  final pItem = snapshot.data![index];


                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => RestaurantDetailScreen(
                            id: pItem.id,
                          ),
                        ),
                      );
                    },
                    child: RestaurantCard.fromModel(
                      model: pItem,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
