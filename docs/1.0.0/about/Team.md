---
layout: detail
title: Team
description: An overview of the founding team and core contributors to ODS iOS.
---

ODS iOS is maintained by the core team and a small group of invaluable core contributors, with the support and involvement of our community.

{% if site.data.team.ODS_iOS[0] %}
<div class="list-group mb-3">
  {% for team_member in site.data.team.ODS_iOS %}
    <a class="list-group-item list-group-item-action d-flex align-items-center" href="https://github.com/{{ team_member.gh_pseudo }}">
      <img src="https://github.com/{{ team_member.gh_pseudo }}.png" alt="@{{ team_member.gh_pseudo }}" width="32" height="32" class="me-2" loading="lazy">
      <span class="fw-normal">
        <strong>{{ team_member.name }}</strong> @{{ team_member.gh_pseudo }}
      </span>
    </a>
  {% endfor %}
</div>
{% endif %}

Get involved with ODS iOS development by [opening an issue](https://github.com/Orange-OpenSource/ods-ios/issues/new/choose) or submitting a pull request. Read our [contributing guidelines](https://github.com/Orange-OpenSource/ods-ios/blob/main/CONTRIBUTING.md) for information on how we develop.
