class FastPickerStrings {
  final String selectMedia;
  final String limitedPermissionMessage;
  final String manage;
  final String cancel;
  final String changeSettings;
  final String selectMorePhotos;
  final String manageAccessToYourPhotosAndVideos;
  final String toggleMultipleSelectionMode;
  final String toggleAlbumDrawer;
  final String done;
  final String addUpTo10PhotosAndVideos;
  final String loading;
  final String removePhoto;
  final String pleaseAllowAccessToYourPhotos;
  final String allowAccess;
  final String accessToYourPhotosIsRestricted;
  final String youCanAlwaysChangeThisInYourDeviceSettings;
  final String noMedia;
  final String yourPhotosAndVideosWillAppear;

  const FastPickerStrings({
    this.selectMedia = 'Select Media',
    this.limitedPermissionMessage = 'You\'ve allowed access to a selected number of photos and videos.',
    this.manage = 'Manage',
    this.cancel = 'Cancel',
    this.changeSettings = 'Change settings',
    this.selectMorePhotos = 'Select more photos',
    this.manageAccessToYourPhotosAndVideos = 'Manage access to your photos and videos.',
    this.toggleMultipleSelectionMode = 'Toggle multiple selection mode',
    this.toggleAlbumDrawer = 'Toggle album drawer',
    this.done = 'Done',
    this.addUpTo10PhotosAndVideos = 'Add up to 10 photos and videos.',
    this.loading = 'Loading\u2026',
    this.removePhoto = 'Remove photo',
    this.pleaseAllowAccessToYourPhotos = 'Please Allow Access to your Photos',
    this.allowAccess = 'Allow Access',
    this.accessToYourPhotosIsRestricted =
        'Access to your Photos is restricted. Contact your parent or guardian to undo the restriction.',
    this.youCanAlwaysChangeThisInYourDeviceSettings = 'You can always change this in your device settings.',
    this.noMedia = 'No Media',
    this.yourPhotosAndVideosWillAppear = 'Your photos and videos will appear here.',
  });

  FastPickerStrings copyWith({
    String? selectMedia,
    String? limitedPermissionMessage,
    String? manage,
    String? cancel,
    String? changeSettings,
    String? selectMorePhotos,
    String? manageAccessToYourPhotosAndVideos,
    String? toggleMultipleSelectionMode,
    String? toggleAlbumDrawer,
    String? done,
    String? addUpTo10PhotosAndVideos,
    String? loading,
    String? removePhoto,
    String? pleaseAllowAccessToYourPhotos,
    String? allowAccess,
    String? accessToYourPhotosIsRestricted,
    String? youCanAlwaysChangeThisInYourDeviceSettings,
    String? noMedia,
    String? yourPhotosAndVideosWillAppear,
  }) {
    return FastPickerStrings(
      selectMedia: selectMedia ?? this.selectMedia,
      limitedPermissionMessage: limitedPermissionMessage ?? this.limitedPermissionMessage,
      manage: manage ?? this.manage,
      cancel: cancel ?? this.cancel,
      changeSettings: changeSettings ?? this.changeSettings,
      selectMorePhotos: selectMorePhotos ?? this.selectMorePhotos,
      manageAccessToYourPhotosAndVideos: manageAccessToYourPhotosAndVideos ?? this.manageAccessToYourPhotosAndVideos,
      toggleMultipleSelectionMode: toggleMultipleSelectionMode ?? this.toggleMultipleSelectionMode,
      toggleAlbumDrawer: toggleAlbumDrawer ?? this.toggleAlbumDrawer,
      done: done ?? this.done,
      addUpTo10PhotosAndVideos: addUpTo10PhotosAndVideos ?? this.addUpTo10PhotosAndVideos,
      loading: loading ?? this.loading,
      removePhoto: removePhoto ?? this.removePhoto,
      pleaseAllowAccessToYourPhotos: pleaseAllowAccessToYourPhotos ?? this.pleaseAllowAccessToYourPhotos,
      allowAccess: allowAccess ?? this.allowAccess,
      accessToYourPhotosIsRestricted: accessToYourPhotosIsRestricted ?? this.accessToYourPhotosIsRestricted,
      youCanAlwaysChangeThisInYourDeviceSettings:
          youCanAlwaysChangeThisInYourDeviceSettings ?? this.youCanAlwaysChangeThisInYourDeviceSettings,
      noMedia: noMedia ?? this.noMedia,
      yourPhotosAndVideosWillAppear: yourPhotosAndVideosWillAppear ?? this.yourPhotosAndVideosWillAppear,
    );
  }
}
