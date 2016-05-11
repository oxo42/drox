#!/bin/bash

echo source ~/.drox/bashrc >> ~/.bashrc
echo '(cd ~/.drox && ./update.sh 2>&1 &) >> /tmp/droxlog' >> ~/.profile

curl https://raw.githubusercontent.com/oxo42/drox/master/install.sh | bash
