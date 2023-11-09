import 'package:flutter/material.dart';
import 'package:maptravel/common/constant/app_colors.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.brightGrey,
            borderRadius: BorderRadius.circular(20)
        ),
        child: const TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              hintText: '도시 이름을 검색해주세요.',
              border: InputBorder.none,
              icon: Padding(
                  padding: EdgeInsets.only(left: 13),
                  child: Icon(Icons.search))),
        ),
      ),
    );
  }
}
