import 'package:barberschedule_client/features/home/domain/models/barbershop_model.dart';

abstract class IBarberShopsRepository {
  Future<List<BarberShopModel>?> getBarberShops();
}
