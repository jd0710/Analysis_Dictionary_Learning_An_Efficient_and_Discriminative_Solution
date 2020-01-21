# Analysis Dictionary Learning: An Efficient and Discriminative Solution
This repository contains the demo and MATLAB codes for our conference paper: "[Analysis Dictionary Learning: An Efficient and Discriminative Solution](https://arxiv.org/abs/1903.03058)" by [Wen Tang](https://research.ece.ncsu.edu/vissta/wen-tang/), Ashkan Panahi, Hamid Krim and Liyi Dai, which is published in ICASSP 2019.

### Citation
If you think our project is useful, please consider citing it:
```
@inproceedings{tang2019analysis,
  title={Analysis Dictionary Learning: an Efficient and Discriminative Solution},
  author={Tang, Wen and Panahi, Ashkan and Krim, Hamid and Dai, Liyi},
  booktitle={ICASSP 2019-2019 IEEE International Conference on Acoustics, Speech and Signal Processing (ICASSP)},
  pages={3682--3686},
  year={2019},
  organization={IEEE}
}
```

## Introduction
Discriminative Convolutional Analysis Dictionary Learning (DCADL) method, as a lower cost Discriminative DL framework, to both characterize the image structures and refine the interclass structure representations. The proposed DCADL jointly learns a convolutional analysis dictionary and a universal classifier, while greatly reducing the time complexity in both training and testing phases, and achieving a competitive accuracy, thus demonstrating great performance in many experiments with standard databasets.

### Discriminative Convolutional Analysis Dictionary Learning
An intuitive DCADL frameworkis defined as follows:
<img src="https://latex.codecogs.com/svg.latex?\arg\min_{\omega_i,u^i_j,W}~\sum_{j=1}^n\sum_{i=1}^{m}\left(\frac{1}{2}\|\omega_i\ast&space;x_j-u^i_j\|^2_2+\lambda_1\|u^i_j\|_1\right)+\frac{\lambda_2}{2}\|Y-W\tilde{U}\|_F^2," title="DCADL1" />
<img src="https://latex.codecogs.com/svg.latex?s.t.~\|\omega_i\|^2_2\leq&space;1;~\forall&space;i=1,\dots,m,~\tilde{U}=\begin{bmatrix}u^1_1&\cdots&u^1_n\\&space;\vdots&\ddots&\vdots\\&space;u^m_1&\cdots&u^m_n\\&space;\end{bmatrix}," title="SADL2" />

Noting that conventional ADL formulations rely on matrix multiplication for efficient solution, we reformulate above convolutional ADL problem by assuming that images have no zero-padding. In this case, we segment an image <img src="https://latex.codecogs.com/svg.latex?x_i"> into <img src="https://latex.codecogs.com/svg.latex?p"> patches <img src="https://latex.codecogs.com/svg.latex?[x_{i_1},\dots,x_{i_p}]"> with <img src="https://latex.codecogs.com/svg.latex?s\times&space;s"> pixels, being of the same size as the atom, and let 
<img src="https://latex.codecogs.com/svg.latex?\bar{X}=[x_{1_1},\dots,x_{1_p},\dots,x_{n_1},\dots,x_{n_p}]&space;\in\mathbb{R}^{s^2\times&space;np}"> and <img src="https://latex.codecogs.com/svg.latex?\bar{U}=\begin{bmatrix}&space;u_{1_1}^1&\cdots&u_{1_p}^1&\cdots&u_{n_1}^1&\cdots&u_{n_p}^1\\&space;\vdots&\ddots&\vdots&\ddots&\vdots&\ddots&\vdots\\&space;u_{1_1}^m&\cdots&u_{1_p}^m&\cdots&u_{n_1}^m&\cdots&u_{n_p}^m\\&space;\end{bmatrix}\in\mathbb{R}^{m\times&space;np}">.

The above DCADL can then be rewritten in the same form as the one of the conventional ADL with two reshaping operators with <img src="https://latex.codecogs.com/svg.latex?U"> :

<img src="https://latex.codecogs.com/svg.latex?\arg\min_{\substack{\Omega,\bar{U},W\\&space;\hat{U},\tilde{U}}}~\frac{1}{2}\|\Omega\bar{X}-\bar{U}\|^2_F+\lambda_1\|\hat{U}\|_1+\frac{\lambda_2}{2}\|Y-W\tilde{U}\|_F^2,">

<img src="https://latex.codecogs.com/svg.latex?s.t.~\|\omega_i\|^2_2\leq&space;1;~\forall&space;i=1,\dots,m,~\hat{U}=\begin{bmatrix}&space;u^1_{1_1}&u^2_{1_1}&\cdots&u^m_{n_1}\\&space;\vdots&\vdots&\ddots&\vdots\\&space;u^1_{1_p}&u^2_{1_p}&\cdots&u^m_{n_p}\\&space;\end{bmatrix},~\tilde{U}=\begin{bmatrix}&space;u^1_{1_1}&\cdots&u^1_{n_1}\\&space;\vdots&\ddots&\vdots\\u^m_{1_p}&\cdots&u^m_{n_p}\\&space;\end{bmatrix}">

Such kind of transformation greatly reduce the excessive training time and to ensure the capability of characterizing structuresamong individual images and across classes.

## Contacts
email: wtang6@ncsu.edu
