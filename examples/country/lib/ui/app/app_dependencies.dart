import 'package:country/provider_setup.dart';
import 'package:country/ui/app/app.dart';
import 'package:country/ui/screen/country_list_screen/country_list_screen_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Widget with dependencies that live all runtime.
class AppDependencies extends StatefulWidget {
  final App app;

  const AppDependencies({required this.app, Key? key}) : super(key: key);

  @override
  State<AppDependencies> createState() => _AppDependenciesState();
}

class _AppDependenciesState extends State<AppDependencies> {
  late final CountryListScreenModel _countryListScreenModel;

  // late final Dio _http;
  // late final DefaultErrorHandler _defaultErrorHandler;
  // late final CountryClient _countryClient;
  // late final CountryRepository _countryRepository;
  // late final CountryListScreenModel _countryListScreenModel;
  late final ThemeWrapper _themeWrapper;

  @override
  void initState() {
    super.initState();
    // _http = Dio();
    // _defaultErrorHandler = DefaultErrorHandler();
    // _countryClient = CountryClient(_http);
    // _countryRepository = CountryRepository(_countryClient);

    // _countryListScreenModel = CountryListScreenModel(
    //   _countryRepository,
    //   _defaultErrorHandler,
    // );
    _themeWrapper = ThemeWrapper();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:providers,
      /*providers: [
        ProxyProvider<RestClient, CountryRepository>(
          update: (context, api, viewModel) => CountryRepository(restApi: api),
        ),
        Provider<CountryListScreenModel>(
          create: (_) => _countryListScreenModel,
        ),
        Provider<ThemeWrapper>(
          create: (_) => _themeWrapper,
        ),
      ],*/
      child: widget.app,
    );
  }
}
