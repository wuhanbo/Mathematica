(* ::Package:: *)

(************************************************************************)
(* This file was generated automatically by the Mathematica front end.  *)
(* It contains Initialization cells from a Notebook file, which         *)
(* typically will have the same name as this file except ending in      *)
(* ".nb" instead of ".m".                                               *)
(*                                                                      *)
(* This file is intended to be loaded into the Mathematica kernel using *)
(* the package loading commands Get or Needs.  Doing so is equivalent   *)
(* to using the Evaluate Initialization Cells menu command in the front *)
(* end.                                                                 *)
(*                                                                      *)
(* DO NOT EDIT THIS FILE.  This entire file is regenerated              *)
(* automatically each time the parent Notebook file is saved in the     *)
(* Mathematica front end.  Any changes you make to this file will be    *)
(* overwritten.                                                         *)
(************************************************************************)



imageSize=300;
marginsize=2;
gray=0.85;nlon=64;nlat=48;
SetOptions[ListContourPlot,
FrameTicks->{Table[{i,(i/nlon-0.5)*360},{i,0,nlon,16}],Table[{i,(i/nlat-0.5)*180},{i,0,nlat,12}]},
ColorFunctionScaling->False,
FrameStyle->Medium,
AspectRatio->1/GoldenRatio,
ImageSize->{imageSize,Automatic},
PreserveImageOptions->Automatic,
Background->White,
ImageMargins->marginsize];
SetOptions[ListStreamPlot,
FrameTicks->{Table[{i,(i/nlon-0.5)*360},{i,0,nlon,16}],Table[{i,(i/nlat-0.5)*180},{i,0,nlat,12}]},
StreamStyle->Directive[Black],
StreamPoints->{Automatic,Scaled[0.05]},
ColorFunctionScaling->False,
FrameStyle->Medium,
AspectRatio->1/GoldenRatio,
ImageSize->{imageSize,Automatic},
PreserveImageOptions->Automatic,
Background->White,
ImageMargins->marginsize];


lonlatframe={Style["longitude (\[Degree])",14,FontFamily->"Helvetica",FontWeight->"Bold"],Style["latitude (\[Degree])",14,FontFamily->"Helvetica",FontWeight->"Bold"]};
lonlattick[nlonnlat_]:={Table[{i,((i-1)/nlonnlat[[1]]-0.5)*360},{i,1,nlonnlat[[1]]+1,nlonnlat[[1]]/4}],Table[{i,((i-1)/nlonnlat[[2]]-0.5)*180},{i,1,nlonnlat[[2]]+1,nlonnlat[[2]]/4}]};
lonalttick[nlonnlat_,alt_]:={Table[{i,((i-1)/nlonnlat[[2]]-0.5)*180},{i,1,nlonnlat[[2]]+1,nlonnlat[[2]]/4}],Table[{jj,alt[[jj]]},{jj,1,Length[alt],5}]};
lonalttick[nlonnlat_,alt_]:={Table[{i,Switch[((i-1)/nlonnlat[[2]]-0.5)*180,-90,"90S",-45,"45S"]},{i,1,nlonnlat[[2]]+1,nlonnlat[[2]]/4}],Table[{jj,alt[[jj]]},{jj,1,Length[alt],5}]}


