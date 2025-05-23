import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/model/category_news_model.dart';

import '../view_model/news_view_model.dart';
import 'headLine_details_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

NewsViewModel newsViewModel = NewsViewModel();
List<String> categoryList = ['General', 'Technology', 'Sports', 'Health', ' Business', 'Science', 'Entertainment'];
String categoryName = 'General';


class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    setState(() {

    });
    super.initState();
  }
  final format = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width*1;
    final height = MediaQuery.sizeOf(context).height*1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('CATEGORY',style: GoogleFonts.poppins(fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: height*.01),
            width: width,
            height: height*.07,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryList.length,
                itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.only(left: 5,right: 5),
                child: ElevatedButton(onPressed: (){
                  categoryName = categoryList[index];
                  setState(() {});
                }, style: ElevatedButton.styleFrom(
                  backgroundColor: categoryName == categoryList[index] ? Colors.blueGrey : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22)
                  )
                ),
                    child: Text(categoryList[index].toString(),
                    style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),
                    )),
              );
            }),
          ),
          Expanded(
            child: Container(
              width: width,
              height: height,
              child: FutureBuilder<CategoriesNewsModel?>(
                  future: newsViewModel.fetchCategoryNewsApi(categoryName),
                  builder: (BuildContext context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(
                        child: SpinKitCircle(
                          size: 50,
                          color: Colors.blueGrey,
                        ),
                      );
                    }if(snapshot.hasError){
                      return Center(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Something want wrong',style: TextStyle(fontWeight: FontWeight.bold),),
                          IconButton(onPressed: (){
                            setState(() {

                            });
                          }, icon: Icon(Icons.error_outline),color: Colors.red,)
                        ],
                      ),);
                    }else{
                      return ListView.builder(
                          itemCount: snapshot.data!.articles!.length,
                          //scrollDirection: Axis.vertical,
                          itemBuilder: (context, index){
                            DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                            return InkWell(onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> HeadlineDetailsScreen(
                                newsImage: snapshot.data!.articles![index].urlToImage.toString(),
                                newsTitle: snapshot.data!.articles![index].title.toString(),
                                newsDescription: snapshot.data!.articles![index].description.toString(),
                                newsAuthor: snapshot.data!.articles![index].author.toString(),
                                newsSource: snapshot.data!.articles![index].source!.name.toString(),
                                newsDate: snapshot.data!.articles![index].publishedAt.toString(),
                                newsContent: snapshot.data!.articles![index].content.toString(),
                              )));
                            },
                              child: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Card(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: height*.006),
                                      width: width,
                                      height: height*.17,
                                      //color: Colors.blueGrey,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: width*.25,
                                            height: height*.16,
                                            //color: Colors.blueGrey,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(12),
                                              child: CachedNetworkImage(imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                                fit: BoxFit.cover,
                                                placeholder: (context, url)=> Container(child: SpinKitFadingCircle(color: Colors.orange,size: 30,),),
                                                errorWidget: (context, url, error)=>  Container(child: Icon(Icons.error_outline,color: Colors.red,),),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20,top: 10,bottom: 10),
                                            child: Expanded(
                                              child: Container(
                                                width: width*.62,
                                                //color: Colors.orange,
                                                child: Column(
                                                  children: [
                                                    Text(snapshot.data!.articles![index].title.toString(),
                                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                                                      maxLines: 3,
                                                    ),
                                                    Spacer(),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(snapshot.data!.articles![index].source!.name.toString(),
                                                          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),

                                                        ),
                                                        Text(format.format(dateTime),
                                                          style: GoogleFonts.poppins(fontWeight: FontWeight.w400,color: Colors.blue),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ),
                            );
                          });
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }
}
