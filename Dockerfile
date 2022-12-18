#Base Image
#FROM frankwolf/rpi-python3-gpio:latest
#FROM resin/rpi-raspbian:stretch-20190121
#FROM multiarch/ubuntu-core:arm64-xenial
#FROM multiarch/ubuntu-core:armhf-artful
#FROM multiarch/ubuntu-core:armhf-trusty
FROM 192.168.100.152:5000/root/root:latest

# Maintainer
LABEL maintainer=gipmail

RUN apt-get update
#RUN apt-get install -y nginx

# Install python
RUN apt-get install -y  python3 python3-dev 
RUN apt-get install -y  python3-pkg-resources python3-setuptools python3-pip&& \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Path
ENV APP_PATH /server

# Install Python modules needed by the Python app
COPY requirements.txt $APP_PATH/
RUN pip3 install --no-cache-dir -r $APP_PATH/requirements.txt

# Copy files required for the app to run
COPY src/ $APP_PATH/src
# COPY gunicorn_conf.py $APP_PATH/

# Port number the container should expose
EXPOSE 8000

WORKDIR $APP_PATH/src
CMD ["python3","GlobalIPMail.py"]
# CMD [ "gunicorn", "--bind=0.0.0.0:8000", "djangotodo.wsgi", "--workers=5", "--threads=2"]