Options[LoadDiagfi]={TimeAve->{0,0},AreaAve->"False",Area->{},PosVal->"False",Extrema->"False"};
Options[WindMap]={TimeAve->{0,0}};
Options[ZonalWind]={TimeAve->{1,-1},MolarMass0->191,Gravity0->3.68856};
Options[ZonalMeanCut]={TimeAve->{1,-1},MolarMass0->191,Gravity0->3.68856};
Options[MeridionalCut]={TimeAve->{1,-1},MolarMass0->191,Gravity0->3.68856};
Options[StreamFunction]={TimeAve->{1,-1},Variable->"psi",MolarMass0->191,Gravity0->3.68856};
LoadDiagfi[name_,var_,OptionsPattern[]]:=Module[{raw,dim,dims,area,totarea,averagearea,control,time},
raw=Import[name,{"Datasets", var}];
dims=Dimensions[raw];
(*Print[dims];*)
dim=Length[dims];
raw=If[OptionValue[PosVal]=="True",Map[If[#>= 0.,#,0.]&,raw,{dim}],raw];
raw=If[dim>=2,Reverse[raw,dim-1],raw];
raw=If[OptionValue[TimeAve]=={0,0},raw,Mean[raw[[OptionValue[TimeAve][[1]];;OptionValue[TimeAve][[2]]]]]];
averagearea=Which[OptionValue[AreaAve]=="All",{Range[dims[[-2]]],Range[dims[[-1]]-1]},OptionValue[AreaAve]=="Day",{Range[dims[[-2]]],Table[ii,{ii,Round[(dims[[-1]]-1)/4]+1,Round[3(dims[[-1]]-1)/4]}]},
OptionValue[AreaAve]=="SubSol",{Range[Round[(dims[[-2]]-1)/2]-1,Round[(dims[[-2]]-1)/2]+1],Range[Round[(dims[[-1]]-1)/2]-1,Round[(dims[[-1]]-1)/2]+1]},
OptionValue[AreaAve]=="Night",{Range[dims[[-2]]],Union[Table[ii,{ii,1,Round[(dims[[-1]]-1)/4]}],Table[ii,{ii,Round[3(dims[[-1]]-1)/4]+1,dims[[-1]]-1}]]},
OptionValue[AreaAve]=="Equator",
{Table[ii,{ii,Round[(dims[[-2]]-1)*60/180]+1,Round[(dims[[-2]]-1)*120/180]+1}],Range[dims[[-1]]-1]},
OptionValue[AreaAve]=="Poles",
{Union[Table[ii,{ii,1,Round[(dims[[-2]]-1)*60/180]}],Table[ii,{ii,Round[(dims[[-2]]-1)*120/180]+2,dims[[-2]]}]],Range[dims[[-1]]-1]},
OptionValue[AreaAve]=="NPole",
{Table[ii,{ii,1,Round[(dims[[-2]]-1)*30/180]}],Range[dims[[-1]]-1]},
OptionValue[AreaAve]=="SPole",
{Table[ii,{ii,Round[(dims[[-2]]-1)*150/180]+2,dims[[-2]]}],Range[dims[[-1]]-1]},
OptionValue[AreaAve]=="Equator Night",
{Table[ii,{ii,Round[(dims[[-2]]-1)*60/180]+1,Round[(dims[[-2]]-1)*120/180]+1}],Union[Table[ii,{ii,1,Round[(dims[[-1]]-1)/4]}],Table[ii,{ii,Round[3(dims[[-1]]-1)/4]+1,dims[[-1]]-1}]]},
OptionValue[AreaAve]=="Poles Night",
{Union[Table[ii,{ii,1,Round[(dims[[-2]]-1)*60/180]}],Table[ii,{ii,Round[(dims[[-2]]-1)*120/180]+2,dims[[-2]]}]],Union[Table[ii,{ii,1,Round[(dims[[-1]]-1)/4]}],Table[ii,{ii,Round[3(dims[[-1]]-1)/4]+1,dims[[-1]]-1}]]},
OptionValue[AreaAve]=="Equator Day",
{Table[ii,{ii,Round[(dims[[-2]]-1)*60/180]+1,Round[(dims[[-2]]-1)*120/180]+1}],Table[ii,{ii,Round[(dims[[-1]]-1)/4]+1,Round[3(dims[[-1]]-1)/4]}]},
OptionValue[AreaAve]=="Poles Day",
{Union[Table[ii,{ii,1,Round[(dims[[-2]]-1)*60/180]}],Table[ii,{ii,Round[(dims[[-2]]-1)*120/180]+2,dims[[-2]]}]],Table[ii,{ii,Round[(dims[[-1]]-1)/4]+1,Round[3(dims[[-1]]-1)/4]}]},
1==1,OptionValue[AreaAve]];
raw=If[
OptionValue[AreaAve]!="False",
area=If[OptionValue[Area]=={},Reverse[Import[name,{"Datasets", "aire"}]],OptionValue[Area]];
totarea=Total[area[[averagearea[[1]],averagearea[[2]]]],2];
If[Length[Dimensions[raw]]==2,Total[(area*raw)[[averagearea[[1]],averagearea[[2]]]],2]/totarea,Map[Total[(area*#)[[averagearea[[1]],averagearea[[2]]]],2]/totarea&,raw,{Length[Dimensions[raw]]-2}]],
raw
];
(*Print[raw];*)
raw=Which[
OptionValue[Extrema]=="False",
raw,
OptionValue[Extrema]=="Min",
raw=If[Length[Dimensions[raw]]==2,Min[Flatten[raw]],Map[Min[Flatten[#]]&,raw]],
OptionValue[Extrema]=="Max",
raw=If[Length[Dimensions[raw]]==2,Max[Flatten[raw]],Map[Max[Flatten[#]]&,raw]]
];
raw=If[Length[Dimensions[raw]]==1&&(OptionValue[AreaAve]!= "False"||OptionValue[Extrema]!= "False")&&OptionValue[TimeAve]=={0,0},
control=Import[name,{"Datasets","controle"}];
time=Import[name,{"Datasets","Time"}]+control[[4]];
Transpose[{time,raw}],
raw];
raw
];
WindMap[name_,OptionsPattern[]]:=Module[{u,v,dims,uv},
u=LoadDiagfi[name,"u",TimeAve->OptionValue[TimeAve]];
v=LoadDiagfi[name,"v",TimeAve->OptionValue[TimeAve]];
dims=Dimensions[u];
uv=If[Length[dims]==4,Table[{u[[ii,jj,ll,kk]],v[[ii,jj,ll,kk]]},{ii,1,dims[[1]]},{jj,1,dims[[2]]},{kk,1,dims[[4]]},{ll,1,dims[[3]]}],Table[{u[[ii,kk,jj]],v[[ii,kk,jj]]},{ii,1,dims[[1]]},{jj,1,dims[[3]]},{kk,1,dims[[2]]}]
]
];
ZonalWind[name_,OptionsPattern[]]:=Module[{u,nlat,alt,res},
u=LoadDiagfi[name,"u",TimeAve->OptionValue[TimeAve]];
alt=LoadDiagfi[name,"altitude"]*3.68856/OptionValue[Gravity0]*191/OptionValue[MolarMass0];
u=Total[u[[All,All,1;;-2]],{3}]/(Dimensions[u][[-1]]-1);
nlat=Length[u[[1]]];
res=Flatten[Table[{((ii-1)/(nlat-1)-0.5)*180,alt[[zz]],u[[zz,ii]]},{ii,1,nlat},{zz,1,Length[alt]}],1]
];
ZonalMeanCut[name_,var_,OptionsPattern[]]:=Module[{raw,nlat,alt,res},
raw=LoadDiagfi[name,var,TimeAve->OptionValue[TimeAve]];
alt=LoadDiagfi[name,"altitude"]*3.68856/OptionValue[Gravity0]*191/OptionValue[MolarMass0];
raw=Total[raw[[All,All,1;;-2]],{3}]/(Dimensions[raw][[-1]]-1);
nlat=Length[raw[[1]]];
res=Flatten[Table[{((ii-1)/(nlat-1)-0.5)*180,alt[[zz]],raw[[zz,ii]]},{ii,1,nlat},{zz,1,Length[alt]}],1]
];
MeridionalCut[name_,var_,index_,OptionsPattern[]]:=Module[{raw,nlat,alt,res},
raw=LoadDiagfi[name,var,TimeAve->OptionValue[TimeAve]];
alt=LoadDiagfi[name,"altitude"]*3.68856/OptionValue[Gravity0]*191/OptionValue[MolarMass0];
raw=raw[[All,index,All]];
nlat=Length[raw[[1]]];
res=Flatten[Table[{((ii-1)/(nlat)-0.5)*360,alt[[zz]],raw[[zz,ii]]},{ii,1,nlat},{zz,1,Length[alt]}],1]
];
StreamFunction[name_,OptionsPattern[]]:=Module[{psi,nlat,alt,res},
psi=Map[Flatten,LoadDiagfi[name,OptionValue[Variable]][[1]]];
(*psi=Map[Which[#> 1,Log[10,#],#<-1,-Log[10,-#],1==1,0]&,psi,{2}];*)
alt=LoadDiagfi[name,"altitude"]*3.68856/OptionValue[Gravity0]*191/OptionValue[MolarMass0];
nlat=Length[psi[[1]]];
res=Flatten[Table[{((ii-1)/(nlat-1)-0.5)*180,alt[[zz]],psi[[zz,ii]]},{ii,1,nlat},{zz,1,Length[alt]}],1]
]
AngularMomentum[name_]:=Module[{control,radius,g,u,lat,ap,bp,ps,area,totarea,pressures,dP,angmom,dims,time},
control=Import[name,{"Datasets","controle"}];
radius=control[[5]];
g=control[[7]];
u=LoadDiagfi[name,"u"];
dims=Dimensions[u];
lat=LoadDiagfi[name,"latitude"];u=If[Length[dims]==4,Map[#*Cos[lat*Degree]&,u,{2}][[All,All,All,1;;-2]],Map[#*Cos[lat*Degree]&,u][[All,All,1;;-2]]];
ap=LoadDiagfi[name,"ap"];
bp=LoadDiagfi[name,"bp"];
ps=LoadDiagfi[name,"ps"];
ps=If[Length[dims]==4,ps[[All,All,1;;-2]],ps[[All,1;;-2]]];
area=Reverse[Import[name,{"Datasets", "aire"}]][[All,1;;-2]];
pressures=If[Length[dims]==4,
Map[Function[y,Map[Function[x,y*x],bp]],ps]+Table[Map[Table[#,{dims[[-2]]},{dims[[-1]]-1}]&,ap],{dims[[1]]}],
Map[Function[x,ps*x],bp]+Map[Table[#,{dims[[-2]]},{dims[[-1]]-1}]&,ap]];
dP=If[Length[dims]==4,Map[Table[#[[ll]]-#[[ll+1]],{ll,dims[[2]]}]&,pressures],Table[pressures[[ll]]-pressures[[ll+1]],{ll,dims[[2]]}]];
angmom=If[Length[dims]==4,Map[Total[#*area,2]&,Total[dP*u,{2}]],Total[Total[dP*u,{1}]*area,{1,2}]];
time=LoadDiagfi[name,"Time"]+control[[4]];
Transpose[{time,angmom*radius/g}]
];


invmollweide[{x_,y_}]:=With[{theta=ArcSin[y]},{Pi (x)/(2 Cos[theta]),ArcSin[(2 theta+Sin[2 theta])/Pi]}];
fc[phi_]:=Block[{theta},If[Abs[phi]==Pi/2,phi,theta/.FindRoot[2 theta+Sin[2 theta]==Pi Sin[phi],{theta,phi}]]];
cart[{lambda_,phi_}]:=With[{theta=fc[phi]},{2/Pi*lambda Cos[theta],Sin[theta]}]
colorbar[{min_,max_},colorFunction_: Automatic,divs_: 15]:=DensityPlot[y,{x,0,0.1},{y,min,max},AspectRatio->15,PlotRangePadding->0,ColorFunction->colorFunction,PlotPoints->{2,divs},MaxRecursion->0,FrameTicks->{None,Automatic,None,None},FrameStyle->Large];
