FROM openjdk:8u212-jdk

LABEL maintainer="Paul Harrison"

#note that saxon and fop are rather old versions to get this still to work.

WORKDIR /usr/local/src

RUN wget https://www.mirrorservice.org/sites/ftp.apache.org//ant/binaries/apache-ant-1.10.8-bin.tar.bz2 \
 && tar xvjf apache-ant-1.10.8-bin.tar.bz2
 
ENV ANT_HOME "/usr/local/src/apache-ant-1.10.8"
ENV PATH "${ANT_HOME}/bin:${PATH}"

RUN cd apache-ant-1.10.8 && ant -f fetch.xml -Ddest=system

RUN wget http://archive.apache.org/dist/xmlgraphics/fop/binaries/fop-1.1-bin.tar.gz \
    && tar xvzf fop-1.1-bin.tar.gz
    
ENV FOP_HOME /usr/local/src/fop-1.1

#create a user to prevent easy corruption of the main machinery
RUN useradd --create-home --shell /bin/bash ivoa
RUN mkdir /pub && chown ivoa /pub
USER ivoa

WORKDIR /home/ivoa
RUN mkdir saxon && cd saxon && curl -L  https://sourceforge.net/projects/saxon/files/Saxon-B/9.1.0.8/saxonb9-1-0-8j.zip/download -o saxon.zip && unzip saxon.zip 
RUN mkdir -p .ant/lib && cd .ant/lib \
    && ln -s /home/ivoa/saxon/saxon9-dom.jar  && ln -s /home/ivoa/saxon/saxon9-dom4j.jar && ln -s /home/ivoa/saxon/saxon9.jar 

#should really have a release of this
COPY . ivoapub/
ENV IVOAPUB_DIR /home/ivoa/ivoapub

VOLUME /pub
WORKDIR /pub

