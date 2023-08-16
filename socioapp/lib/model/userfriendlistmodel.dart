class UserFriendListModel {
  String user_list_id;
  String userId;
  String friendId;
  String requestedBy;
  String postedat;
  bool hasNewRequest;
  bool hasNewRequestAccepted;
  bool hasRemoved;

  UserFriendListModel({
    required this.user_list_id,
    required this.userId,
    required this.friendId,
    required this.requestedBy,
    required this.postedat,
    required this.hasNewRequest,
    required this.hasNewRequestAccepted,
    required this.hasRemoved,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_list_id': user_list_id,
      'user_id': userId,
      'friend_Id': friendId,
      'requested_by': requestedBy,
      'posted_at': postedat,
      'has_new_request': hasNewRequest,
      'has_new_request_accepted': hasNewRequestAccepted,
      'has_removed': hasRemoved,
    };
  }

  factory UserFriendListModel.fromJson(Map<String, dynamic> json) {
    return UserFriendListModel(
        user_list_id: json['user_list_id'],
        userId: json['userId'],
        friendId: json['friendId'],
        requestedBy: json['requestedBy'],
        postedat: json['postedat'],
        hasNewRequest: json['hasNewRequest'],
        hasNewRequestAccepted: json['hasNewRequestAccepted'],
        hasRemoved: json['hasRemoved']);
  }
}

List<UserFriendListModel> requestAcceptorCancle = [];
