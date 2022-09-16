
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_marker/data/firebase/firebase_service.dart';
import 'package:image_marker/screens/marker%20details/details_widget.dart';
import '../../../utils/calculate_time_ago.dart';

class ImageListWidget extends StatefulWidget {
  const ImageListWidget({Key? key}) : super(key: key);

  @override
  State<ImageListWidget> createState() => _ImageListWidgetState();
}

class _ImageListWidgetState extends State<ImageListWidget> {
  final Stream<QuerySnapshot> markerImagesStream = FirebaseService().markerImages.snapshots();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: markerImagesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            Fluttertoast.showToast(msg: "Error to loading list");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final List markerImagesdocs = [];
          snapshot.data?.docs.map((DocumentSnapshot document) {
             Map a = document.data() as Map<String, dynamic>;
            markerImagesdocs.add(a);
            a['id'] = document.id;
          }).toList();
          return Expanded(
              child: markerImagesdocs.length==0 ? Center(child: Text('Empty Gallery',style: Theme.of(context).textTheme.headline5,)) :GridView.builder(
                  physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
              itemCount: markerImagesdocs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.7,
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context,int index){
                return InkWell(
                  onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> MarkerDetailsWidget(imgUrl: "${markerImagesdocs[index]['imgUrl']}",
                    title: "${markerImagesdocs[index]['name']}",
                    time: "${markerImagesdocs[index]['createdAt']}",
                    des: "${markerImagesdocs[index]['des']}",
                    id: "${markerImagesdocs[index]['id']}",
                    markDes: markerImagesdocs[index]['isMark'] ?markerImagesdocs[index]['markDes'] :null,
                  ))),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CachedNetworkImage(
                            imageUrl: markerImagesdocs[index]['imgUrl'],fit: BoxFit.cover,height: size.height*0.1,width: size.width,
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          )),
                        const SizedBox(height: 4),
                        Text(markerImagesdocs[index]['isMark'] ? 'Marked' :'Not Marketed',style: Theme.of(context).textTheme.caption,),
                        const SizedBox(height: 4),
                        Text(markerImagesdocs[index]['name'],overflow:TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyText1,),
                        const SizedBox(height: 4),
                        Text(CalculateTimeAgo.timeAgo(DateTime.parse(markerImagesdocs[index]['createdAt'])),style: Theme.of(context).textTheme.caption,),
                      ]),
                );
              }));
        });
  }
}


