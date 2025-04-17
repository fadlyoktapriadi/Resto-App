import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/data/local/local_database_service.dart';
import 'package:resto_app/data/model/detail_restaurant_response.dart';
import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/data/model/restaurant_list_response.dart';
import 'package:resto_app/helper/resto_detail_result_state.dart';
import 'package:resto_app/helper/resto_list_result_state.dart';
import 'package:resto_app/provider/detail/resto_detail_provider.dart';
import 'package:resto_app/provider/favorite/local_database_provider.dart';
import 'package:resto_app/provider/home/resto_list_provider.dart';
import 'mock_restaurant.dart';

class MockApiService extends Mock implements ApiService {}

class MockDatabaseService extends Mock implements LocalDatabaseService {}

void main() {
  late MockApiService mockApiService;
  late RestoListProvider restoListProvider;
  late RestoDetailProvider restoDetailProvider;
  late MockDatabaseService mockDatabaseService;
  late LocalDatabaseProvider localDatabaseProvider;

  setUp(() {
    mockApiService = MockApiService();
    restoListProvider = RestoListProvider(mockApiService);
    restoDetailProvider = RestoDetailProvider(mockApiService);
    mockDatabaseService = MockDatabaseService();
    localDatabaseProvider = LocalDatabaseProvider(mockDatabaseService);
  });

  group('RestoListProvider Tests', () {

    test('Ensure the provider initial state is defined', () {
      expect(restoListProvider.resultState, equals(restoListProvider.resultState as RestoListNoneState));
    });

    test('Should return a list of restaurants when API data', () async {
      final mockRestaurants = mockRestaurantsList;

      when(() => mockApiService.getRestaurantList())
          .thenAnswer((_) async => RestaurantListResponse(
        error: false,
        message: 'success',
        count: mockRestaurantsList.length,
        restaurants: mockRestaurants,
      ));

      await restoListProvider.fetchRestaurantList();

      expect(restoListProvider.resultState, equals(restoListProvider.resultState as RestoListLoadedState));
    });

    test('Should return an error when API data failed', () async {
      const errorMessage = 'Exception: Failed to fetch data';

      when(() => mockApiService.getRestaurantList())
          .thenThrow(Exception("Failed to fetch data"));

      await restoListProvider.fetchRestaurantList();

      expect(restoListProvider.resultState, isA<RestoListErrorState>());
      expect((restoListProvider.resultState as RestoListErrorState).message, equals(errorMessage));
    });

    test('Should return a detail of restaurants when API data', () async {
      final restaurantDetail = mockRestaurantDetail;
      final id = restaurantDetail.id;

      when(() => mockApiService.getDetailRestaurant(id))
          .thenAnswer((_) async => DetailRestaurantResponse(
        error: false,
        message: 'success',
        restaurant: restaurantDetail,
      ));

      await restoDetailProvider.fetchDetailRestaurant(id);

      expect(restoDetailProvider.resultState, equals(restoDetailProvider.resultState as RestoDetailLoadedState));
    });

    test('Should add a restaurant to favorite', () async {
      final restaurant = mockRestaurantsList[0];

      when(() => mockDatabaseService.insertItem(restaurant))
          .thenAnswer((_) async => 1); // Simulate successful insertion

      when(() => mockDatabaseService.getItemById(restaurant.id))
          .thenAnswer((_) async => restaurant); // Simulate fetching the restaurant

      await localDatabaseProvider.saveFavoriteResto(restaurant);
      await localDatabaseProvider.loadFavoriteRestoById(restaurant.id);
      // Verify the database method is called
      verify(() => mockDatabaseService.insertItem(restaurant)).called(1);

      expect(localDatabaseProvider.restaurant?.id, restaurant.id);
    });
  });
}