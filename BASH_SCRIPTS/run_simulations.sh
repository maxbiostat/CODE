#!/usr/bin/bash

echo "Simulation name (please do not use spaces, use underlines instead) [ENTER]:"
read nome
echo $nome > nome.txt

echo "Number of Monte Carlo replicates [ENTER]:"
read rep
echo $rep > rep.txt

echo "Number of iterations for the MCMC sampler [ENTER]:"
read mc
echo $mc > mc.txt
# TODO: create default
echo "Number of Cores to leave free [ENTER]:"
read freec
echo $freec > freec.txt
# TODO: create default
echo "Degree of niceness for this simulation [ENTER]:"
read legal
# TODO: create default
echo "Path to the folder where to save logs [ENTER]:"
read cam
echo $cam > cam.txt
# TODO: create default
# TODO: offer option of no logs

echo "Email (multiple addresses separates by a single space) [ENTER]:"
read emei

nice -n $legal  Rscript  ~/Max_simulation_study.R 

rm nome.txt rep.txt mc.txt freec.txt cam.txt 

echo "Resultados simulação $nome \n Esse é um email automático" | mutt -s $nome $emei -a $cam/results\_$nome\_$rep.log
