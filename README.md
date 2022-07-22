# flutter_social_demo

A simple social network demo app

## Helpful commands

1) flutter pub run flutter_launcher_icons:main - create app launcher icons from pubspec.yaml configs
2) flutter pub run import_sorter:main - sorts imports

### Caching
Caching is organized via Hive package. 
Caching time - 30 mins
Each object or List of objects are cached in case if 30 mins after last caching process have elapsed  
Refresh screens are bound to cached objects. It is possible to set refresh function make api calls despite cached state

#### SmartRefresher
smart_refresher package throws warnings due to new flutter version