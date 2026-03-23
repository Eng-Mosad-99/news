import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/home/category_details/cubit/category_states.dart';

class CategoryCubit extends Cubit<CategoryState>{
  CategoryCubit() : super(CategoryInitial());
}