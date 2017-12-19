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

1. See the section Assumptions below.
2. Run the script `./tools/reproduce.sh`
3. Evaluate the run files `./tools/wwwE_eval.sh`
4. Results can be found in `results/reproduce/eval` directory. The following
   files contain the official results:

    ```
    rmit_list.tid.test.nev.MSnDCG@0010
    rmit_list.tid.test.nev.nERR@0010
    rmit_list.tid.test.nev.Q@0010
    ```

    Additional unofficial evaluation results can be found in
    `rmit_list_eval_extra.txt`


## Assumptions

The following dependencies are assumed to be installed and available in your
`$PATH` environment:

* Indri 5.11
* [gdeval.pl][gdeval]
* [rbp\_eval][rbp_eval]
* [ntcir\_eval][ntcireval]

[gdeval]: http://trec.nist.gov/data/web/12/gdeval.pl
[rbp_eval]: http://people.eng.unimelb.edu.au/ammoffat/rbp_eval-0.2.tar.gz
[ntcireval]: http://research.nii.ac.jp/ntcir/tools/NTCIREVAL.161017.tar.gz


## ClueWeb12-B Index

A sample Indri index configuration file is provided in
`tools/cw12b_index.param`. This assumes you have a copy of the ClueWeb12-B
corpus and have extracted the inlink data with `harvestlinks`.
