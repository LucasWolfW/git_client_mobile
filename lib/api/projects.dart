class ProjectsRepo {
  final String name;
  final String full_name;
  final String html_url;
  final DateTime created_at;
  final DateTime updated_at;

  ProjectsRepo(this.name, this.full_name, this.html_url, this.created_at,
      this.updated_at);

  static List<ProjectsRepo> mapJSONStringToList(List<dynamic> jsonList) {
    return jsonList
        .map((r) => ProjectsRepo(r['name'], r['full_name'], r['html_url'],
            r['created_at'], r['updated_at']))
        .toList();
  }
}
