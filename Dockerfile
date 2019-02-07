FROM tercen/tercen_base:1.0.10

RUN git clone https://github.com/tercen/High-Dimensional-Inspector.git
RUN cd High-Dimensional-Inspector && \
    apt-get update && \
    apt-get install -y cmake && \
    ./scripts/install-dependencies.sh && \
    mkdir build && \
    cd build && \
    cmake  -DCMAKE_BUILD_TYPE=Release .. && \
    make -j 8 && \
    make install

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER root
WORKDIR /operator

RUN git clone https://github.com/tercen/atsne_operator.git

WORKDIR /operator/atsne_operator
  
RUN R --no-init-file --no-save --no-restore --no-environ --slave -f packrat/init.R --args --bootstrap-packrat

ENTRYPOINT [ "R","--no-init-file","--no-save","--no-restore","--no-environ","--slave","-f","main.R", "--args"]
CMD [ "--taskId", "someid", "--serviceUri", "https://tercen.com", "--slaveUri", "http://127.0.0.1:5500", "--token", "sometoken"]





