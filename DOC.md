
**FLutter Sdk Version :** sdk: '>=3.4.3 <4.0.0'
Packages:
    **dio: ^5.4.3+1**
        Dio Package used for fetching api details.
    **json_annotation: ^4.9.0**
        json_annotation is used in conjunction with build_runner and json_serializable to generate JSON serialization code.
    **flutter_screenutil: ^5.9.3**
        Flutter ScreenUtil helps in adapting screen and font sizes.
    **hive: ^2.2.3**
    **hive_flutter: ^1.1.0**
        Hive is a lightweight and blazing fast key-value database , storing the favorites id and showing the notification badge
    **shimmer: ^3.0.0**
        Used for Loader Gridview Shimmer
    **connectivity_plus: ^5.0.2**
        Check the internet coneection if internet is not there shows no internet page
    **flutter_launcher_icons: ^0.13.1**
        For adding launcher icons

page navigations
lib
  --app
    --modules
        - splashview.dart --> internetcheckerview.dart
                                        internet == false --> InternetcheckErrorView(internetcheckerview.dart)
                                        internet == true --> tabbarpage_view.dart
                                                    ________________|_______________
                                                    |                              |
                                             home_view.dart            favorites_view.dart
                                                        \                /
                                                ontap the gridtile go to detailsview.dart

