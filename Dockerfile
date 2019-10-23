FROM tercen/dartrusttidy:1.0.1

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

RUN echo 1.1.11.0 && git pull
RUN git checkout 1.1.11

RUN mkdir ~/.R && \
    echo "SHLIB_CXXLDFLAGS = -Wl,-S -shared" >> ~/.R/Makevars && \
    echo "SHLIB_CXX11LDFLAGS = -Wl,-S -shared" >> ~/.R/Makevars && \
    echo "SHLIB_CXX14LDFLAGS = -Wl,-S -shared" >> ~/.R/Makevars && \
    echo "SHLIB_FCLDFLAGS = -Wl,-S -shared" >> ~/.R/Makevars && \
    echo "SHLIB_LDFLAGS = -Wl,-S -shared" >> ~/.R/Makevars && \
    cat ~/.R/Makevars

RUN R -e "renv::restore(confirm=FALSE)"

RUN rm -rf /tmp/* /var/tmp/* /usr/local/cargo/registry/* /usr/local/cargo/git/* && \
    rm -rf /root/.local/share/renv/cache/v4/R-3.5/x86_64-pc-linux-gnu/BH/* && \
    strip --strip-debug /root/.local/share/renv/cache/*/*/*/*/*/*/*/libs/*.so

ENTRYPOINT [ "R","--no-save","--no-restore","--no-environ","--slave","-f","main.R", "--args"]
CMD [ "--taskId", "someid", "--serviceUri", "https://tercen.com", "--token", "sometoken"]






