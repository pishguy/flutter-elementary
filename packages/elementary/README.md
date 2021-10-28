# Elementary

![Elementary Cover](https://i.ibb.co/jgkB4ZN/Elementary-Logo.png)

[![Pub Version](https://img.shields.io/pub/v/elementary?logo=dart&logoColor=white)](https://pub.dev/packages/elementary)
[![Pub Likes](https://badgen.net/pub/likes/elementary)](https://pub.dev/packages/elementary)
[![Pub popularity](https://badgen.net/pub/popularity/elementary)](https://pub.dev/packages/elementary)
![Flutter Platform](https://badgen.net/pub/flutter-platform/elementary)

## Description

This is architecture library with the main goal to split code between different responsibility layers, make code clear,
simple, readable and easy testable.
This approach standing on MVVM architecture pattern and make with the respect to Clean Architecture.

## Overview

This library follow classic mvvm pattern splitting layers. There are Widget as View layer,
WidgetModel as ViewModel layer and Model as Model layer.

### WidgetModel

The key part in this chain of responsibility is the WidgetModel layer, which connects all other layers and represents 
state to Widget. Moreover, it is the source of truth for constructing of the display. By the time build is called
on the widget, the WidgetModel should provide it all data needs to build.
The class representing this layer in the library is named by the same name WidgetModel.
You can represent a state for display as a set of different properties.
In order to clearly highlight the properties used for this purpose, you should use the IWidgetModel interface,
whose subclasses determine what exactly will be provided.
In order to simplify the connection of the display with these properties, you can use StateNotifier.
A change in its state leads to notification of subscribers.

Through all this, the WidgetModel becomes place only for the description of presentation logic:
what interaction happened and what state of properties as a result of this interaction.

In the case with a data loading from the network, for example, the WidgetModel looks like this:

```dart
/// Widget Model for [CountryListScreen]
class CountryListScreenWidgetModel
    extends WidgetModel<CountryListScreen, CountryListScreenModel>
    implements ICountryListWidgetModel {
  final _countryListState = EntityStateNotifier<Iterable<Country>>();
  
  @override
  ListenableState<EntityState<Iterable<Country>>> get countryListState =>
      _countryListState;
  
  /// Some special wm working code this
  /// ...............................................................
  
  Future<void> _loadCountryList() async {
    final previousData = _countryListState.value?.data;
    _countryListState.loading(previousData);

    try {
      final res = await model.loadCountries();
      _countryListState.content(res);
    } on Exception catch (e) {
      _countryListState.error(e, previousData);
    }
  }
}
```

Interface for this WidgetModel looks like this:

```dart
/// Interface of [CountryListScreenWidgetModel]
abstract class ICountryListWidgetModel extends IWidgetModel {
  ListenableState<EntityState<Iterable<Country>>> get countryListState;
}
```

_The only place where we have access and need to interact with the BuildContext is the WidgetModel._

### Model

The only WidgetModel dependency related to business logic is Model.
The class representing this layer in the library naming ElementaryModel.
It's described free. This is done, among other things, in order to make it possible 
to easily combine _elementary_ with others approach, which are aimed only to business logic.

### Widget

Since any logic has already been described in the WidgetModel and Model, the Widget only needs to declare how the 
display should look like in this time based on the WidgetModel properties.
The class representing Widget layer in the library has named ElementaryWidget.
The display is declared in the build method, the only argument of which is the IWidgetModel interface.

It looks like this:

```dart
@override
Widget build(ICountryListWidgetModel wm) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Country List'),
    ),
    body: EntityStateNotifierBuilder<Iterable<Country>>(
      listenableEntityState: wm.countryListState,
      loadingBuilder: (_, __) => const _LoadingWidget(),
      errorBuilder: (_, __, ___) => const _ErrorWidget(),
      builder: (_, countries) => _CountryList(
        countries: countries,
        nameStyle: wm.countryNameStyle,
      ),
    ),
  );
}
```

## Sponsor

Our main sponsor is Surf.

![Elementary Cover](https://surf.ru/wp-content/themes/surf/img/logo.svg)

## Maintainer

[Mikhail Zotyev](https://github.com/MbIXjkee)