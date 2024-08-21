# Phylogenetics of _Brno loanviruses_

> This is the repository for supplementary materials for the upcoming publication

**Files**:
- [`Lab_journal.ipynb`](https://github.com/PopovIILab/PhoBl/blob/main/Lab_journal.ipynb) - laboratory journal with commands to reproduce pipeline
- [`dstu_hantavirus_phylo.yaml`](https://github.com/PopovIILab/PhoBl/blob/main/dstu_hantavirus_phylo.yaml) - conda environment
- [`data`](https://github.com/PopovIILab/PhoBl/tree/main/data) - data folder:
  - [`accession_numbers.txt`](https://github.com/PopovIILab/PhoBl/blob/main/data/accession_numbers.txt) - list of accession numbers
  - [`all_seqs.fa`](https://github.com/PopovIILab/PhoBl/blob/main/data/all_seqs.fa) - downloaded sequences
  - [`all_seqs_mafft.fa`](https://github.com/PopovIILab/PhoBl/blob/main/data/all_seqs_mafft.fa) - alligned sequences
  - [`accession_organism.txt`](https://github.com/PopovIILab/PhoBl/blob/main/data/accession_organism.txt) - list of accession numbers and organisms' names available by that numbers
  - [`accession_host.txt`](https://github.com/PopovIILab/PhoBl/blob/main/data/accession_host.txt) - list of accession numbers and names of organisms from which the virus has been isolated
  - [`accession_order.txt`](https://github.com/PopovIILab/PhoBl/blob/main/data/accession_order.txt) - list of accession numbers and taxonomic order of organisms from which the virus has been isolated
  - [`dataset_for_iTOL.txt`](https://github.com/PopovIILab/PhoBl/blob/main/data/dataset_for_iTOL.txt) - dataset for tree annotation in iTOL
- [`model-finder`](https://github.com/PopovIILab/PhoBl/tree/main/model-finder) - folder with output files of ModelFinder launch:
  - [`tree_MF2.iqtree`](https://github.com/PopovIILab/PhoBl/blob/main/model-finder/tree_MF2.iqtree) - main file containing best substitution model
  - Bunch of log files
- [`tree`](https://github.com/PopovIILab/PhoBl/tree/main/tree) - folder with tree files:
  - [`tree_ufb.treefile`](https://github.com/PopovIILab/PhoBl/blob/main/tree/tree_ufb.treefile) - unannotated tree
  - [`annotated_tree.treefile`](https://github.com/PopovIILab/PhoBl/blob/main/tree/annotated_tree.treefile) - annotated tree
  - Bunch of log files
- [`map`](https://github.com/PopovIILab/PhoBl/tree/main/map) - folder with the `R` script to visualize the map

**Instruction**:
- Create new environment `dstu_hantavirus_phylo`
```bash
conda env create -f dstu_hantavirus_phylo.yaml
```

**Pipeline:**

<img src="https://github.com/PopovIILab/PhoBl/blob/main/imgs/PhoBl_pipeline_light.png#gh-light-mode-only" width="100%"/>
<img src="https://github.com/PopovIILab/PhoBl/blob/main/imgs/PhoBl_pipeline_dark.png#gh-dark-mode-only" width="100%"/>

_Figure 1. Pipeline overview._

📝 See [laboratory journal](https://github.com/PopovIILab/PhoBl/blob/main/Lab_journal.ipynb) for more details
