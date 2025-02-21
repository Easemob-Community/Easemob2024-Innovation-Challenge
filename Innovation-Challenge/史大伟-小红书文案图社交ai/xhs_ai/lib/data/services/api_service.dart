import 'dart:collection';

import 'package:retrofit/retrofit.dart';
import '../../data/model/params/ai_param.dart';
import '../../data/model/responses/ai_response.dart';
import '../../app/config.dart';
import '../model/params/ai2_param.dart';
import '../model/responses/ai2_response.dart';
import 'api_methods.dart';
import 'package:dio/dio.dart' hide Headers;
part 'api_service.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST(ApiMethods.chatcompletionPro)
  // @Headers(
  //     "Authorization:Bearer $AI_SCRICT",
  //     "Content-Type:application/json"
  // )
  @Headers(<String, dynamic>{
    'Authorization': "Bearer ${VmAppConfig.aiScrict}",
    'Content-Type': 'application/json',
  })
  Future<AiResponse> chatcompletionPro(@Body() AiParma payload,{@Query("GroupId") int groupId = VmAppConfig.aiGroupId});


  @POST(ApiMethods.chatcompletionV2)
  @Headers(<String, dynamic>{
    'Authorization': "Bearer ${VmAppConfig.aiScrict}",
    'Content-Type': 'application/json',
  })
  Future<Ai2Response> chatcompletionV2(@Body() Ai2Parma payload,{@Query("GroupId") int groupId = VmAppConfig.aiGroupId});

}
