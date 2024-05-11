class Status {
  final String user_id;
  final String status;
  final String timestamp;
  final String id;

  Status({
    this.user_id = '',
    required this.status,
    this.timestamp = '',
    this.id = '',
  });

  // Map<String, dynamic> toJson() {
  //   return {
  //     'user_id': int.parse(user_id),
  //     'status': int.parse(status),
  //     'timestamp': int.parse(timestamp),
  //   };
  // }

  factory Status.fromJsonFetch(Map<String, dynamic> json) {
    json = json['status'];
    final user_id = json['user_id'].toString();
    final status = json['status'].toString();
    final timestamp = json['timestamp'].toString();
    final id = json['id'].toString();
    
    return Status(
      user_id: user_id,
      status: status,
      timestamp: timestamp,
      id: id,
    );
  }
  factory Status.fromJson(Map<String, dynamic> json) {
    final user_id = json['user_id'].toString();
    final status = json['status'].toString();
    final timestamp = json['timestamp'].toString();
    final id = json['id'].toString();
    
    return Status(
      user_id: user_id,
      status: status,
      timestamp: timestamp,
      id: id,
    );
  }

  factory Status.fromJsonPembayaran(Map<String, dynamic> json) {
    // json = json['status'];
    final status = json['status'];
    
    return Status(
      status: status,
    );
  }
}
