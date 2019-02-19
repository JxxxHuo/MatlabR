# New MatlabR 

MatlabR is to use R in Matlab, which builds the bridge between Matlab and R. The original git of [brian-lau's MatlabR] (https://github.com/brian-lau/MatlabR) code has too many issues and can not work well and its introduction is too simple. I modified the MatR.m file and wrote a new introduction and demo (at least guaranteed for Windows). 

MatlabR is based on [s-u's Java Rengine](https://github.com/s-u/REngine). As its name shown, MatlabR.m code works in Matlab to use R functions. In R console, you need to install “Rserve” library package. Because “MatlabR” and “Rserve” work in Client-Server mode. MatlabR and Rserve can work in either one single computer or two separate ones. Thus you can have multiple Matlabs in one or more computers remotely running parallel at the same time to communicate with a single R host. 

It is important to no more than one MatR connection with R console is allowed for a port number in one Matlab terminal, otherwise your Matlab windows will hang on busy. 

To use MatlabR, you need to configure your computer environment correctly. 

# Installation Steps:

## 1. Java version

As the Java Rengine was updated, some MatlabR functions lost their fundation. Hereby, I compiled the new version of Java Rengine, you can find them in the “lib” folder. The java version embeded in Matlab may not be consistent with the lib jar file, which requires Java version above 1.8.0 and may induce a java version error, so you need to use an external Java with version number higher than 1.8.0_111. The details of how to make Matlab use external Java can be seen in my [wiki](https://github.com/JxxxHuo/MatlabR/wiki/How-to-change-Matlab-Java-version). Generally you can do it by adding a new computer environment varaince ‘MATLAB_JAVA’, which refers to the path of jre.

## 2. Javaclasspath
To load the java class successfully into matlab, I suggest you to use the following static load method rather than a dynamic load method, otherwise you will get a “MatR/connect” failure.

In matlab command window run 
```
cd(prefdir); 
edit javaclasspath.txt
```
Then add REngine.jar and Rserve.jar's fullptath to javaclasspath.txt like:
```
D:\MatlabR\lib\REngine.jar
D:\MatlabR\lib\RserveEngine.jar
```
Then you restart your Matlab to initialize the new Javaclasspath. Thereafter, you won't be bothered by the Javaclasspath any more. 

## 3. MatlabR path
Don’t forget to add your MatlabR folder path before using MatlabR by Matlab Command:
`addpath ‘D:\MatlabR’` 

## 4. R host IP address and Rserve Port
You should know where is your R console and record the host’s **IP address** and **Rserve port** in MatR.m.
```
 properties
      host = 'localhost'  % You should give your R console IP address here
      port = 6311         % You should define your Rserve port here
   end
```

To start Rserve in R console, you can run the following commands in R console:

```
install.packages ('Rserve')
Library(Rserve)
Rserve()  or Rserve(port=6311)
```
# How to avoid freezing/hang up

Begin: at the beginning of MatlabR, you can simply establish a connection by 

```
r=MatR()
```
After it, check whether `r.isConnected` is 1, if not `r.connect`, usually, r.isConnected is 1 by default.
Warning! If `r.isConnected` is already 1, you use r.connect, your Matlab will hang on busy! 

Then you can run some routines like 
```
r.eval('seq(1,10)');
r.result.asDoubles()
   ```
   End: you must be careful to release r connection when the r connection is over. I suggest you use **`r.kill`**, where I did some change to the original one. Warning! You should not start a new connection when the old one exists for the same , otherwise you will find your Matlab hang on busy there. 
   ```
   r.kill
   clear r
  ```  
   ## An example of Matrix calculation by R in the command line of Matlab
   
   ```
   >> r=MatR();
R version 3.5.1 (2018-07-02)
>> x=[1 2;3 4]

x =

     1     2
     3     4

>> r.assign('y',x);
>> r.eval('z=y*2');
>> z=r.result.asDoubleMatrix();
>> z

z =

     2     4
     6     8

>> r.kill;
>> clear r
   
    
   ```

---------------------------------------------------------------------------------------------------------------------------------
If you have issues, please feel free to let me know. I am happy to fix them.  






