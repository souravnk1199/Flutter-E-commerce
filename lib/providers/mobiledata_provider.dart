import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_catalog_provider/models/mobile_model.dart';
import 'package:tv_catalog_provider/providers/tvdata_provider.dart';

/* ----------------------------------- FETCH TV DATA ------------------------------------ */
final fetchMobileModelsProvider =
    FutureProvider<List<MobileModel>>((ref) async {
  final url = Uri.https(
      'tv-catalog-da551-default-rtdb.firebaseio.com', 'mobileData.json');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    return jsonData.map((json) => MobileModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load data');
  }
});

/* ----------------------------------- MOBILE DATA PROVIDER ------------------------------------ */
class MobileDataNotifier extends StateNotifier<List<MobileModel>> {
  MobileDataNotifier(super.state);

  void limitedToOutOfStock(int id, int selectedIndex) {
    List<MobileModel> temp = state;
    temp[id - 1].stock[selectedIndex] = 0;
    state = temp;
  }
}

final mobileDataProvider =
    StateNotifierProvider<MobileDataNotifier, List<MobileModel>>(
  (ref) {
    late List<MobileModel> mobileData;
    ref.watch(fetchMobileModelsProvider).when(
      data: (data) {
        mobileData = data;
      },
      error: (error, stacktrace) {
        print(error);
        mobileData = [];
      },
      loading: () {
        mobileData = [];
      },
    );

    return MobileDataNotifier(mobileData);
  },
);

/* ----------------------------------- SIZE INDEX PROVIDER ------------------------------------ */
class SelectedMobileSizeIndexNotifier extends StateNotifier<List<int>> {
  SelectedMobileSizeIndexNotifier(super.state);

  void changeIndex(int id, int index) {
    List<int> temp = List.from(state); // [...state]
    temp[id - 1] = index;
    state = temp;
  }
}

final selectedMobileSizeIndexProvider =
    StateNotifierProvider<SelectedMobileSizeIndexNotifier, List<int>>(
  (ref) {
    int length = ref.watch(mobileDataProvider).length;
    return SelectedMobileSizeIndexNotifier(List.generate(length, (index) => 0));
  },
);

/* ----------------------------------- COLOR INDEX PROVIDER ------------------------------------ */
class SelectedMobileColorIndexNotifier extends StateNotifier<List<int>> {
  SelectedMobileColorIndexNotifier(super.state);

  void changeIndex(int id, int index) {
    List<int> temp = List.from(state); // [...state]
    temp[id - 1] = index;
    state = temp;
  }
}

final selectedMobileColorIndexProvider =
    StateNotifierProvider<SelectedMobileColorIndexNotifier, List<int>>(
  (ref) {
    int length = ref.watch(mobileDataProvider).length;
    return SelectedMobileColorIndexNotifier(
        List.generate(length, (index) => 0));
  },
);

/* ----------------------------------- QUANTITY PROVIDER ------------------------------------ */
class SelectedMobileQuantityNotifier extends StateNotifier<List<int>> {
  SelectedMobileQuantityNotifier(super.state);

  void changeQuantity(int id, int num) {
    List<int> temp = List.from(state); // [...state]
    temp[id - 1] = num;
    state = temp;
  }
}

final selectedMobileQuantityProvider =
    StateNotifierProvider<SelectedMobileQuantityNotifier, List<int>>(
  (ref) {
    int length = ref.watch(mobileDataProvider).length;
    return SelectedMobileQuantityNotifier(List.generate(length, (index) => 1));
  },
);

/* ----------------------------------- FAVOURITE MOBILE PROVIDER ------------------------------------ */
class FavouriteMobileNotifier extends StateNotifier<List<bool>> {
  FavouriteMobileNotifier(super.state);

  void toggleFavourite(int id) {
    List<bool> temp = List.from(state);
    temp[id - 1] = !temp[id - 1];
    state = temp;
  }
}

final favouriteMobileProvider =
    StateNotifierProvider<FavouriteMobileNotifier, List<bool>>(
  (ref) {
    int length = ref.watch(mobileDataProvider).length;
    return FavouriteMobileNotifier(List.generate(length, (index) => false));
  },
);

