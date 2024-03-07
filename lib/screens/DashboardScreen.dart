import 'package:fitness/models/diet_model.dart';
import 'package:fitness/models/popular_diets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/categories.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static var categories = CategoryModel.getCategories();
  static var diets = DietModel.getDiets();
  static var popularDiets = PopularDietsModel.getPopularDiets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: ListView(
          children: [
            _searchField(),
            const SizedBox(
              height: 40,
            ),
            _buildCategoriesSection(),
            const SizedBox(
              height: 40,
            ),
            _buildRecommendationSection(),
            const SizedBox(
              height: 40,
            ),
            _buildPopularDiets(),
            const SizedBox(height: 40,),
          ],
        ));
  }

  Column _buildPopularDiets() {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text("Popular",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 15,),
              ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      decoration: BoxDecoration(
                          color: popularDiets[index].boxIsSelected ?
                          Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: popularDiets[index].boxIsSelected ? [
                            BoxShadow(
                                color: const Color(0xff1D1617).withOpacity(0.07),
                                offset: const Offset(0, 10),
                                blurRadius: 40,
                                spreadRadius: 0
                            )
                          ] : []
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(
                            popularDiets[index].iconPath,
                            width: 65,
                            height: 65,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                popularDiets[index].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 16
                                ),
                              ),
                              Text(
                                '${popularDiets[index].level} | ${popularDiets[index].duration} | ${popularDiets[index].calorie}',
                                style: const TextStyle(
                                    color: Color(0xff7B6F72),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: (){},
                            child: SvgPicture.asset(
                              'assets/icons/button.svg',
                              width: 30,
                              height: 30,
                            ),
                          )
                        ]
                      )
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 25,
                  ),
                  itemCount: popularDiets.length
              ),
            ],
          );
  }

  Column _buildRecommendationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("Recommendation\nfor diet",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
        ),
        SizedBox(
          height: 240,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 20),
            separatorBuilder: (context, index) => const SizedBox(
              width: 25,
            ),
            itemCount: diets.length,
            itemBuilder: (context, index) {
              return Container(
                  width: 210,
                  decoration: BoxDecoration(
                      color: diets[index].boxColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(diets[index].iconPath),
                        Column(
                          children: [
                            Text(
                              diets[index].name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 16),
                            ),
                            Text(
                              '${diets[index].level} | ${diets[index].duration} | ${diets[index].calorie}',
                              style: const TextStyle(
                                  color: Color(0xff7B6F72),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Container(
                          height: 45,
                          width: 130,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                diets[index].viewIsSelected
                                    ? const Color(0xff9DCEFF)
                                    : Colors.transparent,
                                diets[index].viewIsSelected
                                    ? const Color(0xff92A3FD)
                                    : Colors.transparent
                              ]),
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Text(
                              "View",
                              style: TextStyle(
                                  color: diets[index].viewIsSelected
                                      ? Colors.white
                                      : const Color(0xffC58BF2),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          ),
                        )
                      ]));
            },
          ),
        )
      ],
    );
  }

  Column _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text("Category",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20, right: 20),
              separatorBuilder: (context, index) => const SizedBox(
                width: 25,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Container(
                    width: 100,
                    decoration: BoxDecoration(
                        color: categories[index].boxColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(categories[index].iconPath),
                          ),
                        ),
                        Text(
                          categories[index].name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 14),
                        )
                      ],
                    ));
              },
            )),
      ],
    );
  }

  Container _searchField() {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: const Color(0xff1D1617).withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0.0)
      ]),
      child: TextField(
        decoration: InputDecoration(
            hintText: "Search Pancakes",
            hintStyle: const TextStyle(color: Color(0xffDDDADA), fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset("assets/icons/Search.svg")),
            suffixIcon: Container(
                width: 100,
                child: IntrinsicHeight(
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    const VerticalDivider(
                      color: Colors.black,
                      indent: 10,
                      endIndent: 10,
                      thickness: 0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset('assets/icons/Filter.svg'),
                    ),
                  ]),
                )),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.all(15)),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Breakfast",
        style: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      leading: GestureDetector(
          onTap: () => {},
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: const Color(0xffF7F8F8),
                borderRadius: BorderRadius.circular(10)),
            child: SvgPicture.asset("assets/icons/left_arrow.svg",
                width: 20, height: 20),
          )),
      actions: [
        GestureDetector(
            onTap: () => {},
            child: Container(
              width: 37,
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color(0xffF7F8F8),
                  borderRadius: BorderRadius.circular(10)),
              child: SvgPicture.asset("assets/icons/dots.svg",
                  width: 5, height: 5),
            ))
      ],
    );
  }
}
