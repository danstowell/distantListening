#!/bin/bash
docker build -t mclddistant .
docker run --rm -it -p 8888:8888 -v $(pwd)/notebooks:/notebooks mclddistant
