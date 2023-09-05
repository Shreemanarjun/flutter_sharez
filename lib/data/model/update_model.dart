// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';

class UpdateModel {
  final String url;
  final String assets_url;
  final String upload_url;
  final String html_url;
  final int id;
  final Author author;
  final String node_id;
  final String tag_name;
  final String target_commitish;
  final String name;
  final bool draft;
  final bool prerelease;
  final String created_at;
  final String published_at;
  final List<Asset> assets;
  final String tarball_url;
  final String zipball_url;
  final String body;
  final int mentions_count;
  UpdateModel({
    required this.url,
    required this.assets_url,
    required this.upload_url,
    required this.html_url,
    required this.id,
    required this.author,
    required this.node_id,
    required this.tag_name,
    required this.target_commitish,
    required this.name,
    required this.draft,
    required this.prerelease,
    required this.created_at,
    required this.published_at,
    required this.assets,
    required this.tarball_url,
    required this.zipball_url,
    required this.body,
    required this.mentions_count,
  });

  UpdateModel copyWith({
    String? url,
    String? assets_url,
    String? upload_url,
    String? html_url,
    int? id,
    Author? author,
    String? node_id,
    String? tag_name,
    String? target_commitish,
    String? name,
    bool? draft,
    bool? prerelease,
    String? created_at,
    String? published_at,
    List<Asset>? assets,
    String? tarball_url,
    String? zipball_url,
    String? body,
    int? mentions_count,
  }) {
    return UpdateModel(
      url: url ?? this.url,
      assets_url: assets_url ?? this.assets_url,
      upload_url: upload_url ?? this.upload_url,
      html_url: html_url ?? this.html_url,
      id: id ?? this.id,
      author: author ?? this.author,
      node_id: node_id ?? this.node_id,
      tag_name: tag_name ?? this.tag_name,
      target_commitish: target_commitish ?? this.target_commitish,
      name: name ?? this.name,
      draft: draft ?? this.draft,
      prerelease: prerelease ?? this.prerelease,
      created_at: created_at ?? this.created_at,
      published_at: published_at ?? this.published_at,
      assets: assets ?? this.assets,
      tarball_url: tarball_url ?? this.tarball_url,
      zipball_url: zipball_url ?? this.zipball_url,
      body: body ?? this.body,
      mentions_count: mentions_count ?? this.mentions_count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'assets_url': assets_url,
      'upload_url': upload_url,
      'html_url': html_url,
      'id': id,
      'author': author.toMap(),
      'node_id': node_id,
      'tag_name': tag_name,
      'target_commitish': target_commitish,
      'name': name,
      'draft': draft,
      'prerelease': prerelease,
      'created_at': created_at,
      'published_at': published_at,
      'assets': assets.map((x) => x.toMap()).toList(),
      'tarball_url': tarball_url,
      'zipball_url': zipball_url,
      'body': body,
      'mentions_count': mentions_count,
    };
  }

