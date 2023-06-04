import 'package:country/data/api/country/rest_client.dart';
import 'package:country/data/repository/country/country_repository.dart';
import 'package:elementary/elementary.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [...independentServices, ...dependentServices, ...uiConsumableProviders];
List<SingleChildWidget> independentServices = [
  Provider(
    create: (_) => RestClient.create(),
  ),
  Provider<ThemeWrapper>(
    create: (_) => ThemeWrapper(),
  ),
];
List<SingleChildWidget> dependentServices = [];
List<SingleChildWidget> uiConsumableProviders = [
  ProxyProvider<RestClient, CountryRepository>(
    update: (context, api, viewModel) => CountryRepository(restApi: api),
  ),
  ProxyProvider<RestClient, CountryRepository>(
    update: (context, api, viewModel) => CountryRepository(restApi: api),
  ),
];
