import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_marker/screens/add%20marker/add_marker.dart';
import '../../utils/calculate_time_ago.dart';
import '../../utils/photo_view.dart';

class MarkerDetailsWidget extends StatefulWidget {
  const MarkerDetailsWidget({Key? key,required this.imgUrl,required this.title,required this.time,required this.des,required this.id,this.markDes}) : super(key: key);
  final String imgUrl;
  final String title;
  final String time;
  final String des;
  final String id;
  final String? markDes;

  @override
  State<MarkerDetailsWidget> createState() => _MarkerDetailsWidgetState();
}

class _MarkerDetailsWidgetState extends State<MarkerDetailsWidget> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        elevation: 0,
        actions: [
          ElevatedButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AddMarkerScreen(sourceImage: widget.imgUrl, id: widget.id))),
              child: Text('Add Mark',style: TextStyle(color: Colors.white)))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          InkWell(
            onTap: (){
              Navigator.of(context).push(
                  PageRouteBuilder(
                    opaque: false, // set to false
                    pageBuilder: (_, __, ___) => PhotoViewWidget(imgUrl: widget.imgUrl)));
              },
            child: Container(
                height: size.height /3,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
                ),
                child:  CachedNetworkImage(
                  imageUrl: widget.imgUrl,
                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
            ),
          ),
            const SizedBox(height: 16),
            Text("Name",style: Theme.of(context).textTheme.caption,),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: size.width/1.5,
                    child: Text(widget.title,overflow:TextOverflow.ellipsis,maxLines:2,style: Theme.of(context).textTheme.headline5,)),
                Text(CalculateTimeAgo.timeAgo(DateTime.parse(widget.time)),style: Theme.of(context).textTheme.caption,),
              ],
            ),
            const SizedBox(height: 12),
            Text("Description",style: Theme.of(context).textTheme.caption,),
            Text(widget.des,style: Theme.of(context).textTheme.bodyText1,),
            const SizedBox(height: 12),
            Text("Mark Description",style: Theme.of(context).textTheme.caption,),
            if(widget.markDes !=null) Text(widget.markDes!,style: Theme.of(context).textTheme.bodyText2,),
          ],
        ),
      ),
    );
  }
}
