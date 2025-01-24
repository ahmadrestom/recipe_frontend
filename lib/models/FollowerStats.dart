class FollowerStats{
  final int? followerCount;
  final int followingCount;

  FollowerStats({required this.followerCount, required this.followingCount});

  factory FollowerStats.fromJson(Map<String, dynamic> json){
    return FollowerStats(
      followerCount: json['followerCount'] as int,
      followingCount: json['followingCount'] as int
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'followerCount': followerCount,
      'followingCount': followingCount
    };
  }
}