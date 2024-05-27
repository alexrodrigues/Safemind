import 'package:flutter/material.dart';
import 'package:safemind/model/therapist.dart';

class TherapistCard extends StatelessWidget {
  final Therapist model;

  TherapistCard(this.model);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        leading: ClipRRect(
          child: Image.network(
            model.urlImage,
            width: 120.0, // Increased width
            height: 200.0, // Increased height
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
          ),
        ),
        title: Text(
          model.name,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          model.description,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.grey[600],
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
          size: 16.0,
        ),
        onTap: () {
          // Handle card tap
        },
      ),
    );
  }
}
