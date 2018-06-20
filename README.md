![Logo2PWM](https://github.com/gozhen/Logo2PWM/blob/master/server_source_code/server/app/static/LOGO2PWM_LOGO.png?raw=true "Logo2PWM")



Logo2PWM is a tool to convert sequence logo back to position weight matrix. 

In the field of molecular biology, there are often situations that in a publication, only the sequence logos of the motifs are provided, however, the corresponding PWMs are hard to be acquired. In order to do more researches on these motifs, we need a tool to quickly and accurately convert the sequence logos back to PWMs, that is why we made Logo2PWM.


## Folder description
[**_./source_code/_**](https://github.com/gozhen/Logo2PWM/tree/master/source_code) - source code

[**_./server_source_code/_**](https://github.com/gozhen/Logo2PWM/tree/master/server_source_code) - server source code

## Tutorial

### Run from source code
Download source code, open MATLAB, go to to the location of f_logo_to_PWM_publish.m (e.g.: ./source_code/):

```
>> f_logo_to_PWM_publish([logo image file])
```
or
```
>> f_logo_to_PWM_publish([logo image file], [#letter columns])
```
Please refer [**_this article_**](https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-017-4023-9) for demos, design and algorithms. 

<br>


### Compile and run executable
Install MATLAB compiler runtime 9.0; in MATLAB, input:

```
>> mcc -m f_logo_to_PWM_publish.m
```
The executable will be generated in place.

The sample compiled executables for **Windows** and **OSX** locate at **./server_source_code/** with name **f_logo_to_PWM_publish**.

To run executable, open a terminal/cmd:
```
$ [executable] [logo image file] [#letter columns (optional)]
```


### Deploy the server
Make sure Python and Flask are installed, then go to ./server_source_code/server/, run:
```
python ./run.py
```
[A running server](http://www.cs.utsa.edu/~jruan/logo2pwm/)

<br>

## Reference

Please support us by citing [**_this article_**](https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-017-4023-9):

BibTex:
```
 @article{gao2017logo2pwm,
  title={Logo2PWM: a tool to convert sequence logo to position weight matrix},
  author={Gao, Zhen and Liu, Lu and Ruan, Jianhua},
  journal={BMC genomics},
  volume={18},
  number={6},
  pages={709},
  year={2017},
  publisher={BioMed Central}
 }
```

Many thanks for your support!




