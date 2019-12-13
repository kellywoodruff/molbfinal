# Introduction
Goals for this poject:
-Learn how to find 16s sequences on NCBI of known bacteria found in the rumen of cattle.
-Create a FASTA files with these sequences.
-Align the FASTA file using MAFFT.
-Generate the phylogenetic tree using RAxML.
-Visualize the phylogenetic tree.

## Table of Contents
  1. Check to see if Git is aware of a project
  2. Initialize the project directory with git
  3. Generate project content
  4. Create GitHub Project
  5. Creating fasta file with known rumen microbial 16s sequences
  6. Sequence alignment with MAFFT
  7. Phylogenetic reconstruction with RAxML
  8. Phylogenetic tree visualization in R
  9. Perform Git operations & push to GitHub
  

### 1. Check to see if Git is aware of a project
  - Navigate to working space 
```sh
 cd /home/klomagno
 ```

  - Create a new project directory on the computer

```sh
$ mkdir molbfinal
$ cd molbfinal
```

### 2. Initialize the project directory with git
```sh
 $ git init
Initialized empty Git repository in /home/klomagno/molbfinal/.git/
```

### 3. Generate project content
```sh
$ vi README.md
```

---
title: Final Git Project
author: Kelly Woodurff
date: December 10, 2019
---

A git project to store files and folders associated with **Computers in Biology** final.


### 4. Create GitHub Project
I went to https://github.com/kellywoodruff
I created a new repository "molbfinal" (same as the file in Teton)


### 5. Creating fasta file with known rumen microbial 16s sequences

```sh
vi known16s.fasta
```
I researched various well known microbial species that are commonly found in the rumen. I tried to find various species from different phyla. Since we sequenced the 16s rRNA region of our samples I decided to find the 16s sequences on NCBI.


### 6. Sequence alignment with MAFFT

Now that the fasta file has been created with the various rumen microbe 16s sequences it needs to be aligned using mafft. 

```sh
$ module load swset gcc mafft
$ mafft --auto --thread 4 known16s.fasta > known16s.aln
```
```sh
$ cat known16s.aln
```
```sh
>Ruminococcus_flavefaciens
--------taataaagagtttgatcctggctcaggacgaacgctggcggcacgcttaaca
catgcaagtcgaacggaga-----acttttggtt--------------------------
-------------tactgagagttcttagtggcggacgggtgagtaacacgtgagcaacc
tgcctctgagagagggatagcttctggaaacggatggtaatacctcatgacataactga-
agggcatcctttggttatcaaa---------------gattcatcactcagagatgggct
cgcgtctgattaggtagatggtgaggtaacggcccaccatgccgacgatcagtagccgga
ctgagaggttgaacggccacattgggactgagacacggcccagactcctacgggaggcag
cagtggggaatattgcacaatgggggaaaccctgatgcagcgatgccgcgtggaggaaga
aggtttt-cggattgtaaactcctgtcttaaaggacga----------------------
-----taatgacggtactttaggaggaagctccggctaactacgtgccagcagccgcggt
aatacgtagggagcgagcgttgtccggaattactgggtgtaaagggagcgtaggcgggat
ggcaagtcaggtgtgaaaactatgggctcaacccatagactgcacttgaaactgttgttc
ttgagtgaagtagaggtaagcggaattcctggtgtagcggtgaaatgcgtagatatcagg
aggaacatcggtggcgaaggcggcttactgggcttttactgacgctgaggctcgaaagcg
tggggagcaaacaggattagataccctggtagtccacgctgtaaacgatgattactaggt
gtgggggga--ctgaccccttccgtgccgcagttaacacaataagtaatccacctgggga
gtacggccgcaaggttgaaactcaaaggaattgacgggggcccgcacaagcagtggagta
tgtggtttaattcgaagcaacgcgaagaaccttaccaggtcttgacat-cgtatgcatat
ctaagagattagagaaatcccttcggggacatatagacaggtggtgcatggttgtcgtca
gctcgtgtcgtgagatgttgggttaagtcccgcaacgagcgcaacccttacctttagttg
cta-------cgcaagagcactctaaagggactgccgttgacaaaacggaggaaggtggg
gatgacgtcaaatcatcatgccccttatgacctgggctacacacgtactacaatggcaat
taacaaagagaagcaagacggtgacgtggagcgaatctccaaaaat-tgtcccagttcag
attgcaggctgcaactcgcctgcatgaagtcggaattgctagtaatcgcggatcagc-at
gccgcggtgaatacgttcccgggccttgtacacaccgcccgtcacaccatgggagtcggt
aacacccgaagtcggtagtctaaca-gcaatgaggacgccgccgaaggtgggattgatga
ctggggtgaagtcgtaacaaggtagccgtatcggaaggtgcggctggatcacctcctttc
taaggagt
```