  factory UpdateModel.fromMap(Map<String, dynamic> map) {
    return UpdateModel(
      url: map['url'] ?? '',
      assets_url: map['assets_url'] ?? '',
      upload_url: map['upload_url'] ?? '',
      html_url: map['html_url'] ?? '',
      id: map['id']?.toInt() ?? 0,
      author: Author.fromMap(map['author']),
      node_id: map['node_id'] ?? '',
      tag_name: map['tag_name'] ?? '',
      target_commitish: map['target_commitish'] ?? '',
      name: map['name'] ?? '',
      draft: map['draft'] ?? false,
      prerelease: map['prerelease'] ?? false,
      created_at: map['created_at'] ?? '',
      published_at: map['published_at'] ?? '',
      assets: List<Asset>.from(
          map['assets']?.map((x) => Asset.fromMap(x)) ?? const []),
      tarball_url: map['tarball_url'] ?? '',
      zipball_url: map['zipball_url'] ?? '',
      body: map['body'] ?? '',
      mentions_count: map['mentions_count']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateModel.fromJson(String source) =>
      UpdateModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UpdateModel(url: $url, assets_url: $assets_url, upload_url: $upload_url, html_url: $html_url, id: $id, author: $author, node_id: $node_id, tag_name: $tag_name, target_commitish: $target_commitish, name: $name, draft: $draft, prerelease: $prerelease, created_at: $created_at, published_at: $published_at, assets: $assets, tarball_url: $tarball_url, zipball_url: $zipball_url, body: $body, mentions_count: $mentions_count)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UpdateModel &&
        other.url == url &&
        other.assets_url == assets_url &&
        other.upload_url == upload_url &&
        other.html_url == html_url &&
        other.id == id &&
        other.author == author &&
        other.node_id == node_id &&
        other.tag_name == tag_name &&
        other.target_commitish == target_commitish &&
        other.name == name &&
        other.draft == draft &&
        other.prerelease == prerelease &&
        other.created_at == created_at &&
        other.published_at == published_at &&
        listEquals(other.assets, assets) &&
        other.tarball_url == tarball_url &&
        other.zipball_url == zipball_url &&
        other.body == body &&
        other.mentions_count == mentions_count;
  }

  @override
  int get hashCode {
    return url.hashCode ^
        assets_url.hashCode ^
        upload_url.hashCode ^
        html_url.hashCode ^
        id.hashCode ^
        author.hashCode ^
        node_id.hashCode ^
        tag_name.hashCode ^
        target_commitish.hashCode ^
        name.hashCode ^
        draft.hashCode ^
        prerelease.hashCode ^
        created_at.hashCode ^
        published_at.hashCode ^
        assets.hashCode ^
        tarball_url.hashCode ^
        zipball_url.hashCode ^
        body.hashCode ^
        mentions_count.hashCode;
  }
}

class Author {
  final String login;
  final int id;
  final String node_id;
  final String avatar_url;
  final String gravatar_id;
  final String url;
  final String html_url;
  final String followers_url;
  final String following_url;
  final String gists_url;
  final String starred_url;
  final String subscriptions_url;
  final String organizations_url;
  final String repos_url;
  final String events_url;
  final String received_events_url;
  final String type;
  final bool site_admin;
  Author({
    required this.login,
    required this.id,
    required this.node_id,
    required this.avatar_url,
    required this.gravatar_id,
    required this.url,
    required this.html_url,
    required this.followers_url,
    required this.following_url,
    required this.gists_url,
    required this.starred_url,
    required this.subscriptions_url,
    required this.organizations_url,
    required this.repos_url,
    required this.events_url,
    required this.received_events_url,
    required this.type,
    required this.site_admin,
  });

  Author copyWith({
    String? login,
    int? id,
    String? node_id,
    String? avatar_url,
    String? gravatar_id,
    String? url,
    String? html_url,
    String? followers_url,
    String? following_url,
    String? gists_url,
    String? starred_url,
    String? subscriptions_url,
    String? organizations_url,
    String? repos_url,
    String? events_url,
    String? received_events_url,
    String? type,
    bool? site_admin,
  }) {
    return Author(
      login: login ?? this.login,
      id: id ?? this.id,
      node_id: node_id ?? this.node_id,
      avatar_url: avatar_url ?? this.avatar_url,
      gravatar_id: gravatar_id ?? this.gravatar_id,
      url: url ?? this.url,
      html_url: html_url ?? this.html_url,
      followers_url: followers_url ?? this.followers_url,
      following_url: following_url ?? this.following_url,
      gists_url: gists_url ?? this.gists_url,
      starred_url: starred_url ?? this.starred_url,
      subscriptions_url: subscriptions_url ?? this.subscriptions_url,
      organizations_url: organizations_url ?? this.organizations_url,
      repos_url: repos_url ?? this.repos_url,
      events_url: events_url ?? this.events_url,
      received_events_url: received_events_url ?? this.received_events_url,
      type: type ?? this.type,
      site_admin: site_admin ?? this.site_admin,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'id': id,
      'node_id': node_id,
      'avatar_url': avatar_url,
      'gravatar_id': gravatar_id,
      'url': url,
      'html_url': html_url,
      'followers_url': followers_url,
      'following_url': following_url,
      'gists_url': gists_url,
      'starred_url': starred_url,
      'subscriptions_url': subscriptions_url,
      'organizations_url': organizations_url,
      'repos_url': repos_url,
      'events_url': events_url,
      'received_events_url': received_events_url,
      'type': type,
      'site_admin': site_admin,
    };
  }

