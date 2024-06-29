import 'package:dio/dio.dart';
import 'package:gmap/data/remote/modals/request/Gmap_RequestModal.dart';
import 'package:gmap/data/remote/modals/response/GMap_ResponseModal.dart';

import '../remote/modals/response/formRes.dart';

abstract class AppRepository {
  Future<GmapResponseModel> getRoute(GmapRequestModal requestModal);
  Future<FormResponse> form(FormData formdata);
}
