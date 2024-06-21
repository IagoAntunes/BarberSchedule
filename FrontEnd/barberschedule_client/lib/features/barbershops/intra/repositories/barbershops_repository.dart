import 'package:barberschedule_client/core/response/base_service_response.dart';
import 'package:barberschedule_client/features/barbershops/domain/repositories/i_barbershops_repository.dart';
import 'package:barberschedule_client/features/home/domain/models/barbershop_model.dart';

import '../datasource/i_barbershops_datasource.dart';

class BarberShopsRepository implements IBarberShopsRepository {
  BarberShopsRepository({required IBarberShopsDataSource barberShopsDataSource})
      : _barberShopsDataSource = barberShopsDataSource;
  final IBarberShopsDataSource _barberShopsDataSource;
  @override
  Future<List<BarberShopModel>?> getBarberShops() async {
    var result = await _barberShopsDataSource.getBarberShops();
    if (result is SuccessResponseData) {
      List<BarberShopModel> listBarberShop = [];
      for (var barberShop in result.data['data']) {
        listBarberShop.add(BarberShopModel.fromMap(barberShop));
      }
      return listBarberShop;
    } else {
      return null;
    }
  }
}