### 7. Phylogenetic reconstruction with RAxML
Now that we have an alignment file we can create a phylogentic tree using RAxML.

```sh
$ mkdir 16sTree
$ vi 16RAxML.sh 

#!/bin/bash
#SBATCH -J RAxML
#SBATCH -n 1
#SBATCH -t 30:00
#SBATCH --mem=20g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=klomagno@uwyo.edu
#SBATCH --ntasks-per-node=8
#SBATCH --account=cowusda2016

echo "Starting raxmlHPC run at $(date)"

module load swset gcc raxml

raxmlHPC-PTHREADS-AVX -T 8 -f a -m GTRGAMMA -p 618 -N 50 -x 309 -s known16s.aln -n 16sTree -w /home/klomagno/molbfinal/16sTree -o Ruminococcus_flavefaciens

echo "RAxML has finished at $(date)"
```
```sh
$ sbatch 16RAxML.sh
```
I went into the directory 16sTree that I just created to ensure all of the output is there
```sh
$ cd 16sTree/
$ ls
RAxML_bestTree.16sTree
RAxML_bipartitions.16sTree
RAxML_bipartitionsBranchLabels.16sTree
RAxML_bootstrap.16sTree
RAxML_info.16sTree
```
Check to see the output of the best tree that was created.
```sh
$ cat RAxML_bestTree.16sTree
```
```sh
((((Streptococcus_bovis:0.16537775848452915262,((Prevotella_bryantii:0.50600014228794099047,Bifidobacterium_adolescentis:0.23466079019831828645):0.09198423028406066404,Peptostreptococcus_anaerobius:0.14491390154585895300):0.02377578571902607893):0.05379502511162515682,(Selenomonas_ruminantium:0.07698844897650698738,Anaerovibrio_lipolytica:0.05816850204563332738):0.09140633276236968807):0.11122180427187193519,Ruminococcus_albus:0.04925394070084282427):0.03077921821255586929,Ruminococcus_flavefaciens:0.03077921821255586929);
```

### 8. Phylogenetic tree visualization 
Need to secure copy the best tree file to computer desktop.
Open up a local terminal.
```sh
$ scp klomagno@teton.uwyo.edu:/home/klomagno/molbfinal/16sTree/*.16sTree ~/Desktop/
```
Everything that ends with .16sTree in the 16sTree directory will be copied to the deskptop. I attempted this visualization in R as that was the original plan but I could not get the the package to work. I copied the best tree output into the website http://etetoolkit.org/treeview/ (I could not add the tree output to this document but it is my git repository). 


### 9. Perform Git operations & push to GitHub
```sh
$ git add README.md
```
```sh
$ git status
On branch master
No commits yet
Cahnges to be commited:
    (use "git rm --cached <file>..." to unstage)
    new file: README.md
```
```sh
$ git commit -m "Initial commit:Added README.md"
```
```sh
$ cd /home/klomagno/molbfinal
```
```sh
$ git config user.name "kellywoodruff"
$ git config user.email "kellylom@sbcglobal.net"
```
```sh
$ git remote add origin https://github.com/kellywoodruff/molbfinal.git
```
```sh 
$ git push -u origin master
```
```sh
Counting objects: 3, done.
Delta compression using up to 56 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 392 bytes | 0 bytes/s, done.
Total 3 (delta 0), reused 0 (delta 0)
To https://github.com/kellywoodruff/molbfinal.git
 * [new branch]      master -> master
Branch master set up to track remote branch master from origin.
```
Repeat for 16sRAxML.sh

```sh
$ git add 16sRAxML.sh
```
```sh
$ git commit -m "Initial commit:Added 16sRAxML.sh"
```
```sh
 1 file changed, 18 insertions(+)
 create mode 100644 16RAxML.sh
 ```
 ```sh
 $ git push -u origin master
 ```
 ```sh
 Counting objects: 4, done.
Delta compression using up to 56 threads.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 601 bytes | 0 bytes/s, done.
Total 3 (delta 0), reused 0 (delta 0)
To https://github.com/kellywoodruff/molbfinal.git
   b34c403..2cae8b2  master -> master
Branch master set up to track remote branch master from origin.
```
Then I directly uploaded the best tree output to the respository.