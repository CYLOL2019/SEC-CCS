/*
 * =============================================================
 * SampleUMDA.cpp
 *
 * Copyright (c) 2009 Aimin Zhou
 * Dept. of Computer Science & Technology
 * East China Normal Univ.
 * Shanghai, China
 * amzhou@cs.ecnu.edu.cn
 * =============================================================
 */

#include <cmath>
#include "mex.h"

// x = localsearch(fpop, xpop);
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{    
    int i, d, k, index; 
    // input 
    double *Probs = mxGetPr(prhs[0]);
    int NM = mxGetM(prhs[0]);           // number of margins
    int Dim= mxGetN(prhs[0]);           // variable dimension
    double *prob0 = mxGetPr(prhs[1]);
    int N = mxGetM(prhs[1]);            // number of new solutions 
    double *prob1 = mxGetPr(prhs[2]);
    double *range = mxGetPr(prhs[3]);   // ranges

    // output
    plhs[0] = mxCreateDoubleMatrix(N, Dim, mxREAL);
	double *pop = mxGetPr(plhs[0]);
    
    for(d=0; d<Dim; d++)
    {
        for(k=0; k<N; k++)
        {
            for(i=0; i<NM; i++)
            {
                if(i == NM-1)
                {
                    index = NM-1;
                }
                else if(prob0[d*N+k]<=Probs[d*NM+i])
                {
                    index = i;
                    break;
                }
            }
            pop[d*N+k] = range[d*(NM+1)+index] + prob1[d*N+k]*(range[d*(NM+1)+index+1]-range[d*(NM+1)+index]);
        }
    }
}
