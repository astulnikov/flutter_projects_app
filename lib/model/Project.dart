class Project {
  final String id;
  final String name;
  final String description;
  final String url;
  final String coverImage;
  final String companyLead;
  final String clientLead;
  final String status;
  final List<String> team;

  Project(
      {this.id,
      this.name,
      this.description,
      this.url,
      this.coverImage,
      this.companyLead,
      this.clientLead,
      this.status,
      this.team});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
        id: json['_id'] as String,
        name: json['name'] == null ? 'Unknown' : json['name'] as String,
        description: json['description'] == null
            ? 'Unknown'
            : json['description'] as String,
        url: json['url'] == null ? 'Unknown' : json['url'] as String,
        coverImage: json['coverImage'] as String,
        companyLead: json['companyLead'] == null
            ? 'Unknown'
            : json['companyLead'] as String,
        clientLead: json['clientLead'] == null
            ? 'Unknown'
            : json['clientLead'] as String,
        status: json['status'] == null ? 'Unknown' : json['status'] as String,
        team: List<String>.from(json['team']));
  }
}
