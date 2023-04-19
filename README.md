#  Hierarchical Feature Selection Based on Label Distribution Learning (HFSLDL)
* HFSLDL is realized by matlab code.
* Algorithm function: HFSLDL.m 
* Test processes: HierSVMPredictionBatch.m
* HFSLE is compared with several hierarchical feature selection methods, such as: HFisher, HmRMR, HSDFS, HIFSRR, HFSDK.

## Prerequisite
* matlab2016a
* libsvm_3.20

## How to use
* run main.m

## Parameters
* hierarchical label enhancement parameters: α, β ∈ [0, 1]
* hierarchical feature learning parameters： λ1 = 10, λ2 = 0.1, λ3 = 0.1


# Citation
If you find this code useful for your research, please cite our paper.
@article{lin2022hierarchical,
  title={Hierarchical feature selection based on label distribution learning},
  author={Lin, Yaojin and Liu, Haoyang and Zhao, Hong and Hu, Qinghua and Zhu, Xingquan and Wu, Xindong},
  journal={IEEE Transactions on Knowledge and Data Engineering},
  year={2022},
  publisher={IEEE}
}
