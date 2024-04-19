import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'dart:async';

class ComponentSearchBar extends StatelessWidget {
  const ComponentSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    final Debouncer onSearchDebouncer =
        Debouncer(delay: const Duration(milliseconds: 500));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchBar(
        elevation: MaterialStateProperty.all<double>(2.0),
        shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              );
            }
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            );
          },
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.grey;
          }
          return Colors.white;
        }),
        hintText: 'Cari restoran',
        padding: const MaterialStatePropertyAll<EdgeInsets>(
          EdgeInsets.symmetric(horizontal: 16.0),
        ),
        controller: searchController,
        onChanged: (query) {
          onSearchDebouncer.debounce(() {
            Provider.of<RestaurantProvider>(context, listen: false)
                .searchRestaurant(query);
          });
        },
        leading: const Icon(Icons.search),
      ),
    );
  }
}

class Debouncer {
  Duration delay;
  Timer? _timer;
  VoidCallback? _callback;

  Debouncer({this.delay = const Duration(milliseconds: 500)});

  void debounce(VoidCallback callback) {
    _callback = callback;

    cancel();
    _timer = Timer(delay, flush);
  }

  void cancel() {
    _timer?.cancel();
  }

  void flush() {
    _callback?.call();
    cancel();
  }
}
