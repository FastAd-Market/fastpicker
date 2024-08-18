# fastpicker

This is the official intuitive photo and video picker for FastAd. It supports multiple photos and videos selection on iOS and Android.

```dart
FastPicker(
  theme: Theme.of(context),
  selectedAssets: ['asset_id_1', 'asset_id_2'],
  strings: FastPickerStrings(),
);
```

You can choose to present it as a route 

```dart
final assets = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return FastPicker(
            theme: Theme.of(context),
          );
        },
      ),
    );
```

or use it as you would any widget

```dart
child: FastPicker(
  theme: Theme.of(context),
  selectedAssets: [],
  strings: FastPickerStrings(),
  onComplete: (assets) {},
);
```

Theme colorSchemes

```dart 
 tertiaryContainer,
 tertiary,
 primaryContainer,
 onPrimaryContainer,
 onPrimary
```
