#!bin/bash
java -Xms15360m -Xmx15360m -Djava.library.path=/home/max/lib  -cp /home/max/BEASTv1.7.4/lib/beast.jar:/usr/local/src/beast-mcmc/lib/beagle.jar dr.app.beast.BeastMain -beagle -beagle_CPU -beagle_SSE -beagle_instances 6 -overwrite -working 


