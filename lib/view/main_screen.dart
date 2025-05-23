import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/model/category_news_model.dart';
import 'package:newsapp/model/news_headlines_model.dart';
import 'package:newsapp/view/category_screen.dart';
import 'package:newsapp/view/headLine_details_screen.dart';
import 'package:newsapp/view_model/news_view_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}
NewsViewModel newsViewModel = NewsViewModel();
enum FilterNewList {bbcNews, theHindu, abcNews, bbcSports, news24, cryptoCoinsNews, googleNews, theNextWeb}


class _MainScreenState extends State<MainScreen> {
  FilterNewList? selectedMenu;
  String channelsName = 'bbc-news';
  final format = DateFormat('MMMM dd, yyyy');


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width*1;
    final height = MediaQuery.sizeOf(context).height*1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryScreen()));
        }, icon: Icon(Icons.category_outlined,color: Colors.white,)),
        actions:  [
          PopupMenuButton<FilterNewList>(
            iconColor: Colors.black,
            initialValue: selectedMenu,
              onSelected: (FilterNewList item){
              if(FilterNewList.bbcNews.name == item.name){
                channelsName = 'bbc-news';
              }
              if(FilterNewList.theHindu.name == item.name){
                channelsName = 'the-hindu';
              }
              if(FilterNewList.abcNews.name == item.name){
                channelsName = 'abc-news';
              }
              if(FilterNewList.bbcSports.name == item.name){
                channelsName = 'bbc-sport';
              }
              if(FilterNewList.news24.name == item.name){
                channelsName = 'news24';
              }
              if(FilterNewList.cryptoCoinsNews.name == item.name){
                channelsName = 'crypto-coins-news';
              }
              if(FilterNewList.googleNews.name == item.name){
                channelsName = 'google-news';
              }
              if(FilterNewList.theNextWeb.name == item.name){
                channelsName = 'the-next-web';
              }
              setState(() {

              });
              },
              itemBuilder: (context)=> <PopupMenuEntry<FilterNewList>>[
                PopupMenuItem<FilterNewList>(
                  child: Text('BBC news',style: TextStyle(fontWeight: FontWeight.w600),),
                  value: FilterNewList.bbcNews,
                ),
                PopupMenuItem<FilterNewList>(
                  child: Text('The Hindu',style: TextStyle(fontWeight: FontWeight.w600),),
                  value: FilterNewList.theHindu,
                ),
                PopupMenuItem<FilterNewList>(
                  child: Text('abc News',style: TextStyle(fontWeight: FontWeight.w600),),
                  value: FilterNewList.abcNews,
                ),
                PopupMenuItem<FilterNewList>(
                  child: Text('BBC Sports',style: TextStyle(fontWeight: FontWeight.w600),),
                  value: FilterNewList.bbcSports,
                ),
                PopupMenuItem<FilterNewList>(
                  child: Text('news24',style: TextStyle(fontWeight: FontWeight.w600),),
                  value: FilterNewList.news24,
                ),
                PopupMenuItem<FilterNewList>(
                  child: Text('Crypto Coins News',style: TextStyle(fontWeight: FontWeight.w600),),
                  value: FilterNewList.cryptoCoinsNews,
                ),
                PopupMenuItem<FilterNewList>(
                  child: Text('Google News',style: TextStyle(fontWeight: FontWeight.w600),),
                  value: FilterNewList.googleNews,
                ),
                PopupMenuItem<FilterNewList>(
                  child: Text('The Next Web',style: TextStyle(fontWeight: FontWeight.w600),),
                  value: FilterNewList.theNextWeb,
                ),
          ])
        ],
        centerTitle: true,
        title: Text('ShotNews',style: GoogleFonts.poppins(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: width,
              height: height*.52,
              child: FutureBuilder<NewsHeadlinesModel?>(
                future: newsViewModel.fetchNewsHeadlinesApi(channelsName),
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
                        Icon(Icons.error_outline_outlined,color: Colors.red,)
                      ],
                    ),);
                  }else{
                    return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        scrollDirection: Axis.horizontal,
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
                              child: Stack(
                                children: [
                                  Container(
                                    width: width*.8,
                                    height: height*.9,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width*.03,
                                        vertical: height*.02
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url)=> Container(child: spinkit2,),
                                        errorWidget: (context, url, error)=> Icon(Icons.error_outline,color: Colors.red,),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: height*.05,
                                    left: width*.05,
                                    child: Card(
                                        elevation: 5,
                                        shadowColor: Colors.blueGrey,
                                        child: Container(
                                          width: width*.6,
                                          height: height*.13,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 5,left: 8,right: 8),
                                                child: Text(snapshot.data!.articles![index].title.toString(),
                                                  style: GoogleFonts.concertOne(fontWeight: FontWeight.bold),
                                                  maxLines: 3,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Text(snapshot.data!.articles![index].source!.name.toString(),
                                                      style: GoogleFonts.oswald(color: Colors.blue),
                                                    ),
                                                    Text(format.format(dateTime),
                                                      style: GoogleFonts.oswald(),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }
              ),
            ),
            FutureBuilder<CategoriesNewsModel?>(
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
                      Icon(Icons.error_outline_outlined,color: Colors.red,)
                    ],
                  ),);
                }else{
                  return Container(
                    width: width,
                    height: height*16.5,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.articles!.length,
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
                        }),
                  );
                }
              }
            ),
          ],
        ),
      ),
    );
  }
}
const spinkit2 = SpinKitFadingCircle(
  color: Colors.orange,
  size: 50,
);