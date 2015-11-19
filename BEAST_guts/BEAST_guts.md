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
- [Tracer](http://beast.bio.ed.ac.uk/Tracer): graphical program for analysing results from MCMC programs such as BEAST and [MrBayes](http://mrbayes.sourceforge.net/);
- [FigTree](http://beast.bio.ed.ac.uk/FigTree): A program for viewing trees including summary information produced by TreeAnnotator, a.k.a, "annotated" trees.

In the [development repository](https://github.com/beast-dev/beast-mcmc) you will find the current ~~bug-prone~~  bleeding-edge version of BEAST.
Supposing you want the dev version:
```bash
user@machine:~$ git clone git@github.com:beast-dev/beast-mcmc.git
user@machine:~/beast-mcmc$ cd beast-mcmc/
user@machine:~/beast-mcmc$ ant
```
will build both `beast.jar` and `beauti.jar` in beast-mcmc/build/dist/. 

This is what we informally call "BEAST 1", the original BEAST. 

[Alexei Drummond](http://compevol.auckland.ac.nz/dr-alexei-drummond/) and his team have developed [BEAST2](http://beast2.org/) that features a more modular, plugin-based architecture where users can contribute plugins implementing a plethora of phylogenetic models.
The development repo for BEAST2 sits [here](https://github.com/compevol/beast2).

For doubts and general troubleshooting (after RTFM), see the [user group](https://groups.google.com/forum/#!forum/beast-users).

### BEAGLE

Likelihood computations are costly. To address this, Daniel Ayres and peers have written the **B**road-platform **E**volutionary **A**nalysis **G**eneral **L**ikelihood **E**valuator (BEAGLE), a C library that provides "fine-scale parallelization while minimizing data transfer and memory copy overhead" (see [paper](http://sysbio.oxfordjournals.org/content/61/1/170)).
BEAGLE brings substantial speed-ups in likelihood computation by efficiently using multicore CPUs and modern bazillion-core graphical processing units (GPUs).
BEAGLE is compatible with a range of phylogenetic software, such as BEAST, MrBayes, [PhyML](), and [Garli]().
The gain in speed is so significant that most complex models in BEAST, such as phylogeography,  now depend exclusively on BEAGLE to run.

### Using BEAST
if you want to look at the options
```bash
user@machine:~$ java -Xms64m -Xmx4096m -jar /path/to/beast -help
```
A typical run would look something like this 
```bash
user@machine:~$ java -Xms64m -Xmx4096m -Djava.library.path=/path/to/beagle -jar /path/to/beast -beagle_SSE -threads 8 input.xml
```

## How does it work?
BEAST feeds on ~~souls~~ XML input files that are supposed specify everything you need to run MCMC and get a posterior distribution for your parameters:
- Data!
- Likelihoods (i.e, models);
- Priors;
- Operators;
- Number of iterations, sampling frequency and auto-optimisation options.

Having everything in the same place makes it easy to share and reproduce analyses.

Now, what the heck is an "operator"?

In BEAST, we name Operators all of the MCMC **proposals**.
Example: how do you propose a new tree topology within the chain? Use a SubTreeSlide, NarrowExchange or Wilson-Balding operator.
Each operator is given a **weight**, that tells BEAST how often to perform that particular proposal.
In order to achieve better efficiency, some proposals in BEAST are **tunable**, which means their width (variance) can be adjusted such that we attain a certain acceptance probabiliy (usually around 0.234). We call this auto-optimise and it comes in two flavours: "default" and "log", which differ in how they relate proposal variance and acceptance probability.

### General architecture

Being coded in JAVA, BEAST is naturally sort of modular. The wide array of different necessary components to allow the kind of model complexity BEAST offers, however, calls for some more deliberate modularity in order to avoid conflicts and broken dependencies. BEAST2, for instance, capitalises on the general routines developed for BEAST but has a much stronger focus on modularity.

Ok, enough with the babbling. Let's go over to BEAST's [developer notes](https://code.google.com/p/beast-mcmc/wiki/DeveloperNotes) to take a look at the general internal structure.

## The XML configuration file format

Now that we ~~kinda~~ know how BEAST works in the inside, let's talk about one of the most important features of BEAST: its E**X**tensible **M**arkup **L**anguage ([XML](https://en.wikipedia.org/wiki/XML)) input file specification.

## Developing stuff for BEAST: an example

## References
- BEAST: papers [1](http://www.biomedcentral.com/1471-2148/7/214) and [2](http://mbe.oxfordjournals.org/content/29/8/1969);
- BEAGLE: [paper](http://sysbio.oxfordjournals.org/content/61/1/170)
- BEAST2: [paper](http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1003537)
