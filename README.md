# Helm-local-shortcuts
A collection of bash scripts that I found useful when developing Helm charts and testing locally.  

Repetitive tasks that I use in my day to day coding are now compiled into a light command to reduce time I spend testing.

helm-test helps me displaying the rendering outputs in my helm charts, it packs the chart, uploads it into my repository, change to the test folder and downloads it again for me and render the manifests with a samples value in my test folder.  

Sometimes I need to debug pushed charts by my pipelines and Helm pull is the shortcut to pulll, export and render locally.

## Preconditions

I store my helm charts with 2 folders

![image](https://user-images.githubusercontent.com/17276837/143606207-5edeeec9-d303-4def-8441-db8c11f345ec.png)
    
My chart is in the Helm directory, and the test directory is the place to require the chart as a dependency and test the rendering with values or with conditionals to make sure that all the flows produce valid manifests.  

## Install

Just grab the `.sh` file of the script you want to use and either drop it in your binaries folder or leave it in a dir of your choice. Remember to add the executable permission with `chmod + x` and call it with the positional parameters needed.  

Change variables inside scripts with your own data if you need to (like working directories or repository url).  

## Helm Test

The script will navigate to your helmd folder, update the dependencies, save and push the chart. Then, change into test folder, download the dependency removing first the charts folder in case you want to test the same version as previously. And finally, it send rendered templates to a expected-output.yaml file.

```
helm-test my-cool-chart 1.2.0
```

## Helm pull

Helm pull is basically a pull from the repository with an export and a quick render to the console of the manifests. If no positional parameters are passed, the default ones are going to be used. Perfect for time when you are recurrently testing a chart in particular.

```
helm-pull my-cool-chart 1.2.0
```
