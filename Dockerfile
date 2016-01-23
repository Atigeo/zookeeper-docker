# ---- xPatterns zookeeper Docker -------------------------

# ---- Version Control ------------------------------------

FROM xpatterns/java:7u79


# ---- Set Environmental Variables ------------------------


# ---- Expose ports ---------------------------------------

# Zookeeper
EXPOSE 2181

# Follow the leader communication
EXPOSE 2888

# Leader election
EXPOSE 3888


# ---- Volumes --------------------------------------------

VOLUME /var/lib/zookeeper/


# ---- apt-get --------------------------------------------

#Add the CDH 5 repository
COPY conf/cloudera.list /etc/apt/sources.list.d/cloudera.list
#Set preference for cloudera packages
COPY conf/cloudera.pref /etc/apt/preferences.d/cloudera.pref

RUN wget http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh/archive.key -O archive.key && sudo apt-key add archive.key
RUN sudo apt-get update
RUN sudo apt-get install -y zookeeper-server=3.4.5+cdh5.4.4+91-1.cdh5.4.4.p0.6~trusty-cdh5.4.4


# ---- Install run script ---------------------------------
COPY conf/run.sh /usr/bin/run.sh
RUN chmod u+x /usr/bin/run.sh
CMD ["/usr/bin/run.sh"]
