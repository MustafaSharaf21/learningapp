import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learningapp/core/constants.dart';
import '../../data/http.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../data/models/Getx_Controller.dart';
import 'creat_post.dart';
import 'get_comments.dart';

class GetPosts extends StatefulWidget {
  @override
  State<GetPosts> createState() => _GetPostsState();
}

class _GetPostsState extends State<GetPosts> {
  List<dynamic> posts = [];
  List<dynamic> getcomments = [];
  bool isLoading = true;
  bool isLoading2 = true;

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    final roleId = Get.find<UserRoleController>().roleId.value;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kcolor,
        title: Text('Posts'),
        actions: [

          roleId == 2
              ?IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreatePostPage()),
               );
            },
          ):
          const SizedBox.shrink(),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Loading indicator
          : ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return _PostWidget(post: posts[index]);
        },
      ),
    );
  }

  Widget _PostWidget({required dynamic post}) {
    final DateTime createdAt = DateTime.parse(post['created_at']);
    final String timeAgo = timeago.format(createdAt, locale: 'custom');
    TextEditingController commentController = TextEditingController();
    bool _isCommenting = false;
    bool _isLiked = post['is_liked'] ?? false;

    // Variable to manage text expansion
    bool _isTextExpanded = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          margin: EdgeInsets.only(bottom: 8, left: 10, right: 10), // المسافة من اليمين واليسار
          padding: EdgeInsets.only(bottom: 8.0), // إضافة مسافة داخلية للكومبوننت
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // تغيير موقع الظل
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0), // تقليل المسافة الأفقية
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: post['auther image'] != null
                            ? Image.network(
                          '$imgURL' + post['auther image'],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/post.jpg',
                              fit: BoxFit.cover,
                            );
                          },
                        ).image
                            : AssetImage('assets/images/post.jpg'),
                      ),
                    ),
                    SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              post['auther name'] ?? 'اسم الشخص', // تعديل المفتاح إلى `author_name`
                              style: TextStyle(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined, color: Kcolor),
                              Text(
                                post['auther country'] ?? 'البلد',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Post Image
              Container(
                padding: EdgeInsets.symmetric(horizontal: 0.0), // إبعاد الصورة عن النصوص
                height: 145.0,
                width: double.infinity,
                child: ClipRRect(
                  child: Image.network(
                    post['image_url'] != null
                        ? '$imgURL' + post['image_url']
                        : 'assets/images/post.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/post.jpg',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
              // Actions
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        _isLiked ? Icons.favorite : Icons.favorite_border,
                        color: Kcolor,
                      ),
                      onPressed: () async {
                        await _sendLike(post['id']);
                        setState(() {
                          _isLiked = !_isLiked; // Toggle the like state
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.comment_outlined, color: Kcolor),
                      onPressed: () {
                        setState(() {
                          _isCommenting = !_isCommenting; // Toggle comment input
                        });
                      },
                    ),
                  ],
                ),
              ),
              // Post Text
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        post['text'],
                        maxLines: _isTextExpanded ? null : 2, // Show full text if expanded
                        overflow: _isTextExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                      ),
                    ),
                    if (post['text'].length > 100) // Show "Read more" if text is long
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isTextExpanded = !_isTextExpanded;
                          });
                        },
                        child: Text(
                          _isTextExpanded ? 'Show less' : 'Show more',
                          style: TextStyle(color: Kcolor),
                        ),
                      ),
                    SizedBox(height: 0.0), // تقليل المسافة بين النصوص
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostCommentsPage(postId: post['id']),
                          ),
                        );
                      },
                      child: Text('View all comments', style: TextStyle(color: Kcolor)),
                    ),
                    SizedBox(height: 0.0), // تقليل المسافة بين النصوص
                    Row(
                      children: [
                        SizedBox(width: 8),
                        FaIcon(
                          FontAwesomeIcons.clock, // ساعة من Font Awesome
                          size: 20.0,
                          color: Kcolor,
                        ),
                        SizedBox(width: 6),
                        Text(timeAgo),
                      ],
                    ),
                    if (_isCommenting) ...[
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              // تحديد الارتفاع الدائري
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(30.0), // تحديد نصف القطر للدائرة
                              ),
                              child: TextField(
                                controller: commentController,
                                decoration: InputDecoration(
                                  hintText: 'Add a comment...',
                                  border: InputBorder.none, // إزالة الحدود الافتراضية
                                  isDense: true, // تقليل المسافة الرأسية
                                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), // تقليل المسافة الداخلية
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.send, color: Kcolor),
                            onPressed: () async {
                              await _sendComment(commentController.text, post['id']);
                              setState(() {
                                _isCommenting = false;
                                commentController.clear(); // Clear the text field
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> fetchPosts() async {
    try {
      final response = await HttpHelper.gettData(url: 'blog/getposts');
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'] as List;
        setState(() {
          posts = data;
          isLoading = false;
        });
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchComments() async {
    try {
      final response = await HttpHelper.gettData(url: 'blog/getcomments/');
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'] as List;
        setState(() {
          getcomments = data;
          isLoading2 = false;
        });
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _sendComment(String commentText, int postId) async {
    try {
      final response = await HttpHelper.postData(
        url: 'blog/createcomment',
        body: {
          'text': commentText,
          'post_id': postId.toString(), // Ensure post_id is sent as a string
        },
      );
      final res = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Comment sent successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Kcolor,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to send comment: ${res['message']}',
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _sendLike(int postId) async {
    try {
      final response = await HttpHelper.postData(
        url: 'blog/createlike',
        body: {
          'post_id': postId.toString(), // Ensure post_id is sent as a string
        },
      );
      final res = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Like sent successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Kcolor,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to send like: ${res['message']}',
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    }
  }
}
