# BEAST

## What is it?
**B**ayesian **E**volutionary **A**nalysis by **S**ampling **T**rees is a cross-platform software package for Bayesian phylogenetic analysis of molecular sequences using Markov chain Monte Carlo (MCMC).
It is implemented in [JAVA](http://docs.oracle.com/javase/8/) and depends on JRE version 1.6 or higher to run.

Programs distributed in the BEAST "bundle":
- [BEAST mcmc](http://beast.bio.ed.ac.uk/BEAST): Runs the MCMC from XML configuration files. Isthe heart of the BEAST framework;
- [BEAUti](http://beast.bio.ed.ac.uk/BEAUti): an user-friendly GUI for creating input (configuration) XML files to run BEAST;
- [LogCombiner](http://beast.bio.ed.ac.uk/LogCombiner): a program (GUI) to combine log and tree files from multiple runs of BEAST;
- [TreeAnnotator](http://beast.bio.ed.ac.uk/TreeAnnotator): program for summarising the information in a sample of trees produced by BEAST.

The BEAST family also has two other honorary members:
- [Tracer](http://beast.bio.ed.ac.uk/Tracer): graphical program for analysing results from MCMC programs such as BEAST and MrBayes;
- [FigTree](http://beast.bio.ed.ac.uk/FigTree): A program for viewing trees including summary information produced by TreeAnnotator, a.k.a, "annotated" trees.

In the [development repository](https://github.com/beast-dev/beast-mcmc) you will find the current ~~bug-prone~~  bleeding-edge version of BEAST.
## How does it work?

## The XML configuration file format

## BEAGLE


## Using BEAST
```tcsh
user@machine:~$ java -Xms64m -Xmx4096m -jar /path/to/beast -help
```
