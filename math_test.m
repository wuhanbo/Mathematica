(* ::Package:: *)

Print["test_by_Hanbo"];

SetDirectory["/mnt/scratch-lustre/hanbo/Plasim/T31/FT_Mathematica"];
Import["GraphPack2_0.m"];
Import["PlotGCM.m"];

FT[FileName_,OutputName_]:=
  Module[{ps,AbsSemiDiur,timeframe,lat,long},
	ps=LoadDiagfi[FileName,"ps"];
	timeframe=Dimensions[ps][[1]];
	lat=Dimensions[ps][[2]];
	long=Dimensions[ps][[3]];
	AbsSemiDiur = Table[Abs[Fourier[Table[ps[[t,x,y]],{t,1,timeframe}]]][[731]],{x,1,lat},{y,1,long}];
	Export[OutputName,AbsSemiDiur,"Table"];
	Clear[ps,AbsSemiDiur]
 ]

Table[FT["/mnt/scratch-lustre/hanbo/Plasim/T21/l20_"<>ToString[N[18+x/10,3]]<>"h/test2/ps.nc","/mnt/scratch-lustre/hanbo/Plasim/T21/FT_t31_l20/FT_t21_l20_"<>ToString[N[18+x/10,3]]<>"h"],{x,1,100}];
(*FT["/mnt/scratch-lustre/hanbo/Plasim/T31/l10_22.5h/test2/ps.nc","/mnt/scratch-lustre/hanbo/Plasim/T31/FT_t31_l10_22.5h"];*)


Exit[]




