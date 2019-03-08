/* Produced by CVXGEN, 2018-10-26 11:37:14 -0400.  */
/* CVXGEN is Copyright (C) 2006-2017 Jacob Mattingley, jem@cvxgen.com. */
/* The code in this file is Copyright (C) 2006-2017 Jacob Mattingley. */
/* CVXGEN, or solvers produced by CVXGEN, cannot be used for commercial */
/* applications without prior written permission from Jacob Mattingley. */

/* Filename: matrix_support.c. */
/* Description: Support functions for matrix multiplication and vector filling. */
#include "solver.h"
void multbymA(double *lhs, double *rhs) {
}
void multbymAT(double *lhs, double *rhs) {
  lhs[0] = 0;
  lhs[1] = 0;
  lhs[2] = 0;
  lhs[3] = 0;
  lhs[4] = 0;
}
void multbymG(double *lhs, double *rhs) {
  lhs[0] = -rhs[0]*(params.A[0])-rhs[1]*(params.A[51])-rhs[2]*(params.A[102])-rhs[3]*(params.A[153])-rhs[4]*(params.A[204]);
  lhs[1] = -rhs[0]*(params.A[1])-rhs[1]*(params.A[52])-rhs[2]*(params.A[103])-rhs[3]*(params.A[154])-rhs[4]*(params.A[205]);
  lhs[2] = -rhs[0]*(params.A[2])-rhs[1]*(params.A[53])-rhs[2]*(params.A[104])-rhs[3]*(params.A[155])-rhs[4]*(params.A[206]);
  lhs[3] = -rhs[0]*(params.A[3])-rhs[1]*(params.A[54])-rhs[2]*(params.A[105])-rhs[3]*(params.A[156])-rhs[4]*(params.A[207]);
  lhs[4] = -rhs[0]*(params.A[4])-rhs[1]*(params.A[55])-rhs[2]*(params.A[106])-rhs[3]*(params.A[157])-rhs[4]*(params.A[208]);
  lhs[5] = -rhs[0]*(params.A[5])-rhs[1]*(params.A[56])-rhs[2]*(params.A[107])-rhs[3]*(params.A[158])-rhs[4]*(params.A[209]);
  lhs[6] = -rhs[0]*(params.A[6])-rhs[1]*(params.A[57])-rhs[2]*(params.A[108])-rhs[3]*(params.A[159])-rhs[4]*(params.A[210]);
  lhs[7] = -rhs[0]*(params.A[7])-rhs[1]*(params.A[58])-rhs[2]*(params.A[109])-rhs[3]*(params.A[160])-rhs[4]*(params.A[211]);
  lhs[8] = -rhs[0]*(params.A[8])-rhs[1]*(params.A[59])-rhs[2]*(params.A[110])-rhs[3]*(params.A[161])-rhs[4]*(params.A[212]);
  lhs[9] = -rhs[0]*(params.A[9])-rhs[1]*(params.A[60])-rhs[2]*(params.A[111])-rhs[3]*(params.A[162])-rhs[4]*(params.A[213]);
  lhs[10] = -rhs[0]*(params.A[10])-rhs[1]*(params.A[61])-rhs[2]*(params.A[112])-rhs[3]*(params.A[163])-rhs[4]*(params.A[214]);
  lhs[11] = -rhs[0]*(params.A[11])-rhs[1]*(params.A[62])-rhs[2]*(params.A[113])-rhs[3]*(params.A[164])-rhs[4]*(params.A[215]);
  lhs[12] = -rhs[0]*(params.A[12])-rhs[1]*(params.A[63])-rhs[2]*(params.A[114])-rhs[3]*(params.A[165])-rhs[4]*(params.A[216]);
  lhs[13] = -rhs[0]*(params.A[13])-rhs[1]*(params.A[64])-rhs[2]*(params.A[115])-rhs[3]*(params.A[166])-rhs[4]*(params.A[217]);
  lhs[14] = -rhs[0]*(params.A[14])-rhs[1]*(params.A[65])-rhs[2]*(params.A[116])-rhs[3]*(params.A[167])-rhs[4]*(params.A[218]);
  lhs[15] = -rhs[0]*(params.A[15])-rhs[1]*(params.A[66])-rhs[2]*(params.A[117])-rhs[3]*(params.A[168])-rhs[4]*(params.A[219]);
  lhs[16] = -rhs[0]*(params.A[16])-rhs[1]*(params.A[67])-rhs[2]*(params.A[118])-rhs[3]*(params.A[169])-rhs[4]*(params.A[220]);
  lhs[17] = -rhs[0]*(params.A[17])-rhs[1]*(params.A[68])-rhs[2]*(params.A[119])-rhs[3]*(params.A[170])-rhs[4]*(params.A[221]);
  lhs[18] = -rhs[0]*(params.A[18])-rhs[1]*(params.A[69])-rhs[2]*(params.A[120])-rhs[3]*(params.A[171])-rhs[4]*(params.A[222]);
  lhs[19] = -rhs[0]*(params.A[19])-rhs[1]*(params.A[70])-rhs[2]*(params.A[121])-rhs[3]*(params.A[172])-rhs[4]*(params.A[223]);
  lhs[20] = -rhs[0]*(params.A[20])-rhs[1]*(params.A[71])-rhs[2]*(params.A[122])-rhs[3]*(params.A[173])-rhs[4]*(params.A[224]);
  lhs[21] = -rhs[0]*(params.A[21])-rhs[1]*(params.A[72])-rhs[2]*(params.A[123])-rhs[3]*(params.A[174])-rhs[4]*(params.A[225]);
  lhs[22] = -rhs[0]*(params.A[22])-rhs[1]*(params.A[73])-rhs[2]*(params.A[124])-rhs[3]*(params.A[175])-rhs[4]*(params.A[226]);
  lhs[23] = -rhs[0]*(params.A[23])-rhs[1]*(params.A[74])-rhs[2]*(params.A[125])-rhs[3]*(params.A[176])-rhs[4]*(params.A[227]);
  lhs[24] = -rhs[0]*(params.A[24])-rhs[1]*(params.A[75])-rhs[2]*(params.A[126])-rhs[3]*(params.A[177])-rhs[4]*(params.A[228]);
  lhs[25] = -rhs[0]*(params.A[25])-rhs[1]*(params.A[76])-rhs[2]*(params.A[127])-rhs[3]*(params.A[178])-rhs[4]*(params.A[229]);
  lhs[26] = -rhs[0]*(params.A[26])-rhs[1]*(params.A[77])-rhs[2]*(params.A[128])-rhs[3]*(params.A[179])-rhs[4]*(params.A[230]);
  lhs[27] = -rhs[0]*(params.A[27])-rhs[1]*(params.A[78])-rhs[2]*(params.A[129])-rhs[3]*(params.A[180])-rhs[4]*(params.A[231]);
  lhs[28] = -rhs[0]*(params.A[28])-rhs[1]*(params.A[79])-rhs[2]*(params.A[130])-rhs[3]*(params.A[181])-rhs[4]*(params.A[232]);
  lhs[29] = -rhs[0]*(params.A[29])-rhs[1]*(params.A[80])-rhs[2]*(params.A[131])-rhs[3]*(params.A[182])-rhs[4]*(params.A[233]);
  lhs[30] = -rhs[0]*(params.A[30])-rhs[1]*(params.A[81])-rhs[2]*(params.A[132])-rhs[3]*(params.A[183])-rhs[4]*(params.A[234]);
  lhs[31] = -rhs[0]*(params.A[31])-rhs[1]*(params.A[82])-rhs[2]*(params.A[133])-rhs[3]*(params.A[184])-rhs[4]*(params.A[235]);
  lhs[32] = -rhs[0]*(params.A[32])-rhs[1]*(params.A[83])-rhs[2]*(params.A[134])-rhs[3]*(params.A[185])-rhs[4]*(params.A[236]);
  lhs[33] = -rhs[0]*(params.A[33])-rhs[1]*(params.A[84])-rhs[2]*(params.A[135])-rhs[3]*(params.A[186])-rhs[4]*(params.A[237]);
  lhs[34] = -rhs[0]*(params.A[34])-rhs[1]*(params.A[85])-rhs[2]*(params.A[136])-rhs[3]*(params.A[187])-rhs[4]*(params.A[238]);
  lhs[35] = -rhs[0]*(params.A[35])-rhs[1]*(params.A[86])-rhs[2]*(params.A[137])-rhs[3]*(params.A[188])-rhs[4]*(params.A[239]);
  lhs[36] = -rhs[0]*(params.A[36])-rhs[1]*(params.A[87])-rhs[2]*(params.A[138])-rhs[3]*(params.A[189])-rhs[4]*(params.A[240]);
  lhs[37] = -rhs[0]*(params.A[37])-rhs[1]*(params.A[88])-rhs[2]*(params.A[139])-rhs[3]*(params.A[190])-rhs[4]*(params.A[241]);
  lhs[38] = -rhs[0]*(params.A[38])-rhs[1]*(params.A[89])-rhs[2]*(params.A[140])-rhs[3]*(params.A[191])-rhs[4]*(params.A[242]);
  lhs[39] = -rhs[0]*(params.A[39])-rhs[1]*(params.A[90])-rhs[2]*(params.A[141])-rhs[3]*(params.A[192])-rhs[4]*(params.A[243]);
  lhs[40] = -rhs[0]*(params.A[40])-rhs[1]*(params.A[91])-rhs[2]*(params.A[142])-rhs[3]*(params.A[193])-rhs[4]*(params.A[244]);
  lhs[41] = -rhs[0]*(params.A[41])-rhs[1]*(params.A[92])-rhs[2]*(params.A[143])-rhs[3]*(params.A[194])-rhs[4]*(params.A[245]);
  lhs[42] = -rhs[0]*(params.A[42])-rhs[1]*(params.A[93])-rhs[2]*(params.A[144])-rhs[3]*(params.A[195])-rhs[4]*(params.A[246]);
  lhs[43] = -rhs[0]*(params.A[43])-rhs[1]*(params.A[94])-rhs[2]*(params.A[145])-rhs[3]*(params.A[196])-rhs[4]*(params.A[247]);
  lhs[44] = -rhs[0]*(params.A[44])-rhs[1]*(params.A[95])-rhs[2]*(params.A[146])-rhs[3]*(params.A[197])-rhs[4]*(params.A[248]);
  lhs[45] = -rhs[0]*(params.A[45])-rhs[1]*(params.A[96])-rhs[2]*(params.A[147])-rhs[3]*(params.A[198])-rhs[4]*(params.A[249]);
  lhs[46] = -rhs[0]*(params.A[46])-rhs[1]*(params.A[97])-rhs[2]*(params.A[148])-rhs[3]*(params.A[199])-rhs[4]*(params.A[250]);
  lhs[47] = -rhs[0]*(params.A[47])-rhs[1]*(params.A[98])-rhs[2]*(params.A[149])-rhs[3]*(params.A[200])-rhs[4]*(params.A[251]);
  lhs[48] = -rhs[0]*(params.A[48])-rhs[1]*(params.A[99])-rhs[2]*(params.A[150])-rhs[3]*(params.A[201])-rhs[4]*(params.A[252]);
  lhs[49] = -rhs[0]*(params.A[49])-rhs[1]*(params.A[100])-rhs[2]*(params.A[151])-rhs[3]*(params.A[202])-rhs[4]*(params.A[253]);
  lhs[50] = -rhs[0]*(params.A[50])-rhs[1]*(params.A[101])-rhs[2]*(params.A[152])-rhs[3]*(params.A[203])-rhs[4]*(params.A[254]);
}
void multbymGT(double *lhs, double *rhs) {
  lhs[0] = -rhs[0]*(params.A[0])-rhs[1]*(params.A[1])-rhs[2]*(params.A[2])-rhs[3]*(params.A[3])-rhs[4]*(params.A[4])-rhs[5]*(params.A[5])-rhs[6]*(params.A[6])-rhs[7]*(params.A[7])-rhs[8]*(params.A[8])-rhs[9]*(params.A[9])-rhs[10]*(params.A[10])-rhs[11]*(params.A[11])-rhs[12]*(params.A[12])-rhs[13]*(params.A[13])-rhs[14]*(params.A[14])-rhs[15]*(params.A[15])-rhs[16]*(params.A[16])-rhs[17]*(params.A[17])-rhs[18]*(params.A[18])-rhs[19]*(params.A[19])-rhs[20]*(params.A[20])-rhs[21]*(params.A[21])-rhs[22]*(params.A[22])-rhs[23]*(params.A[23])-rhs[24]*(params.A[24])-rhs[25]*(params.A[25])-rhs[26]*(params.A[26])-rhs[27]*(params.A[27])-rhs[28]*(params.A[28])-rhs[29]*(params.A[29])-rhs[30]*(params.A[30])-rhs[31]*(params.A[31])-rhs[32]*(params.A[32])-rhs[33]*(params.A[33])-rhs[34]*(params.A[34])-rhs[35]*(params.A[35])-rhs[36]*(params.A[36])-rhs[37]*(params.A[37])-rhs[38]*(params.A[38])-rhs[39]*(params.A[39])-rhs[40]*(params.A[40])-rhs[41]*(params.A[41])-rhs[42]*(params.A[42])-rhs[43]*(params.A[43])-rhs[44]*(params.A[44])-rhs[45]*(params.A[45])-rhs[46]*(params.A[46])-rhs[47]*(params.A[47])-rhs[48]*(params.A[48])-rhs[49]*(params.A[49])-rhs[50]*(params.A[50]);
  lhs[1] = -rhs[0]*(params.A[51])-rhs[1]*(params.A[52])-rhs[2]*(params.A[53])-rhs[3]*(params.A[54])-rhs[4]*(params.A[55])-rhs[5]*(params.A[56])-rhs[6]*(params.A[57])-rhs[7]*(params.A[58])-rhs[8]*(params.A[59])-rhs[9]*(params.A[60])-rhs[10]*(params.A[61])-rhs[11]*(params.A[62])-rhs[12]*(params.A[63])-rhs[13]*(params.A[64])-rhs[14]*(params.A[65])-rhs[15]*(params.A[66])-rhs[16]*(params.A[67])-rhs[17]*(params.A[68])-rhs[18]*(params.A[69])-rhs[19]*(params.A[70])-rhs[20]*(params.A[71])-rhs[21]*(params.A[72])-rhs[22]*(params.A[73])-rhs[23]*(params.A[74])-rhs[24]*(params.A[75])-rhs[25]*(params.A[76])-rhs[26]*(params.A[77])-rhs[27]*(params.A[78])-rhs[28]*(params.A[79])-rhs[29]*(params.A[80])-rhs[30]*(params.A[81])-rhs[31]*(params.A[82])-rhs[32]*(params.A[83])-rhs[33]*(params.A[84])-rhs[34]*(params.A[85])-rhs[35]*(params.A[86])-rhs[36]*(params.A[87])-rhs[37]*(params.A[88])-rhs[38]*(params.A[89])-rhs[39]*(params.A[90])-rhs[40]*(params.A[91])-rhs[41]*(params.A[92])-rhs[42]*(params.A[93])-rhs[43]*(params.A[94])-rhs[44]*(params.A[95])-rhs[45]*(params.A[96])-rhs[46]*(params.A[97])-rhs[47]*(params.A[98])-rhs[48]*(params.A[99])-rhs[49]*(params.A[100])-rhs[50]*(params.A[101]);
  lhs[2] = -rhs[0]*(params.A[102])-rhs[1]*(params.A[103])-rhs[2]*(params.A[104])-rhs[3]*(params.A[105])-rhs[4]*(params.A[106])-rhs[5]*(params.A[107])-rhs[6]*(params.A[108])-rhs[7]*(params.A[109])-rhs[8]*(params.A[110])-rhs[9]*(params.A[111])-rhs[10]*(params.A[112])-rhs[11]*(params.A[113])-rhs[12]*(params.A[114])-rhs[13]*(params.A[115])-rhs[14]*(params.A[116])-rhs[15]*(params.A[117])-rhs[16]*(params.A[118])-rhs[17]*(params.A[119])-rhs[18]*(params.A[120])-rhs[19]*(params.A[121])-rhs[20]*(params.A[122])-rhs[21]*(params.A[123])-rhs[22]*(params.A[124])-rhs[23]*(params.A[125])-rhs[24]*(params.A[126])-rhs[25]*(params.A[127])-rhs[26]*(params.A[128])-rhs[27]*(params.A[129])-rhs[28]*(params.A[130])-rhs[29]*(params.A[131])-rhs[30]*(params.A[132])-rhs[31]*(params.A[133])-rhs[32]*(params.A[134])-rhs[33]*(params.A[135])-rhs[34]*(params.A[136])-rhs[35]*(params.A[137])-rhs[36]*(params.A[138])-rhs[37]*(params.A[139])-rhs[38]*(params.A[140])-rhs[39]*(params.A[141])-rhs[40]*(params.A[142])-rhs[41]*(params.A[143])-rhs[42]*(params.A[144])-rhs[43]*(params.A[145])-rhs[44]*(params.A[146])-rhs[45]*(params.A[147])-rhs[46]*(params.A[148])-rhs[47]*(params.A[149])-rhs[48]*(params.A[150])-rhs[49]*(params.A[151])-rhs[50]*(params.A[152]);
  lhs[3] = -rhs[0]*(params.A[153])-rhs[1]*(params.A[154])-rhs[2]*(params.A[155])-rhs[3]*(params.A[156])-rhs[4]*(params.A[157])-rhs[5]*(params.A[158])-rhs[6]*(params.A[159])-rhs[7]*(params.A[160])-rhs[8]*(params.A[161])-rhs[9]*(params.A[162])-rhs[10]*(params.A[163])-rhs[11]*(params.A[164])-rhs[12]*(params.A[165])-rhs[13]*(params.A[166])-rhs[14]*(params.A[167])-rhs[15]*(params.A[168])-rhs[16]*(params.A[169])-rhs[17]*(params.A[170])-rhs[18]*(params.A[171])-rhs[19]*(params.A[172])-rhs[20]*(params.A[173])-rhs[21]*(params.A[174])-rhs[22]*(params.A[175])-rhs[23]*(params.A[176])-rhs[24]*(params.A[177])-rhs[25]*(params.A[178])-rhs[26]*(params.A[179])-rhs[27]*(params.A[180])-rhs[28]*(params.A[181])-rhs[29]*(params.A[182])-rhs[30]*(params.A[183])-rhs[31]*(params.A[184])-rhs[32]*(params.A[185])-rhs[33]*(params.A[186])-rhs[34]*(params.A[187])-rhs[35]*(params.A[188])-rhs[36]*(params.A[189])-rhs[37]*(params.A[190])-rhs[38]*(params.A[191])-rhs[39]*(params.A[192])-rhs[40]*(params.A[193])-rhs[41]*(params.A[194])-rhs[42]*(params.A[195])-rhs[43]*(params.A[196])-rhs[44]*(params.A[197])-rhs[45]*(params.A[198])-rhs[46]*(params.A[199])-rhs[47]*(params.A[200])-rhs[48]*(params.A[201])-rhs[49]*(params.A[202])-rhs[50]*(params.A[203]);
  lhs[4] = -rhs[0]*(params.A[204])-rhs[1]*(params.A[205])-rhs[2]*(params.A[206])-rhs[3]*(params.A[207])-rhs[4]*(params.A[208])-rhs[5]*(params.A[209])-rhs[6]*(params.A[210])-rhs[7]*(params.A[211])-rhs[8]*(params.A[212])-rhs[9]*(params.A[213])-rhs[10]*(params.A[214])-rhs[11]*(params.A[215])-rhs[12]*(params.A[216])-rhs[13]*(params.A[217])-rhs[14]*(params.A[218])-rhs[15]*(params.A[219])-rhs[16]*(params.A[220])-rhs[17]*(params.A[221])-rhs[18]*(params.A[222])-rhs[19]*(params.A[223])-rhs[20]*(params.A[224])-rhs[21]*(params.A[225])-rhs[22]*(params.A[226])-rhs[23]*(params.A[227])-rhs[24]*(params.A[228])-rhs[25]*(params.A[229])-rhs[26]*(params.A[230])-rhs[27]*(params.A[231])-rhs[28]*(params.A[232])-rhs[29]*(params.A[233])-rhs[30]*(params.A[234])-rhs[31]*(params.A[235])-rhs[32]*(params.A[236])-rhs[33]*(params.A[237])-rhs[34]*(params.A[238])-rhs[35]*(params.A[239])-rhs[36]*(params.A[240])-rhs[37]*(params.A[241])-rhs[38]*(params.A[242])-rhs[39]*(params.A[243])-rhs[40]*(params.A[244])-rhs[41]*(params.A[245])-rhs[42]*(params.A[246])-rhs[43]*(params.A[247])-rhs[44]*(params.A[248])-rhs[45]*(params.A[249])-rhs[46]*(params.A[250])-rhs[47]*(params.A[251])-rhs[48]*(params.A[252])-rhs[49]*(params.A[253])-rhs[50]*(params.A[254]);
}
void multbyP(double *lhs, double *rhs) {
  /* TODO use the fact that P is symmetric? */
  /* TODO check doubling / half factor etc. */
  lhs[0] = 0;
  lhs[1] = 0;
  lhs[2] = 0;
  lhs[3] = 0;
  lhs[4] = 0;
}
void fillq(void) {
  work.q[0] = 0;
  work.q[1] = 0;
  work.q[2] = 0;
  work.q[3] = 0;
  work.q[4] = 0;
}
void fillh(void) {
  work.h[0] = params.b[0];
  work.h[1] = params.b[1];
  work.h[2] = params.b[2];
  work.h[3] = params.b[3];
  work.h[4] = params.b[4];
  work.h[5] = params.b[5];
  work.h[6] = params.b[6];
  work.h[7] = params.b[7];
  work.h[8] = params.b[8];
  work.h[9] = params.b[9];
  work.h[10] = params.b[10];
  work.h[11] = params.b[11];
  work.h[12] = params.b[12];
  work.h[13] = params.b[13];
  work.h[14] = params.b[14];
  work.h[15] = params.b[15];
  work.h[16] = params.b[16];
  work.h[17] = params.b[17];
  work.h[18] = params.b[18];
  work.h[19] = params.b[19];
  work.h[20] = params.b[20];
  work.h[21] = params.b[21];
  work.h[22] = params.b[22];
  work.h[23] = params.b[23];
  work.h[24] = params.b[24];
  work.h[25] = params.b[25];
  work.h[26] = params.b[26];
  work.h[27] = params.b[27];
  work.h[28] = params.b[28];
  work.h[29] = params.b[29];
  work.h[30] = params.b[30];
  work.h[31] = params.b[31];
  work.h[32] = params.b[32];
  work.h[33] = params.b[33];
  work.h[34] = params.b[34];
  work.h[35] = params.b[35];
  work.h[36] = params.b[36];
  work.h[37] = params.b[37];
  work.h[38] = params.b[38];
  work.h[39] = params.b[39];
  work.h[40] = params.b[40];
  work.h[41] = params.b[41];
  work.h[42] = params.b[42];
  work.h[43] = params.b[43];
  work.h[44] = params.b[44];
  work.h[45] = params.b[45];
  work.h[46] = params.b[46];
  work.h[47] = params.b[47];
  work.h[48] = params.b[48];
  work.h[49] = params.b[49];
  work.h[50] = params.b[50];
}
void fillb(void) {
}
void pre_ops(void) {
}
