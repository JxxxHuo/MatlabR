# New MatlabR

The original git of [brian-lau's MatlabR] (https://github.com/brian-lau/MatlabR) code has too many issues and can not work well and its introduction is too simple. I (Jxxx Huo) modified the MatR.m file and wrote a new introduction and demo. 

MatlabR is based on [Java Rengine](https://github.com/s-u/REngine). As its name shown, MatlabR.m code only works in Matlab. In R console, you need to install “Rserve” library package. Because “MatlabR” and “Rserve” work in Client-Server mode. MatlabR and Rserve can work in either one single computer or two separate ones. Thus you can have multiple Matlabs in one or more computers remotely running parallel at the same time to communicate with a single R host. 

It is important to no more than one MatR connection with R console is allowed for a port number in one Matlab terminal, otherwise your Matlab windows will hang on busy. 

To use MatlabR, you need to configure your computer environment correctly. 

# Installation Steps:

1.	## Java version

As the Java Rengine was updated, some MatlabR functions lost their fundation. Hereby, I compiled the new version of Java Rengine, you can find them in the “lib” folder. The java version embeded in Matlab may not be consistent with the lib jar file, which requires Java version above 1.8.0 and may induce a java version error, so you need to use an external Java with version number higher than 1.8.0_111. The details of how to make Matlab use external Java can be seen in wiki [page]. Generally you can do it by adding a new computer environment varaince ‘MATLAB_JAVA’, which refers to the path of jre.

2.	## Javaclasspath
To load the java class successfully into matlab, I suggest you to use the following static load method rather than a dynamic load method, otherwise you will get a “MatR/connect” failure.

In matlab command window run 
`cd(prefdir); `
`edit javaclasspath.txt`     
Then add REngine.jar and Rserve.jar's fullptath to javaclasspath.txt like:

`D:\MatlabR\lib\REngine.jar`
`D:\MatlabR\lib\RserveEngine.jar`

3.	## MatlabR path
Don’t forget to add your MatlabR folder path before using MatlabR by Matlab Command:
`addpath ‘D:\MatlabR’` 

4.	## R host IP address and Rserve Port
You should know where is your R console and record the host’s **IP address** and **Rserve port**.

To start Rserve in R console, you can run the following commands in R console:

```
install.packages ('Rserve')
Library(Rserve)
Rserve()  or Rserve(port=6311)`
```
# How to avoid freezing/hang up

1. Begin and End

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

---------------------------------------------------------------------------------------------------------------------------------

Possible Problem

Java version problem:

When you get error like “...Java components are not installed ...”, this is probably due to java version deprecated. You need to change Matlab java version by installing an updated java jdk/jre outside of Matlab:

1. Download the JVM Version You Want to Use
You can download the Java Virtual Machine from the Web site http://java.sun.com/j2se/downloads.html.
2. Locate the Root of the Run-time Path for this Version
To get MATLAB to use the version you have just downloaded, you must first find the root of the run-time path for this JVM, and then set the MATLAB_JAVA environment variable to that path. To locate the JVM run-time path, find the directory in the Java installation tree that is one level up from the directory containing the file rt.jar. This may be a subdirectory of the main JDK install directory. (If you cannot find rt.jar, look for the file classes.zip.)

For example, if the JDK is installed in D:\jdk1.2.1 on Windows and the rt.jar file is in D:\jdk1.2.1\jre\lib, you would set MATLAB_JAVA to the directory one level up from that: D:\jdk1.2.1\jre.

On UNIX, if the JDE is installed in /usr/openv/java/jre/lib and the rt.jar is in /usr/openv/java/jre/lib, set MATLAB_JAVA to the path /usr/openv/java/jre.

3. Set the MATLAB_JAVA Environment Variable to this Path
The way you set or modify the value of the MATLAB_JAVA variable depends on which platform you are running MATLAB on. Windows NT/2000/XP.   To set MATLAB_JAVA on Windows NT, Windows 2000, or Windows XP,
a)	Click Settings in the Start Menu
b)	Choose Control Panel
c)	Click System
d)	Choose the Environment tab on Windows NT or the Advanced tab on Windows 2000 or XP, and then click the Environment Variables button.
e)	You now can set (or add) the MATLAB_JAVA system environment variable to the path of your JVM.
f)	For UNIX/Linux.   To set MATLAB_JAVA on UNIX or Linux systems,Use the setenv command, as shown here:
setenv MATLAB_JAVA <path to JVM>

------------------------------------------------------------------






