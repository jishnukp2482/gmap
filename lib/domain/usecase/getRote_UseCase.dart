import 'package:gmap/core/usecase.dart';
import 'package:gmap/data/remote/modals/request/Gmap_RequestModal.dart';
import 'package:gmap/data/remote/modals/response/GMap_ResponseModal.dart';
import 'package:gmap/data/repository/app_repository.dart';

class GetRouteUseCase extends UseCase<GmapResponseModel, GmapRequestModal> {
  final AppRepository appRepository;

  GetRouteUseCase(this.appRepository);

  @override
  Future<GmapResponseModel> call(GmapRequestModal params) {
    return appRepository.getRoute(params);
  }
}
