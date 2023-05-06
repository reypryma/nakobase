class Profile{
  String? id;
  String? username;
  String? fullName;
  String? avatarUrl;
  String? website;
  String? updatedAt;


  Profile({this.id, this.username, this.fullName, this.avatarUrl, this.website,
      this.updatedAt});

  factory Profile.fromJson(Map<String, dynamic> json){
    return Profile(
      id: json['id'],
      username: json['username'],
      fullName: json['full_name'],
      avatarUrl: json['avatar_url'],
      website: json['website'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (username != null) data['username'] = username;
    if (fullName != null) data['full_name'] = fullName;
    if (avatarUrl != null) data['avatar_url'] = avatarUrl;
    if (website != null) data['avatar_url'] = website;
    return data;
  }
}