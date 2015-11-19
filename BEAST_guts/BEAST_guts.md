# BEAST

## What is it?
**B**ayesian **E**volutionary **A**nalysis by **S**ampling **T**rees is a cross-platform software package for Bayesian phylogenetic analysis of molecular sequences using Markov chain Monte Carlo (MCMC).
It is implemented in [JAVA](http://docs.oracle.com/javase/8/) and depends on JRE version 1.6 or higher to run.

Programs distributed in the BEAST "bundle":
- [BEAST mcmc](http://beast.bio.ed.ac.uk/BEAST): Runs the MCMC from XML configuration files. Is the heart of the BEAST framework;
- [BEAUti](http://beast.bio.ed.ac.uk/BEAUti): an user-friendly GUI for creating input (configuration) XML files to run BEAST;
- [LogCombiner](http://beast.bio.ed.ac.uk/LogCombiner): a program (GUI) to combine log and tree files from multiple runs of BEAST;
- [TreeAnnotator](http://beast.bio.ed.ac.uk/TreeAnnotator): program for summarising the information in a sample of trees produced by BEAST.

The BEAST family also has two other honorary members:
- [Tracer](http://beast.bio.ed.ac.uk/Tracer): graphical program for analysing results from MCMC programs such as BEAST and MrBayes;
- [FigTree](http://beast.bio.ed.ac.uk/FigTree): A program for viewing trees including summary information produced by TreeAnnotator, a.k.a, "annotated" trees.

In the [development repository](https://github.com/beast-dev/beast-mcmc) you will find the current ~~bug-prone~~  bleeding-edge version of BEAST.
Supposing you want the dev version:
```tcsh
user@machine:~$ git clone git@github.com:beast-dev/beast-mcmc.git
user@machine:~/beast-mcmc$ cd beast-mcmc/
user@machine:~/beast-mcmc$ ant
```
will build both `beast.jar` and `beauti.jar` in beast-mcmc/build/dist/ . 

This is what we informally call "BEAST 1", the original BEAST. 

[Alexei Drummond](http://compevol.auckland.ac.nz/dr-alexei-drummond/) and his team have developed [BEAST2](http://beast2.org/) that features a more modular, plugin-base architecture where users can contribute plugins implementing a plethora of phylogenetic models.
The development repo for BEAST2 sits [here](https://github.com/compevol/beast2).

## How does it work?
BEAST feeds on ~~souls~~ XML input files that are supposed specify everything you need to run MCMC and get a posterior distribution for your parameters:
- Data!
- Likelihoods (i.e, models);
- Priors;
- Operators;
- Number of iterations, sampling frequency and auto-optimisation options.

### General architecture
## The XML configuration file format

## BEAGLE


## Using BEAST
```tcsh
user@machine:~$ java -Xms64m -Xmx4096m -jar /path/to/beast -help
```
