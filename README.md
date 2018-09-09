# BoxCoxTrans.jl

[![Build Status](https://travis-ci.org/tk3369/BoxCoxTrans.jl.svg?branch=master)](https://travis-ci.org/tk3369/BoxCoxTrans.jl)
[![codecov](https://codecov.io/gh/tk3369/BoxCoxTrans.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/tk3369/BoxCoxTrans.jl)
[![Coverage Status](https://coveralls.io/repos/github/tk3369/BoxCoxTrans.jl/badge.svg?branch=master)](https://coveralls.io/github/tk3369/BoxCoxTrans.jl?branch=master)

This package provides an implementation of Box Cox transformation.

Requires Julia 0.7/1.0.

## Installation

```
] add https://github.com/tk3369/BoxCoxTrans.jl
```

## Basic Usage

```
julia> using Distributions, UnicodePlots, BoxCoxTrans

julia> x = rand(Gamma(2,2), 10000) .+ 1;

julia> histogram(x)
               ┌────────────────────────────────────────┐ 
     (0.0,2.0] │▇▇▇▇▇▇▇▇▇ 899                           │ 
     (2.0,4.0] │▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3458 │ 
     (4.0,6.0] │▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2725        │ 
     (6.0,8.0] │▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 1497                    │ 
    (8.0,10.0] │▇▇▇▇▇▇▇▇ 794                            │ 
   (10.0,12.0] │▇▇▇ 336                                 │ 
   (12.0,14.0] │▇▇ 161                                  │ 
   (14.0,16.0] │▇ 75                                    │ 
   (16.0,18.0] │ 31                                     │ 
   (18.0,20.0] │ 11                                     │ 
   (20.0,22.0] │ 8                                      │ 
   (22.0,24.0] │ 4                                      │ 
   (24.0,26.0] │ 1                                      │ 
               └────────────────────────────────────────┘ 


julia> histogram(BoxCoxTrans.transform(x))
             ┌────────────────────────────────────────┐ 
   (0.0,0.5] │▇▇▇▇▇ 429                               │ 
   (0.5,1.0] │▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 1598                 │ 
   (1.0,1.5] │▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2916   │ 
   (1.5,2.0] │▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3077 │ 
   (2.0,2.5] │▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 1614                 │ 
   (2.5,3.0] │▇▇▇▇ 344                                │ 
   (3.0,3.5] │ 22                                     │ 
             └────────────────────────────────────────┘ 

```

## TL;DR

You can examine the power transform paremeter dervied by the program:
```
julia> BoxCoxTrans.lambda(x).value
0.024021300279245223
```

You can transfrom the data using your own λ:
```
julia> histogram(BoxCoxTrans.transform(x, 0.03))
             ┌────────────────────────────────────────┐ 
   (0.0,0.5] │▇▇▇▇▇ 425                               │ 
   (0.5,1.0] │▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 1584                 │ 
   (1.0,1.5] │▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2898   │ 
   (1.5,2.0] │▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3051 │ 
   (2.0,2.5] │▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 1647                 │ 
   (2.5,3.0] │▇▇▇▇ 366                                │ 
   (3.0,3.5] │ 29                                     │ 
             └────────────────────────────────────────┘ 
```

