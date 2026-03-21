
import 'package:flutter/material.dart';
import 'package:news/home/category_details/source_name.dart';
import 'package:news/model/source_response.dart';
import 'package:news/utils/app_colors.dart';

class SourceTabWidget extends StatefulWidget {
 final List<Source> sourcesList;

  const SourceTabWidget({super.key, required this.sourcesList});

  @override
  State<SourceTabWidget> createState() => _SourceTabWidgetState();
}

class _SourceTabWidgetState extends State<SourceTabWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: widget.sourcesList.length,
        child: Column(
          children: [
            TabBar(
                isScrollable: true,
                indicatorColor: Theme.of(context).indicatorColor,
                dividerColor: AppColors.transparentColor,
                tabAlignment: TabAlignment.start,
                onTap: (index) {
                  selectedIndex = index;
                  setState(() {});
                },
                tabs: widget.sourcesList.map(
                  (source) {
                    return SourceName(
                        source: source,
                        isSelected: selectedIndex ==
                            widget.sourcesList.indexOf(source));
                  },
                ).toList()),
            
          ],
        ));
  }
}
