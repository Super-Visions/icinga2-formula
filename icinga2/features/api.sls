{% from 'icinga2/map.jinja' import icinga2 with context %}

include:
  - icinga2

icinga2_api_conf:
  file.managed:
    - name: {{icinga2.config_dir}}/features-available/api.conf
    - source: salt://icinga2/templates/api.conf.jinja
    - template: jinja
    - user: {{icinga2.user}}
    - group: {{icinga2.group}}
    - require:
      - pkg: icinga2_pkg

# Api enable
icinga2_api_enable:
  file.symlink:
    - name: {{icinga2.config_dir}}/features-enabled/api.conf
    - target: {{icinga2.config_dir}}/features-available/api.conf
    - require:
      - file: icinga2_api_conf
    - listen_in:
      - service: icinga2_service
