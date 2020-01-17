
class User {
  String password;
  String token;
  String username;

	User.fromJsonMap(Map<String, dynamic> map):
		password = map["password"],
		token = map["token"],
		username = map["username"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['password'] = password;
		data['token'] = token;
		data['username'] = username;
		return data;
	}
}
