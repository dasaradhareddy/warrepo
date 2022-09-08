FROM amazonlinux

# Install git and java 8
RUN yum install -y git-all gcc gcc-c++ java-1.8.0-openjdk python27-devel tar

# install python 2.7 packages
RUN curl https://bootstrap.pypa.io/get-pip.py | python
RUN /usr/bin/yes | pip install --upgrade --ignore-installed --force-reinstall awscli boto3 PyAthena pandas requests simplejson jsonpickle s3fs
RUN /usr/bin/yes | pip install --upgrade  --ignore-installed --force-reinstall https://s3-us-west-2.amazonaws.com/move-dl-common-binary-distrubution/python/move_dl_common_api-3.2.125-release.tar.gz

# install python 3 and packages
ADD install_python36.sh .
RUN ./install_python36.sh
RUN /usr/bin/yes | pip3.6 install --upgrade --ignore-installed --force-reinstall awscli boto3 PyAthena pandas requests simplejson jsonpickle mysql-connector-python flask-cors s3fs
RUN /usr/bin/yes | pip3.6 install --upgrade --ignore-installed --force-reinstall https://s3-us-west-2.amazonaws.com/move-dl-common-binary-distrubution/python/move_dl_common_api-3.2.125-release.tar.gz

COPY log4j.properties /

ADD install_pymssql.sh .
RUN ./install_pymssql.sh

#ADD install_pyodbc.sh .
#RUN ./install_pyodbc.sh

RUN /usr/bin/yes | pip3.6 install Flask flask-restplus

RUN /usr/bin/yes | yum update && \
    yum install -y openssl
    
RUN /usr/bin/yes | pip3.6 install --upgrade --ignore-installed --force-reinstall circuitbreaker    

### START NEW RELIC CHANGE ####

## ENV NEW_RELIC_LICENSE_KEY=c942cf4ef908d56a437521975f4d578965ca748f 

# Set application context
## ENV API_LKP_APP_CONFIG=listing_profile


#Install the NewRelic Agent
RUN pip3 install newrelic
### END OF NEW RELIC CHANGE #####

COPY run_internal.sh /
# start taskrunner on container start
CMD ["/run_internal.sh"]

