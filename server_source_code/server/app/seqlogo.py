#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Fri Jul 20 16:24:17 2018

@author: zhengao

Thanks for ImportanceOfBeingErnes and rightskewed on this thread:
    https://stackoverflow.com/questions/42615527/sequence-logos-in-matplotlib
    -aligning-xticks
"""

from numpy import genfromtxt
import matplotlib as mpl
from matplotlib.text import TextPath
from matplotlib.patches import PathPatch
from matplotlib.font_manager import FontProperties
import matplotlib.pyplot as plt
from numpy import log2
#from numpy import argsort
#from numpy import array
#from operator import itemgetter


fp = FontProperties(family="Arial", weight="bold") 
globscale = 1.35

global LETTERS
LETTERS = { "A" : TextPath((-0.35, 0), "A", size=1, prop=fp), \
            "C" : TextPath((-0.366, 0), "C", size=1, prop=fp),\
            "G" : TextPath((-0.384, 0), "G", size=1, prop=fp),\
            "T" : TextPath((-0.305, 0), "T", size=1, prop=fp)}

COLOR_SCHEME = {'A': 'darkgreen', 'C': 'blue', 'G': 'orange', 'T': 'red' }

def f_entropy(col):
    '''
    input a column of matrix (probabilities of A, C, G and T), output the 
      entropy
    '''
    return -sum([p*log2(p) for p in col])

#print f_entropy(mat[:, 4])


def f_letter_height(col):
    '''
    input a column of matrix (probabilities of A, C, G and T), output the 
      relative height of each letter to the Information content
    '''
    I = 2 - f_entropy(col)
    return [I*p for p in col]


def f_pwm2height(pwm):
    '''
    convert the probability matrix to information content height matrix
    '''
    return [f_letter_height(e) for e in pwm]
    
#print f_pwm2height(a)


def letterAt(LETTERS, letter, x, y, yscale=1, ax=None):
    text = LETTERS[letter]

    t = mpl.transforms.Affine2D().scale(1*globscale, yscale*globscale) + \
        mpl.transforms.Affine2D().translate(x,y) + ax.transData
    p = PathPatch(text, lw=0, fc=COLOR_SCHEME[letter],  transform=t)
    if ax != None:
        ax.add_artist(p)
    return p

def f_convert_pwm_col(a):
    '''
    input a col of PWM, output a list with the format of python seqlogo element
    '''
    return sorted([('A',a[0]),('C',a[1]),('G',a[2]),('T',a[3])],key=lambda x:x[1])
        

def f_read_pwm_file(fn):
    '''
    read the pwm txt file, convert it to seq logo format
    '''
    mat = list( genfromtxt(fn, delimiter=',')[:,:-1].transpose() )
    mat = f_pwm2height(mat)
    py_pwm = []
    for e in mat:
        py_pwm.append(f_convert_pwm_col(e))
    return py_pwm

## test
#fn = '/Users/zhengao/Dropbox/share/Logo2PWM/server_source_code/examples/abcde.csv'
#fn = '/Users/zhengao/Dropbox/share/Logo2PWM/server_source_code/examples/ABF1.csv'
#print f_read_pwm_file(fn)
#py_pwm = f_read_pwm_file(fn)

def f_plot_seqlogo(py_pwm):
    '''
    input the python format pwm, draw the seq logo
    '''
    fig, ax = plt.subplots(figsize=(10,3))
    
    x = 1
    maxi = 0
    for e in py_pwm:
        print e
        y = 0
        for base, score in e:
            letterAt(LETTERS, base, x, y, score, ax)
            y += score
        x += 1
        maxi = max(maxi, y)
    
    plt.xticks(range(1,x))
    plt.xlim((0, x)) 
    plt.ylim((0, 2)) 
    plt.tight_layout()      
    plt.show()
    return fig
    
#fn = '/Users/zhengao/Dropbox/share/Logo2PWM/server_source_code/server/app/'+\
#    'templates/files/423312551620motif1_553.csv'
#fn = '/Users/zhengao/Dropbox/share/Logo2PWM/server_source_code/server/app/'+\
#    'templates/files/a.csv'
#fn = '/Users/zhengao/Dropbox/share/Logo2PWM/server_source_code/server/app/'+\
#    'templates/files/ACE2.csv'
#fn = '/Users/zhengao/Dropbox/share/Logo2PWM/server_source_code/server/app/'+\
#    'templates/files/image_111.csv'
#py_pwm = f_read_pwm_file(fn)
#f_plot_seqlogo(py_pwm)


def f_draw_logo_from_pwm(fn_csv):
    '''
    input the pwm in a csv file, draw the logo and save it into an image.
    '''
    py_pwm = f_read_pwm_file(fn_csv)
    fn_rg_logo = fn_csv[:-4] + '_rg_logo.png'
    fig = f_plot_seqlogo(py_pwm)
    
    fig.savefig(fn_rg_logo)

fn_csv = '/Users/zhengao/Dropbox/share/Logo2PWM/server_source_code/server/app/'+\
    'templates/files/image_111.csv'
f_draw_logo_from_pwm(fn_csv)

























































































