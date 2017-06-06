

If you run ./start.sh it should build the image (if needed) and then run it, starting a jupyter notebook which can be accessed via a web browser at http://0.0.0.0:8888 . To stop the image running just terminate the command, in the terminal window in which you ran ./start.sh


You can also drop directly to a commandline in a running image by doing:

docker run --rm -it -p 8888:8888 -v $(pwd)/notebooks:/notebooks mcld/lasagne-notebook /bin/bash


