{# -*- engine:django -*- #}
{% extends 'basic.tpl' %}

{% block header %}
<!DOCTYPE html>
<html>
  <head>
    {% block html_head %}
    <meta charset="utf-8"/>
    <title>{{ resources['metadata']['name'] }}</title>
    <style>
    </style>
    {% endblock html_head %}
  </head>
{% endblock header %}
  
{% block body %}
  <body>
    <article class="main">
      {{ super() }}
    </article>
  </body>
{%- endblock body %}
  
{% block footer %}
{{ super() }}
</html>
{% endblock footer %}

{% block in_prompt %}
{% endblock in_prompt %}

{% block empty_in_prompt %}
{% endblock empty_in_prompt %}

{% block output_area_prompt %}
{% endblock output_area_prompt %}

{% block stream_stderr scoped %}
{% endblock stream_stderr %}

{% block input_group %}
{% if cell.metadata.get('nbconvert', {}).get('show_code', False) %}
{{ super() }}
{% endif %}
{% endblock input_group %}
