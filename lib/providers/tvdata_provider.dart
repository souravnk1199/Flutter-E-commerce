import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_catalog_provider/models/tv_model.dart';

final choiceList = [
  'Up to 30"',
  '31" - 40"',
  '41" - 50"',
  '51" - 60"',
  '61" & Above'
];

/* ----------------------------------- FETCH TV DATA ------------------------------------ */
final fetchTvModelsProvider = FutureProvider<List<TVModel>>((ref) async {
  final url =
      Uri.https('tv-catalog-da551-default-rtdb.firebaseio.com', 'tvData.json');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    return jsonData.map((json) => TVModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load data');
  }
});

/* ----------------------------------- TV DATA PROVIDER ------------------------------------ */
class TvDataNotifier extends StateNotifier<List<TVModel>> {
  TvDataNotifier(super.state);

  // void limitedToOutOfStock(int id, int selectedIndex) {
  //   List<TVModel> temp = state;
  //   temp[id - 1].stock[selectedIndex] = 0;
  //   state = temp;
  // }
}

final tvDataProvider = StateNotifierProvider<TvDataNotifier, List<TVModel>>(
  (ref) {
    late List<TVModel> tvData;
    ref.watch(fetchTvModelsProvider).when(
      data: (data) {
        tvData = data;
      },
      error: (error, stacktrace) {
        print(error);
        tvData = [];
      },
      loading: () {
        tvData = [];
      },
    );

    return TvDataNotifier(tvData);
  },
);

/* ----------------------------------- INDEX PROVIDER ------------------------------------ */
class SelectedTvSizeIndexNotifier extends StateNotifier<List<int>> {
  SelectedTvSizeIndexNotifier(super.state);

  void changeIndex(int id, int index) {
    List<int> temp = List.from(state); // [...state]
    temp[id - 1] = index;
    state = temp;
  }
}

final selectedTvSizeIndexProvider =
    StateNotifierProvider<SelectedTvSizeIndexNotifier, List<int>>(
  (ref) {
    int length = ref.watch(tvDataProvider).length;
    return SelectedTvSizeIndexNotifier(List.generate(length, (index) => 0));
  },
);

/* ----------------------------------- QUANTITY PROVIDER ------------------------------------ */
class SelectedTvQuantityNotifier extends StateNotifier<List<int>> {
  SelectedTvQuantityNotifier(super.state);

  void changeQuantity(int id, int num) {
    List<int> temp = List.from(state); // [...state]
    temp[id - 1] = num;
    state = temp;
  }
}

final selectedTvQuantityProvider =
    StateNotifierProvider<SelectedTvQuantityNotifier, List<int>>(
  (ref) {
    int length = ref.watch(tvDataProvider).length;
    return SelectedTvQuantityNotifier(List.generate(length, (index) => 1));
  },
);

/* ----------------------------------- FAVOURITE TV PROVIDER ------------------------------------ */
class FavouriteTvNotifier extends StateNotifier<List<bool>> {
  FavouriteTvNotifier(super.state);

  void toggleFavourite(int id) {
    List<bool> temp = List.from(state);
    temp[id - 1] = !temp[id - 1];
    state = temp;
  }
}

final favouriteTvProvider =
    StateNotifierProvider<FavouriteTvNotifier, List<bool>>(
  (ref) {
    int length = ref.watch(tvDataProvider).length;
    return FavouriteTvNotifier(List.generate(length, (index) => false));
  },
);

/* ----------------------------------- SHOW SIZE PROVIDER ------------------------------------ */
class ShowTvSizeNotifier extends StateNotifier<List<bool>> {
  ShowTvSizeNotifier(super.state);

  void toggleShowsize(int id) {
    List<bool> temp = List.from(state);
    temp[id - 1] = !temp[id - 1];
    state = temp;
  }
}

final showTvSizesProvider =
    StateNotifierProvider<ShowTvSizeNotifier, List<bool>>(
  (ref) {
    int length = ref.watch(tvDataProvider).length;
    return ShowTvSizeNotifier(List.generate(length, (index) => true));
  },
);

/* ----------------------------------- FILTERS PROVIDERS ------------------------------------ */
final searchProvider = StateProvider<String>((ref) => '');

final selectedTvSizeFilterProvider = StateProvider<int?>((ref) => null);

final onPrimeTvFilterProvider = StateProvider<bool>((ref) => false);

final selectedTvBrandsFilterProvider = StateProvider<List<String>>((ref) => []);

final tvBrandsProvider = StateProvider<Set<String>>(
  (ref) {
    final tvData = ref.watch(tvDataProvider);
    Set<String> brands = {};
    for (var tv in tvData) {
      brands.add(tv.brand);
    }
    return brands;
  },
);

/* ----------------------------------- FILTERED TVDATA PROVIDER ------------------------------------ */
final filteredTvdataProvider = StateProvider<List<TVModel>>(
  (ref) {
    final originalList = ref.watch(tvDataProvider);
    final searchString = ref.watch(searchProvider);
    final sizeFilter = ref.watch(selectedTvSizeFilterProvider);
    final onPrime = ref.watch(onPrimeTvFilterProvider);
    final selectedBrands = ref.watch(selectedTvBrandsFilterProvider);
    if (searchString.trim() == '' &&
        sizeFilter == null &&
        !onPrime &&
        selectedBrands.isEmpty) {
      return originalList;
    } else {
      List<TVModel> filteredList;
      if (searchString.trim() != '') {
        filteredList = originalList.where((tv) {
          return tv.name
              .toLowerCase()
              .contains(searchString.trim().toLowerCase());
        }).toList();
      } else {
        filteredList = [...originalList];
      }

      if (onPrime) {
        filteredList = filteredList.where((tv) {
          return tv.onPrime;
        }).toList();
      }
      if (sizeFilter != null) {
        // 0 - size under 30
        // 1 - size between 31-40
        // 2 - size between 41-50
        // 3 - size between 51-60
        // 4 - size above 60
        filteredList = filteredList.where((tv) {
          return checkSizeFilter(tv, sizeFilter);
        }).toList();
      }
      if (selectedBrands.isNotEmpty) {
        filteredList = filteredList.where((tv) {
          return selectedBrands.contains(tv.brand);
        }).toList();
      }
      return filteredList;
    }
  },
);

bool checkSizeFilter(TVModel tv, int sizeFilter) {
  // Extract the selected size range based on sizeFilter
  int minSize;
  int maxSize;

  switch (sizeFilter) {
    case 0: // "Up to 30"
      minSize = 0;
      maxSize = 30;
      break;
    case 1: // "31" - 40"
      minSize = 31;
      maxSize = 40;
      break;
    case 2: // "41" - 50"
      minSize = 41;
      maxSize = 50;
      break;
    case 3: // "51" - 60"
      minSize = 51;
      maxSize = 60;
      break;
    case 4: // "61" & Above
      minSize = 61;
      maxSize = 100; // Adjust this as needed
      break;
    default:
      return true; // No filter selected, so no filtering needed
  }

  // Check if any of the TV sizes in the list are within the selected size range
  for (int size in tv.sizes) {
    if (size >= minSize && size <= maxSize) {
      return true; // At least one size matches the selected range
    }
  }

  return false; // No size matches the selected range
}
