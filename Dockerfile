# https://elyra.readthedocs.io/en/latest/recipes/creating-a-custom-runtime-image.html

#FROM python:3.10.0
FROM python:3.10.0

COPY requirements.txt ./

RUN apt-get update -y \
 && apt-get install unixodbc -y \
 && apt-get install unixodbc-dev -y \
 && apt-get install freetds-dev -y \
 && apt-get install freetds-bin -y \
 && apt-get install tdsodbc -y \
 && apt-get install --reinstall build-essential -y

# populate "ocbcinst.ini" as this is where ODBC driver config sits
RUN echo "[FreeTDS]\n\
Description = FreeTDS Driver\n\
Driver = /usr/lib/x86_64-linux-gnu/odbc/libtdsodbc.so\n\
Setup = /usr/lib/x86_64-linux-gnu/odbc/libtdsS.so" >> /etc/odbcinst.ini


# RUN pip3 install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

RUN apt-get update -y\
  && apt-get install openssh-client -y\
  && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb\
  && apt-get install ./google-chrome-stable_current_amd64.deb -y\
  && apt-get install default-jdk -y

