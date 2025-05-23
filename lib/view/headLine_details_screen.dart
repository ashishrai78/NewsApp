import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HeadlineDetailsScreen extends StatefulWidget {

  final String newsImage, newsTitle, newsDescription, newsContent, newsSource, newsAuthor, newsDate;
  HeadlineDetailsScreen({
    required this.newsImage,
    required this.newsTitle,
    required this.newsDescription,
    required this.newsContent,
    required this.newsSource,
    required this.newsAuthor,
    required this.newsDate,
  });
  @override
  State<HeadlineDetailsScreen> createState() => _HeadlineDetailsScreenState();
}

class _HeadlineDetailsScreenState extends State<HeadlineDetailsScreen> {

  final format = DateFormat('MMMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width*1;
    final height = MediaQuery.sizeOf(context).height*1;
    final dateTime = DateTime.parse(widget.newsDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('Back'),
        //backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              Container(
                //color: Colors.blue,
                width: width,
                height: height*.45,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                  child: CachedNetworkImage(imageUrl: widget.newsImage,
                  fit: BoxFit.cover,
                    placeholder: (context, url)=> Center(child: SpinKitFadingCircle(),),
                    errorWidget: (context, url, error)=> Icon(Icons.error_outline,color: Colors.red,),
                  ),
                ),
              ),
              Positioned(
                top: height*.4,
                child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 17,left: 14, right: 14),
                        child: Text(widget.newsTitle,style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 20),
                        maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10,left: 14,right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.newsSource,style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.blue),),
                            Text(format.format(dateTime),style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 15,),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40,left: 15,right: 15),
                        child: Text(widget.newsDescription, style: GoogleFonts.poppins(fontSize: 22),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
