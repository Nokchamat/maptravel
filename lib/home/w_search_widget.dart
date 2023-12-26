import 'package:flutter/material.dart';
import 'package:maptravel/common/enum/search_type.dart';
import 'package:maptravel/home/s_search_plane.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController searchController = TextEditingController();
  SearchType selectedSearchType = SearchType.country; // 초기 선택값 설정

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.only(left: 19, right: 4),
                child: DropdownButton<SearchType>(
                  value: selectedSearchType,
                  underline: Container(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedSearchType = newValue!;
                    });
                  },
                  items: SearchType.values.map((SearchType value) {
                    return DropdownMenuItem<SearchType>(
                      value: value,
                      child: Text(searchTypeKorean[value]!),
                    );
                  }).toList(),
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: TextField(
                controller: searchController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  hintText: '${searchTypeKorean[selectedSearchType]}명을 검색해주세요.',
                  border: InputBorder.none,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchPlaneScreen(
                                    searchText: searchController.text, searchType: selectedSearchType,)));
                      },
                      icon: const Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