  factory Author.fromMap(Map<String, dynamic> map) {
    return Author(
      login: map['login'] ?? '',
      id: map['id']?.toInt() ?? 0,
      node_id: map['node_id'] ?? '',
      avatar_url: map['avatar_url'] ?? '',
      gravatar_id: map['gravatar_id'] ?? '',
      url: map['url'] ?? '',
      html_url: map['html_url'] ?? '',
      followers_url: map['followers_url'] ?? '',
      following_url: map['following_url'] ?? '',
      gists_url: map['gists_url'] ?? '',
      starred_url: map['starred_url'] ?? '',
      subscriptions_url: map['subscriptions_url'] ?? '',
      organizations_url: map['organizations_url'] ?? '',
      repos_url: map['repos_url'] ?? '',
      events_url: map['events_url'] ?? '',
      received_events_url: map['received_events_url'] ?? '',
      type: map['type'] ?? '',
      site_admin: map['site_admin'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Author.fromJson(String source) => Author.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Author(login: $login, id: $id, node_id: $node_id, avatar_url: $avatar_url, gravatar_id: $gravatar_id, url: $url, html_url: $html_url, followers_url: $followers_url, following_url: $following_url, gists_url: $gists_url, starred_url: $starred_url, subscriptions_url: $subscriptions_url, organizations_url: $organizations_url, repos_url: $repos_url, events_url: $events_url, received_events_url: $received_events_url, type: $type, site_admin: $site_admin)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Author &&
        other.login == login &&
        other.id == id &&
        other.node_id == node_id &&
        other.avatar_url == avatar_url &&
        other.gravatar_id == gravatar_id &&
        other.url == url &&
        other.html_url == html_url &&
        other.followers_url == followers_url &&
        other.following_url == following_url &&
        other.gists_url == gists_url &&
        other.starred_url == starred_url &&
        other.subscriptions_url == subscriptions_url &&
        other.organizations_url == organizations_url &&
        other.repos_url == repos_url &&
        other.events_url == events_url &&
        other.received_events_url == received_events_url &&
        other.type == type &&
        other.site_admin == site_admin;
  }

  @override
  int get hashCode {
    return login.hashCode ^
        id.hashCode ^
        node_id.hashCode ^
        avatar_url.hashCode ^
        gravatar_id.hashCode ^
        url.hashCode ^
        html_url.hashCode ^
        followers_url.hashCode ^
        following_url.hashCode ^
        gists_url.hashCode ^
        starred_url.hashCode ^
        subscriptions_url.hashCode ^
        organizations_url.hashCode ^
        repos_url.hashCode ^
        events_url.hashCode ^
        received_events_url.hashCode ^
        type.hashCode ^
        site_admin.hashCode;
  }
}

class Asset {
  final String url;
  final int id;
  final String node_id;
  final String name;
  final String label;
  final Uploader uploader;
  final String content_type;
  final String state;
  final int size;
  final int download_count;
  final String created_at;
  final String updated_at;
  final String browser_download_url;
  Asset({
    required this.url,
    required this.id,
    required this.node_id,
    required this.name,
    required this.label,
    required this.uploader,
    required this.content_type,
    required this.state,
    required this.size,
    required this.download_count,
    required this.created_at,
    required this.updated_at,
    required this.browser_download_url,
  });

  Asset copyWith({
    String? url,
    int? id,
    String? node_id,
    String? name,
    String? label,
    Uploader? uploader,
    String? content_type,
    String? state,
    int? size,
    int? download_count,
    String? created_at,
    String? updated_at,
    String? browser_download_url,
  }) {
    return Asset(
      url: url ?? this.url,
      id: id ?? this.id,
      node_id: node_id ?? this.node_id,
      name: name ?? this.name,
      label: label ?? this.label,
      uploader: uploader ?? this.uploader,
      content_type: content_type ?? this.content_type,
      state: state ?? this.state,
      size: size ?? this.size,
      download_count: download_count ?? this.download_count,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      browser_download_url: browser_download_url ?? this.browser_download_url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'id': id,
      'node_id': node_id,
      'name': name,
      'label': label,
      'uploader': uploader.toMap(),
      'content_type': content_type,
      'state': state,
      'size': size,
      'download_count': download_count,
      'created_at': created_at,
      'updated_at': updated_at,
      'browser_download_url': browser_download_url,
    };
  }

  factory Asset.fromMap(Map<String, dynamic> map) {
    return Asset(
      url: map['url'] ?? '',
      id: map['id']?.toInt() ?? 0,
      node_id: map['node_id'] ?? '',
      name: map['name'] ?? '',
      label: map['label'] ?? '',
      uploader: Uploader.fromMap(map['uploader']),
      content_type: map['content_type'] ?? '',
      state: map['state'] ?? '',
      size: map['size']?.toInt() ?? 0,
      download_count: map['download_count']?.toInt() ?? 0,
      created_at: map['created_at'] ?? '',
      updated_at: map['updated_at'] ?? '',
      browser_download_url: map['browser_download_url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Asset.fromJson(String source) => Asset.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Asset(url: $url, id: $id, node_id: $node_id, name: $name, label: $label, uploader: $uploader, content_type: $content_type, state: $state, size: $size, download_count: $download_count, created_at: $created_at, updated_at: $updated_at, browser_download_url: $browser_download_url)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Asset &&
        other.url == url &&
        other.id == id &&
        other.node_id == node_id &&
        other.name == name &&
        other.label == label &&
        other.uploader == uploader &&
        other.content_type == content_type &&
        other.state == state &&
        other.size == size &&
        other.download_count == download_count &&
        other.created_at == created_at &&
        other.updated_at == updated_at &&
        other.browser_download_url == browser_download_url;
  }

  @override
  int get hashCode {
    return url.hashCode ^
        id.hashCode ^
        node_id.hashCode ^
        name.hashCode ^
        label.hashCode ^
        uploader.hashCode ^
        content_type.hashCode ^
        state.hashCode ^
        size.hashCode ^
        download_count.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode ^
        browser_download_url.hashCode;
  }
}

class Uploader {
  final String login;
  final int id;
  final String node_id;
  final String avatar_url;
  final String gravatar_id;
  final String url;
  final String html_url;
  final String followers_url;
  final String following_url;
  final String gists_url;
  final String starred_url;
  final String subscriptions_url;
  final String organizations_url;
  final String repos_url;
  final String events_url;
  final String received_events_url;
  final String type;
  final bool site_admin;
  Uploader({
    required this.login,
    required this.id,
    required this.node_id,
    required this.avatar_url,
    required this.gravatar_id,
    required this.url,
    required this.html_url,
    required this.followers_url,
    required this.following_url,
    required this.gists_url,
    required this.starred_url,
    required this.subscriptions_url,
    required this.organizations_url,
    required this.repos_url,
    required this.events_url,
    required this.received_events_url,
    required this.type,
    required this.site_admin,
  });

  Uploader copyWith({
    String? login,
    int? id,
    String? node_id,
    String? avatar_url,
    String? gravatar_id,
    String? url,
    String? html_url,
    String? followers_url,
    String? following_url,
    String? gists_url,
    String? starred_url,
    String? subscriptions_url,
    String? organizations_url,
    String? repos_url,
    String? events_url,
    String? received_events_url,
    String? type,
    bool? site_admin,
  }) {
    return Uploader(
      login: login ?? this.login,
      id: id ?? this.id,
      node_id: node_id ?? this.node_id,
      avatar_url: avatar_url ?? this.avatar_url,
      gravatar_id: gravatar_id ?? this.gravatar_id,
      url: url ?? this.url,
      html_url: html_url ?? this.html_url,
      followers_url: followers_url ?? this.followers_url,
      following_url: following_url ?? this.following_url,
      gists_url: gists_url ?? this.gists_url,
      starred_url: starred_url ?? this.starred_url,
      subscriptions_url: subscriptions_url ?? this.subscriptions_url,
      organizations_url: organizations_url ?? this.organizations_url,
      repos_url: repos_url ?? this.repos_url,
      events_url: events_url ?? this.events_url,
      received_events_url: received_events_url ?? this.received_events_url,
      type: type ?? this.type,
      site_admin: site_admin ?? this.site_admin,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'id': id,
      'node_id': node_id,
      'avatar_url': avatar_url,
      'gravatar_id': gravatar_id,
      'url': url,
      'html_url': html_url,
      'followers_url': followers_url,
      'following_url': following_url,
      'gists_url': gists_url,
      'starred_url': starred_url,
      'subscriptions_url': subscriptions_url,
      'organizations_url': organizations_url,
      'repos_url': repos_url,
      'events_url': events_url,
      'received_events_url': received_events_url,
      'type': type,
      'site_admin': site_admin,
    };
  }

  factory Uploader.fromMap(Map<String, dynamic> map) {
    return Uploader(
      login: map['login'] ?? '',
      id: map['id']?.toInt() ?? 0,
      node_id: map['node_id'] ?? '',
      avatar_url: map['avatar_url'] ?? '',
      gravatar_id: map['gravatar_id'] ?? '',
      url: map['url'] ?? '',
      html_url: map['html_url'] ?? '',
      followers_url: map['followers_url'] ?? '',
      following_url: map['following_url'] ?? '',
      gists_url: map['gists_url'] ?? '',
      starred_url: map['starred_url'] ?? '',
      subscriptions_url: map['subscriptions_url'] ?? '',
      organizations_url: map['organizations_url'] ?? '',
      repos_url: map['repos_url'] ?? '',
      events_url: map['events_url'] ?? '',
      received_events_url: map['received_events_url'] ?? '',
      type: map['type'] ?? '',
      site_admin: map['site_admin'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Uploader.fromJson(String source) =>
      Uploader.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Uploader(login: $login, id: $id, node_id: $node_id, avatar_url: $avatar_url, gravatar_id: $gravatar_id, url: $url, html_url: $html_url, followers_url: $followers_url, following_url: $following_url, gists_url: $gists_url, starred_url: $starred_url, subscriptions_url: $subscriptions_url, organizations_url: $organizations_url, repos_url: $repos_url, events_url: $events_url, received_events_url: $received_events_url, type: $type, site_admin: $site_admin)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Uploader &&
        other.login == login &&
        other.id == id &&
        other.node_id == node_id &&
        other.avatar_url == avatar_url &&
        other.gravatar_id == gravatar_id &&
        other.url == url &&
        other.html_url == html_url &&
        other.followers_url == followers_url &&
        other.following_url == following_url &&
        other.gists_url == gists_url &&
        other.starred_url == starred_url &&
        other.subscriptions_url == subscriptions_url &&
        other.organizations_url == organizations_url &&
        other.repos_url == repos_url &&
        other.events_url == events_url &&
        other.received_events_url == received_events_url &&
        other.type == type &&
        other.site_admin == site_admin;
  }

  @override
  int get hashCode {
    return login.hashCode ^
        id.hashCode ^
        node_id.hashCode ^
        avatar_url.hashCode ^
        gravatar_id.hashCode ^
        url.hashCode ^
        html_url.hashCode ^
        followers_url.hashCode ^
        following_url.hashCode ^
        gists_url.hashCode ^
        starred_url.hashCode ^
        subscriptions_url.hashCode ^
        organizations_url.hashCode ^
        repos_url.hashCode ^
        events_url.hashCode ^
        received_events_url.hashCode ^
        type.hashCode ^
        site_admin.hashCode;
  }
}