/* ----------------------------------- SHOW SIZES PROVIDER ------------------------------------ */
class ShowMobileSizesNotifier extends StateNotifier<List<bool>> {
  ShowMobileSizesNotifier(super.state);

  void toggleShowsize(int id) {
    List<bool> temp = List.from(state);
    temp[id - 1] = !temp[id - 1];
    state = temp;
  }
}

final showMobileSizesProvider =
    StateNotifierProvider<ShowMobileSizesNotifier, List<bool>>(
  (ref) {
    int length = ref.watch(mobileDataProvider).length;
    return ShowMobileSizesNotifier(List.generate(length, (index) => true));
  },
);

/* ----------------------------------- SHOW COLORS PROVIDER ------------------------------------ */
class ShowMobileColorsNotifier extends StateNotifier<List<bool>> {
  ShowMobileColorsNotifier(super.state);

  void toggleShowColor(int id) {
    List<bool> temp = List.from(state);
    temp[id - 1] = !temp[id - 1];
    state = temp;
  }
}

final showMobileColorsProvider =
    StateNotifierProvider<ShowMobileColorsNotifier, List<bool>>(
  (ref) {
    int length = ref.watch(mobileDataProvider).length;
    return ShowMobileColorsNotifier(List.generate(length, (index) => true));
  },
);

/* ----------------------------------- FILTERS PROVIDERS ------------------------------------ */
final selectedMobileSizeFilterProvider = StateProvider<String?>((ref) => null);

final onPrimeMobileFilterProvider = StateProvider<bool>((ref) => false);

final selectedMobileBrandsFilterProvider =
    StateProvider<List<String>>((ref) => []);

final mobileSizesFilterChoiceProvider = StateProvider<Set<String>>(
  (ref) {
    final mobileData = ref.watch(mobileDataProvider);
    Set<String> sizeChoices = {};
    for (var mobile in mobileData) {
      sizeChoices.addAll(mobile.filterList);
    }
    return sizeChoices;
  },
);

final mobileBrandsProvider = StateProvider<Set<String>>(
  (ref) {
    final mobileData = ref.watch(mobileDataProvider);
    Set<String> brands = {};
    for (var tv in mobileData) {
      brands.add(tv.brand);
    }
    return brands;
  },
);

/* -------------------------------- FILTERED MOBILE DATA PROVIDER -------------------------------- */
final filteredMobileDataProvider = StateProvider<List<MobileModel>>(
  (ref) {
    final originalList = ref.watch(mobileDataProvider);
    final searchString = ref.watch(searchProvider);
    final sizeFilter = ref.watch(selectedMobileSizeFilterProvider);
    final onPrime = ref.watch(onPrimeMobileFilterProvider);
    final selectedBrands = ref.watch(selectedMobileBrandsFilterProvider);
    if (searchString.trim() == '' &&
        sizeFilter == null &&
        !onPrime &&
        selectedBrands.isEmpty) {
      return originalList;
    } else {
      List<MobileModel> filteredList;
      if (searchString.trim() != '') {
        filteredList = originalList.where((mobile) {
          bool hasColor = false;
          for (var color in mobile.color) {
            if (color
                .toLowerCase()
                .contains(searchString.trim().toLowerCase())) {
              hasColor = true;
              break;
            }
          }
          return (mobile.name
                  .toLowerCase()
                  .contains(searchString.trim().toLowerCase()) ||
              mobile.longName
                  .toLowerCase()
                  .contains(searchString.trim().toLowerCase()) ||
              hasColor);
        }).toList();
      } else {
        filteredList = [...originalList];
      }

      if (onPrime) {
        filteredList = filteredList.where((mobile) {
          return mobile.onPrime;
        }).toList();
      }

      if (sizeFilter != null) {
        filteredList = filteredList.where((mobile) {
          return mobile.filterList.contains(sizeFilter);
        }).toList();
      }

      if (selectedBrands.isNotEmpty) {
        filteredList = filteredList.where((mobile) {
          return selectedBrands.contains(mobile.brand);
        }).toList();
      }
      return filteredList;
    }
  },
);
