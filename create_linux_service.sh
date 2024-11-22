#!/bin/bash

name=$(basename "$PWD")
service_path="/etc/systemd/system/$name.service"

cat > "$service_path" <<EOF
[Unit]
Description=Best bot 4ever!
After=network.target

[Service]
User=ubuntu
WorkingDirectory=$(pwd)
Environment=VIRTUAL_ENV=$(pwd)/.venv
Environment=PATH=\$VIRTUAL_ENV/bin:\$PATH
ExecStart=$(pwd)/.venv/bin/python main.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

apt install python3-poetry -y
poetry config virtualenvs.in-project true
poetry env use python3

systemctl daemon-reload
systemctl start "$name.service"
systemctl enable "$name.service"
systemctl status "$name.service"