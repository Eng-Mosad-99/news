import 'package:flutter/material.dart';
import 'package:news/home/category_fragment/widgets/category_item.dart';
import 'package:news/model/category.dart';
typedef OnCategoryItemClick = void Function(Category category);
class CategoryFragment extends StatelessWidget {
   CategoryFragment({super.key , required this.onCategoryItemClick});
 List<Category> categoriesList = [];
 OnCategoryItemClick onCategoryItemClick;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
      categoriesList = Category.getCategoriesList(true);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Good Morning\nHere is Some News For You',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        //todo: show category details
                        onCategoryItemClick(categoriesList[index]);
                      },
                      child: CategoryItem(
                       index: index,
                       category: categoriesList[index],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: height * 0.02,
                    );
                  },
                  itemCount: categoriesList.length))
        
        ],
      ),
    );
  }
}