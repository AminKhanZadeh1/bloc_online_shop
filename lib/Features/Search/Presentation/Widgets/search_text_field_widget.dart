import 'package:bloc_online_shop/Features/Search/Presentation/Blocs/search_bloc/search_bloc.dart';
import 'package:bloc_online_shop/Features/Search/Presentation/Blocs/search_bloc/search_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTextFieldWidget extends StatefulWidget {
  final TextEditingController searchController;
  const SearchTextFieldWidget({required this.searchController, super.key});

  @override
  State<SearchTextFieldWidget> createState() => _SearchTextFieldWidgetState();
}

class _SearchTextFieldWidgetState extends State<SearchTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 80,
      child: TextField(
        onChanged: (value) {
          context.read<SearchBloc>().add(SearchQueryChanged(value));
        },
        controller: widget.searchController,
        cursorColor: Colors.amber,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(15)),
            filled: true,
            hintText: widget.searchController.text.isEmpty ? 'Search' : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            hintStyle: TextStyle(color: Colors.grey.shade400),
            fillColor: Colors.grey.shade800,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            )),
      ),
    );
  }
}
