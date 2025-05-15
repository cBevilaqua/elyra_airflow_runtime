# https://elyra.readthedocs.io/en/latest/recipes/creating-a-custom-runtime-image.html

FROM python:3.8

COPY requirements.txt ./

RUN pip3 install --no-cache-dir -r requirements.txt

RUN apt-get update -y\
  && apt-get install openssh-client -y\
  && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb\
  && apt-get install ./google-chrome-stable_current_amd64.deb -y\
  && apt-get install default-jdk -y\
  && apt-get install tesseract-ocr -y\
  && apt-get install tesseract-ocr-por -y\
  && apt-get install libtesseract-dev -y\
  && apt-get install libleptonica-dev -y\
  && apt-get install poppler-utils -y