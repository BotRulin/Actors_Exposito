import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '/api/api_service.dart';
import '/models/actor.dart';

class SearchController1 extends GetxController 
{
  TextEditingController searchController = TextEditingController();
  var searchText = ''.obs;
  var foundedActors = <Actor>[].obs;
  var isLoading = false.obs;
  void setSearchText(text) => searchText.value = text;
  void search(String query) async 
  {
    isLoading.value = true;
    foundedActors.value = (await ApiService.getSearchedActors(query)) ?? [];
    isLoading.value = false;
  }
}
