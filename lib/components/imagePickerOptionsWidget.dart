import 'package:flutter/material.dart';

class ImagePickerOptionsWidget extends StatelessWidget {
  final VoidCallback onCameraClick;
  final VoidCallback onGalleryClick;

  ImagePickerOptionsWidget({
    @required this.onCameraClick,
    @required this.onGalleryClick,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      height: 150,
      width: screenSize.width,
      child: Center(
        child: Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: onCameraClick,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.camera_alt,
                        size: 50,
                        color: Colors.yellow[900],
                      ),
                      Text(
                        "Camera",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
                width: 5,
                color: Colors.grey[400],
              ),
              GestureDetector(
                onTap: onGalleryClick,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.photo_library,
                        color: Colors.red,
                        size: 50,
                      ),
                      Text(
                        "Gallery",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
