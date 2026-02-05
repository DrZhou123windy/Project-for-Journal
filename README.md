IPEM(Improved Pore Evaluation Model)

What is this repository for?
IPEM(Improved Pore Evaluation Model) is a software program for Reservoir Porosity Structure Prediction.
*** Please cite the software program as: *** Zhou B. L., Zhang J. G., Yong Z. S., IPEM: Application and Scalability Potential Evaluation of an Improved Pore Evaluation Model Based on Machine Learning in Reservoir Porosity Structure Prediction, Computers & Geoscience.

How do I get set up?
See the tutorial webpage: https://www.mathworks.com/help/install, install Matlab software. In alternative use any other machine with Matlab installed.

Usage
1) Choose one of the following:
   For windows users: go in the dist directory and double click on Matlab.exe.
   For Linux users：see https://ww2.mathworks.cn/support/search.html?q=Linux guidance, go in the dist directory and double click on Matlab.exe or, from a terminal, enter Matlab commands.
2) After some seconds the Matlab software window open.Please do not use violence during this period to avoid app crashing.
3) Import the required validation data or independent variables to be calculated, which can be manually dragged into the variable area or operated using the import button on the software platform.
4) Place the project folder in the Matlab search path to ensure that Matlab can recognize the program, then calculate based on the set independent variables, the calculation program is located in the "Calculating process" folder:
   evaluation_for_real: calculation based on measured data.
   evaluation_for_m: m is the theoretical calculation value（or measured value）of this innovation model, and it is necessary to consider adding this variable during the calculation.
   evaluation_for_reverse：the final model solution with mud content correction introduced, eliminating the interference of formation resistivity, improved accuracy is currently an effective solution for predicting reservoir pore heterogeneity.
   % Assuming the function is defined as [o1, o2, o3] = myFunction(input1, input2). The command line can output the following statement [o1, o2, o3] = myFunction(input1, input2); [o1, o2] = myFunction(input1, input2); or o2 = myFunction(input1, input2);
   % Or create a function handle for myFuncHandle = @myFunction; The command line can output the following statement [o1, o2, o3] = myFuncHandle(input1, input2); or [o1, o2] = myFuncHandle(input1, input2);
   Function"evaluation_for_real" and function"evaluation_for_m", both calculation models output three variables: tortuosity, radius, and cefp(Comprehensive evaluation factor of pore structure).
6) Scalability Potential Evaluation see "evaluation_for_potential.m" in "Scalable potential assessment" folder, it contains KT: effective zoning factor, Kps: pore morphology factor, S: specific surface area, J: lithologic index and HT：characteristic factor of Tiab flow unit needs calculating.
   % Partial parameter calculations require the intervention of the cefp variable. Please calculate the cefp value first.
7) The relationship between cefp and scalable potential validation parameters can be found in the "p and xx m=xx" folder of the project folder "Project for Journal", and corresponding validation functions have been written for each pair of relationships.
8) The verification procedure for the relationship between a and m can be found in project folder "a and m", before operation, please ensure that the file path can be recognized by Matlab. The data of a and m have been synchronized and uploaded. Please review them in the project folder.
9) Considering that some machine equipment's Matlab versions are early versions and do not include the algorithms required for this study, they have been specially written for learning and communication purposes, see folder "Precompiled code (for MATLAB early versions (2008b and earlier))".Please debug before use to ensure that it can run normally on the device.

Who do I talk to?
Dr.Zhou, Northwest University
*** Zblscisp1st@outlook.com. ***

License
Copyright (C) 2026 Dr.Zhou This program is free software: you can redistribute it and/or modify it under the terms of the MIT License as published by the Free Software Foundation, either version of the License, or any later version.
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the MIT License for more details. 
You should have received a copy of the MIT License along with this program. If not, see https://opensource.org/licenses/MIT.
