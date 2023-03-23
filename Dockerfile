# https://elyra.readthedocs.io/en/latest/recipes/creating-a-custom-runtime-image.html

FROM python:3

COPY requirements.txt ./

RUN pip3 install --no-cache-dir -r requirements.txt

RUN apt-get update -y\
  && apt-get install openssh-client -y\
  && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb\
  && apt-get install ./google-chrome-stable_current_amd64.deb -y\
  && apt-get install default-jdk -y

# Add microsoft sql server driver
RUN apt-get update -y\
  && apt-get install lsb-release -y\
  && apt-get install curl -y\
  && apt-get install gnupg -y\
  && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -\
  && curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list > /etc/apt/sources.list.d/mssql-release.list\
  && apt-get update\
  && ACCEPT_EULA=Y apt-get install msodbcsql18 -y\
  && apt install unixodbc-dev -y