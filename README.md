# RMIT at the NTCIR-13 We Want Web Task

Reproducibility scripts for the WWW English subtask at [NTCIR-13][ntcir].

    @inproceedings{gmb+17ntcir,
      author = {L. Gallagher and J. Mackenzie and R. Benham and R.~-C. Chen and F. Scholer and J. S. Culpepper},
      title = {RMIT at the {NTCIR-13 We Want Web Task}},
      booktitle = {Proc. NTCIR-13},
      year = {2017},
    }

[ntcir]: http://research.nii.ac.jp/ntcir/workshop/OnlineProceedings13/NTCIR/toc_ntcir.html


## Steps to reproduce

1. Run the script `./tools/reproduce.sh`
2. Evaluate the run files `./tools/evaluate.sh`


## ClueWeb12-B Index

A sample Indri index configuration file is provided in
`tools/cw12b_index.param`. This assumes you have a copy of the ClueWeb12-B
corpus and have extracted the inlink data with `harvestlinks`.
