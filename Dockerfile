# mcld/lasagne-notebook

FROM jupyter/scipy-notebook

#############################################################
# Install bleeding-edge Theano and Lasagne, plus all kinds of other stuff, especially audio tools

USER root

RUN apt-get update && apt-get install -y \
  build-essential \
  git \
  wget \
  liblapack-dev \
  libopenblas-dev \
  python-dev \
        lsb-release \
        pkg-config \
        libavcodec-dev \
        libavformat-dev \
        libavutil-dev \
        libavresample-dev \
        fftw3-dev \
        libfreetype6-dev \
        curl \
        vim \
        gstreamer1.0-plugins-base \
        gstreamer1.0-plugins-ugly \
        libav-tools \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip
RUN pip install --upgrade six
RUN pip install --upgrade --no-deps git+git://github.com/Theano/Theano.git
RUN pip install --upgrade https://github.com/Lasagne/Lasagne/archive/master.zip

# ffmpeg and LibRosa
RUN conda install -c conda-forge ffmpeg librosa

USER $NB_USER

#################################################

# just for fun
RUN lsb_release -a

# X11
ENV DISPLAY :0

WORKDIR "/notebooks"

